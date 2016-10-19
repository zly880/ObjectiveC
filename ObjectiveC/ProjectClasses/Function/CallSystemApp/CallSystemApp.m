//
//  CallSystemApp.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "CallSystemApp.h"

@implementation CallSystemApp

/**
 获取模块单例
 
 @return 实例对象
 */
+ (CallSystemApp *)shareInstance {
    
    static CallSystemApp *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[CallSystemApp alloc] init];
    });
    
    return instance;
}

/**
 打开浏览器
 
 @param urlString 网络链接
 */
- (void)openSafari:(NSString *)urlString {
    
    if (urlString == nil || urlString.length <= 0) {
        return;
    }
    
    if ([urlString hasPrefix:@"http://"] == NO && [urlString hasPrefix:@"https://"] == NO) {
        urlString = [NSString stringWithFormat:@"https://%@", urlString];
    }
    NSURL *URL = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:URL] == YES) {
        if (SYSTEM_VERSION.floatValue > 10.0) {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            }];
        } else {
            [[UIApplication sharedApplication] openURL:URL];
        }
    } else {
        [Toast showFailed:@"打开Safari失败"];
    }
}

/**
 拨打电话
 
 @param phoneNumber 电话号码
 */
- (void)callWithPhoneNumber:(NSString *)phoneNumber {
    
    if (phoneNumber == nil || phoneNumber.length <= 0) {
        return;
    }
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]];
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        if (SYSTEM_VERSION.floatValue > 10.0) {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            }];
        } else {
            [[UIApplication sharedApplication] openURL:URL];
        }
    } else {
        [Toast showFailed:@"拨打电话失败"];
    }
}

@end
