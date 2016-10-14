//
//  ModelEngine.m
//  ObjectiveC
//
//  Created by CLee on 16/10/10.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "ModelEngine.h"

@implementation ModelEngine

// 获取模块单例
+ (ModelEngine *)shareInstance {
    
    static ModelEngine *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[ModelEngine alloc] init];
    });
    
    return instance;
}

#pragma mark - 数据保存在文件中

/**
 获取文件路径
 
 @param fileName 文件名称
 
 @return 文件路径
 */
- (NSString *)getFilePath:(NSString *)fileName {
    
    return [[NSString documentPath] stringByAppendingPathComponent:fileName];
}

/**
 写入数据
 
 @param dictionary 数据
 @param fileName   文件名称
 
 @return 写入数据是否成功
 */
- (BOOL)saveDataToFile:(NSDictionary *)dictionary
              fileName:(NSString *)fileName {
    
    [self clearFile:fileName];
    BOOL isSucess = [dictionary writeToFile:[self getFilePath:fileName] atomically:YES];
    
    return isSucess;
}

/**
 读取数据
 
 @param fileName 文件名称
 
 @return 数据
 */
- (NSDictionary *)loadDataFromFile:(NSString *)fileName {
    
    NSString *path = [self getFilePath:fileName];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return dictionary;
}

/**
 清除文件
 
 @param fileName 文件名称
 
 @return 标识清除文件是否成功
 */
- (BOOL)clearFile:(NSString *)fileName {
    
    NSString *path = [self getFilePath:fileName];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [dict removeAllObjects];
    BOOL isSuccess = [dict writeToFile:path atomically:YES];
    
    return isSuccess;
}

@end
