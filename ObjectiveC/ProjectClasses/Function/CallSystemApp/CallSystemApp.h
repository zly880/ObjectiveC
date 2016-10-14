//
//  CallSystemApp.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallSystemApp : NSObject

/**
 获取模块单例
 
 @return 实例对象
 */
+ (CallSystemApp *)shareInstance;

/**
 打开浏览器
 
 @param urlString 网络链接
 */
- (void)openSafari:(NSString *)urlString;

/**
 拨打电话
 
 @param phoneNumber 电话号码
 */
- (void)callWithPhoneNumber:(NSString *)phoneNumber;

@end
