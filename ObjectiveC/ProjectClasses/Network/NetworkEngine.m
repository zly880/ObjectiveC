//
//  NetworkEngine.m
//  ObjectiveC
//
//  Created by CLee on 16/10/10.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "NetworkEngine.h"

@interface NetworkEngine ()

@property (nonatomic, assign) RequestType requestType;

@end

@implementation NetworkEngine

/**
 获取模块单例
 
 @return 实例对象
 */
+ (NetworkEngine *)shareInstance {
    
    static NetworkEngine *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[NetworkEngine alloc] init];
    });
    
    return instance;
}

/**
 检查网络状态
 
 @param result YES：有网；NO：没网
 */
+ (void)networkValid:(void (^)(BOOL networkValid))result {
    
    if (result) {
        // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        // 检测网络连接的单例,网络变化时的回调方法
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
                result(YES);
            } else {
                result(NO);
            }
        }];
    }
}

#pragma mark - 参数设置，私有接口

// 配置url
- (NSMutableString *)configUrlWithPath:(NSString *)path {
    
    NSMutableString *url = [NSMutableString string];
    switch (_requestType) {
        case RequestTypeNormal:
            [url appendString:DomainName];
            break;
        case RequestTypeUploadImage:
            [url appendString:DomainNameUploadImage];
            break;
        case RequestTypeUploadFile:
            [url appendString:DomainNameUploadFile];
            break;
        case RequestTypeDownload:
            [url appendString:DomainNameDownloadFile];
            break;
        default:
            break;
    }
    [url appendString:path];
    
    return url;
}

// 配置参数
- (NSMutableDictionary *)configParameters:(NSDictionary *)parameter isUserToken:(BOOL)isUserToken {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSDictionary *appClient = @{@"appId" : APP_ID,
                                @"appKey" : APP_UUID,
                                @"appVersion" : APP_VERSION_P,
                                @"appBuild" : APP_VERSION_B,
                                @"systemName" : SYSTEM_NAME,
                                @"systemVersion" : SYSTEM_VERSION,
                                @"timeStamp" : [NSDate date]};
    [dictionary setObject:appClient forKey:@"appClient"];
    [dictionary setObject:parameter forKey:@"parameter"];
    if (isUserToken == YES) {
        [dictionary setValue:@"15228895234" forKey:@"userId"];
        [dictionary setValue:@"1234567890" forKey:@"token"];
    }
    
    return dictionary;
}

// 设置请求头
- (AFHTTPSessionManager *)setRequestHeader {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager.requestSerializer setTimeoutInterval:__TIMEOUT__];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"Device-Type"];
    if (_requestType == RequestTypeNormal) {
        [manager.requestSerializer setValue:@"application/json;charset=utf-8"
                         forHTTPHeaderField:@"Content-Type"];
    } else if (_requestType == RequestTypeUploadImage) {
        [manager.requestSerializer setValue:@"multipart/form-data"
                         forHTTPHeaderField:@"Content-Type"];
    }
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return manager;
}

#pragma mark - 数据处理，私有接口

/**
 网络请求成功，解析数据
 
 @param response  网络请求返回的数据
 @param dataModel 数据model名称
 @param success   回调block
 */
- (void)analyzeData:(id)response
          dataModel:(NSString *)dataModel
            success:(ResultSuccess)success {
    
    // 判断是否有返回数据
    if (response == nil) {
        success(NO, DataNone, nil);
        return;
    }
    
    NSLog(@"%@", response);
    
    // 参数解析
    NSDictionary *result;
    if ([NSJSONSerialization isValidJSONObject:response]) {
        result = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                 options:NSJSONReadingMutableContainers
                                                   error:nil];
    } else if ([response isKindOfClass:[NSDictionary class]]) {
        result = [response copy];
    } else {
        result = nil;
    }
    if (result == nil) {
        success(NO, DataError, nil);
        return;
    }
    
    // 参数分析
    BOOL bValue = [[result objectForKey:Code] isEqualToString:SuccessCode];
    NSString *message = [response objectForKey:Message];
    NSDictionary *content = [response objectForKey:Content];
    if (bValue == YES && dataModel.length > 0) {
        Class class = NSClassFromString(dataModel);
        NSObject *object = [[class alloc] init];
        if ([object isKindOfClass:[JSONModel class]]) {
            JSONModel *model = (JSONModel *)object;
            model = [model initWithDictionary:content error:nil];
            success(bValue, message, model);
        } else {
            success(NO, DataNeedJSON, nil);
        }
    } else {
        success(NO, message, content);
    }
}

