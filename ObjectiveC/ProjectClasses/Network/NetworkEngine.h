//
//  NetworkEngine.h
//  ObjectiveC
//
//  Created by CLee on 16/10/10.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "JSONModel.h"
#import "NetworkDefine.h"

/**
 网络请求成功的回调
 
 @param isSuccess YES表示得到正确的数据，NO表示得到非正确的数据
 @param message   提示信息
 @param data      实际数据，继承于JSONModel的数据model
 */
typedef void(^ResultSuccess)(BOOL isSuccess, NSString *message, id data);
/**
 网络请求失败的回调
 
 @param error   错误信息
 @param message 本地提示
 */
typedef void(^ResultFailure)(NSError *error, NSString *message);

@interface NetworkEngine : NSObject

/**
 获取模块单例
 
 @return 实例对象
 */
+ (NetworkEngine *)shareInstance;

/**
 检查网络状态
 
 @param result YES：有网；NO：没网
 */
+ (void)networkValid:(void (^)(BOOL networkValid))result;

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
                    failure:(ResultFailure)failure;

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
                        failure:(ResultFailure)failure;

@end
