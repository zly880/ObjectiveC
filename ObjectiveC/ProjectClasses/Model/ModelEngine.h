//
//  ModelEngine.h
//  ObjectiveC
//
//  Created by CLee on 16/10/10.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelDefine.h"

@interface ModelEngine : NSObject

// 获取模块单例
+ (ModelEngine *)shareInstance;

#pragma mark - 数据保存在文件中

/**
 获取文件路径
 
 @param fileName 文件名称
 
 @return 文件路径
 */
- (NSString *)getFilePath:(NSString *)fileName;

/**
 写入数据
 
 @param dictionary 数据
 @param fileName   文件名称
 
 @return 写入数据是否成功
 */
- (BOOL)saveDataToFile:(NSDictionary *)dictionary
              fileName:(NSString *)fileName;

/**
 读取数据
 
 @param fileName 文件名称
 
 @return 数据
 */
- (NSDictionary *)loadDataFromFile:(NSString *)fileName;

/**
 清除文件
 
 @param fileName 文件名称
 
 @return 标识清除文件是否成功
 */
- (BOOL)clearFile:(NSString *)fileName;

@end
