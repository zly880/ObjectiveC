//
//  Notification.m
//  ObjectiveC
//
//  Created by CLee on 2016/10/13.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "Notification.h"
#import <UserNotifications/UserNotifications.h>

@interface Notification () <UNUserNotificationCenterDelegate>

@end

@implementation Notification

/**
 获取模块单例
 
 @return 实例对象
 */
+ (Notification *)shareInstance {
    
    static Notification *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[Notification alloc] init];
    });
    
    return instance;
}

/**
 注册通知
 */
- (void)registerNotification {
    
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
        //在block中会传入布尔值granted，表示用户是否同意
        if (granted) {
            //如果用户权限申请成功，设置通知中心的代理
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        }
    }];
}

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
                         userInfo:(NSDictionary *)userInfo {
    
    // 通知内容类
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    // 设置通知请求发送时 app图标上显示的数字
    content.badge = @2;
    // 默认的通知提示音
    content.sound = [UNNotificationSound defaultSound];
    // 设置通知的标题
    content.title = title;
    // 设置通知的副标题
    content.subtitle = subTitle;
    // 设置通知的内容
    content.body = body;
    if (imagePath.length > 0) {
        //创建图片附件
        UNNotificationAttachment *attach = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttach" URL:[NSURL fileURLWithPath:imagePath] options:nil error:nil];
        content.attachments = @[attach];
    }
    // 设置通知传递的数据结构
    content.userInfo = userInfo;
    // 设置5S之后执行
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"NotificationDefault" content:content trigger:trigger];
    //添加通知请求
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        [Toast showMessage:@"添加通知成功！"];
    }];
}

#pragma mark - UNUserNotificationCenterDelegate

// 在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    // 1. 处理通知
    // 2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound);
}

// 接收到本地通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    
}

@end
