//
//  Toast.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface Toast : NSObject

+ (void)showMessage:(NSString *)tipString;
+ (void)showLoading:(NSString *)tipString;
+ (void)showSuccess:(NSString *)tipString;
+ (void)showFailed:(NSString *)tipString;
+ (void)dismissShow;

#pragma mark - 自定义视图，延时消失

+ (void)showCustomView:(UIView *)view hideDelay:(CGFloat)delay;
+ (void)dismissShow:(UIView *)view;

#pragma mark - 错误提示视图

+ (UIView *)errorViewWithFrame:(CGRect)rect imageName:(NSString *)imageName title:(NSString *)title;

@end