#pragma mark - HTTP 请求

/**
 HTTP请求
 
 @param path          路径
 @param params        参数
 @param isUserToken   YES表示需要验证登录信息，NO表示不需要验证登录信息
 @param isPost        YES表示POST请求，NO表示GET请求
 @param isShowLoading YES表示显示loading，NO表示不显示loading
 @param dataModel     请求成功返回的数据model
 @param success       成功回调
 @param failure       失败回调
 */
- (void)httpRequestWithPath:(NSString *)path
                     params:(NSDictionary *)params
                isUserToken:(BOOL)isUserToken
                     isPost:(BOOL)isPost
              isShowLoading:(BOOL)isShowLoading
                  dataModel:(NSString *)dataModel
                    success:(ResultSuccess)success
                    failure:(ResultFailure)failure {
    
    [NetworkEngine networkValid:^(BOOL networkValid) {
        if (networkValid == NO) {
            if (failure) {
                failure([[NSError alloc] init], NetError);
            }
            return;
        }
        
        _requestType = RequestTypeNormal;
        if (isShowLoading == YES) {
            [Toast showLoading:nil];
        }
        NSMutableString *urlString = [self configUrlWithPath:path];
        NSMutableDictionary *parameter = [self configParameters:params isUserToken:isUserToken];
        AFHTTPSessionManager *manager = [self setRequestHeader];
        if (isPost == YES) {
            NSURLSessionDataTask *task = [manager POST:urlString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"%lf", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    [self analyzeData:responseObject dataModel:dataModel success:success];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error, nil);
                }
            }];
            [task resume];
        } else if (isPost == NO) {
            NSURLSessionDataTask *task = [manager GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    [self analyzeData:responseObject dataModel:dataModel success:success];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error, nil);
                }
            }];
            [task resume];
        }
    }];
}

/**
 HTTP图片上传
 
 @param path          路径
 @param params        参数
 @param isUserToken   YES表示需要验证登录信息，NO表示不需要验证登录信息
 @param isShowLoading YES表示显示loading，NO表示不显示loading
 @param dataModel     请求返回的数据model名称
 @param imageName     图片名称
 @param image         图片
 @param success       成功回调
 @param failure       失败回调
 */
- (void)httpUploadImageWithPath:(NSString *)path
                         params:(NSDictionary *)params
                    isUserToken:(BOOL)isUserToken
                  isShowLoading:(BOOL)isShowLoading
                      dataModel:(NSString *)dataModel
                      imageName:(NSString *)imageName
                          image:(UIImage *)image
                        success:(ResultSuccess)success
                        failure:(ResultFailure)failure {
    
    [NetworkEngine networkValid:^(BOOL networkValid) {
        if (networkValid == NO) {
            if (failure) {
                failure([[NSError alloc] init], NetError);
            }
            return;
        }
        
        _requestType = RequestTypeUploadImage;
        if (isShowLoading == YES) {
            [Toast showLoading:nil];
        }
        
        [[self setRequestHeader] POST:[self configUrlWithPath:path]
                           parameters:[self configParameters:params isUserToken:isUserToken]
            constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                // 图片压缩到200K
                [formData appendPartWithFileData:UIImageJPEGRepresentation([image imageCompress:200], 1.0)
                                            name:@"image"
                                        fileName:imageName
                                        mimeType:@"image/jpeg"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"%lf", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    [self analyzeData:responseObject dataModel:dataModel success:success];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error, nil);
                }
            }];
    }];
}

#pragma mark - URL请求

@end
