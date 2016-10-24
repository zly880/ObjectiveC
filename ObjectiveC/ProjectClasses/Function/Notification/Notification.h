//
//  Notification.h
//  ObjectiveC
//
//  Created by CLee on 2016/10/13.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SHOW_LOCAL_NOTIFICATION @"ShowLocalNotification"
#define IMAGE_ATTACH_ID         @"ImageAttachID"

@interface Notification : NSObject

/**
 获取模块单例
 
 @return 实例对象
 */
+ (Notification *)shareInstance;

#pragma mark - 本地通知

/**
 注册本地通知
 */
- (void)registerLocalNotification;

/**
 显示本地通知
 
 @param title     标题
 @param subTitle  子标题
 @param body      内容，注意：没有内容的通知只会在通知栏显示，不会弹alert
 @param imagePath 图片的本地路径，默认只显示一张
 @param userInfo  传输数据
 */
- (void)showLocalNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                             imagePath:(NSString *)imagePath
                              userInfo:(NSDictionary *)userInfo;

#pragma mark - 远程通知

/**
 注册远程通知
 */
- (void)registerRemoteNotification;

@end
