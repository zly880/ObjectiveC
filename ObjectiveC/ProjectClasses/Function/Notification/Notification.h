//
//  Notification.h
//  ObjectiveC
//
//  Created by CLee on 2016/10/13.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject

/**
 获取模块单例
 
 @return 实例对象
 */
+ (Notification *)shareInstance;

/**
 注册通知
 */
- (void)registerNotification;

/**
 显示通知
 
 @param title     标题
 @param subTitle  子标题
 @param body      内容，注意：没有内容的通知只会在通知栏显示，不会弹alert
 @param imagePath 图片
 @param userInfo  传输数据
 */
- (void)showNotificationWithTitle:(NSString *)title
                         subTitle:(NSString *)subTitle
                             body:(NSString *)body
                        imagePath:(NSString *)imagePath
                         userInfo:(NSDictionary *)userInfo;

@end
