//
//  Toast.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "Toast.h"

@implementation Toast

+ (void)showMessage:(NSString *)tipString {
    
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD showImage:nil status:tipString];
}

+ (void)showLoading:(NSString *)tipString {
    
    [SVProgressHUD showWithStatus:tipString];
}

+ (void)showSuccess:(NSString *)tipString {
    
    [SVProgressHUD showSuccessWithStatus:tipString];
}

+ (void)showFailed:(NSString *)tipString {
    
    [SVProgressHUD showErrorWithStatus:tipString];
}

+ (void)dismissShow {
    
    [SVProgressHUD dismiss];
}

#pragma mark - 自定义视图，延时消失

+ (void)showCustomView:(UIView *)view hideDelay:(CGFloat)delay {
    
    [KEYWINDOW addSubview:view];
    KEYWINDOW.userInteractionEnabled = NO;
    [Toast performSelector:@selector(dismissShow:) withObject:view afterDelay:delay];
}

+ (void)dismissShow:(UIView *)view {
    
    KEYWINDOW.userInteractionEnabled = YES;
    [view removeFromSuperview];
}

#pragma mark - 错误提示视图

+ (UIView *)errorViewWithFrame:(CGRect)rect imageName:(NSString *)imageName title:(NSString *)title {
    
    UIView *errorView = [[UIView alloc] initWithFrame:rect];
    errorView.backgroundColor = APPCOLOR_WHITE;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.center = CGPointMake(errorView.center.x, errorView.center.y);
    [errorView addSubview:imageView];
    
    UILabel *titleLbel = [[UILabel alloc] init];
    titleLbel.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, CGRectGetWidth(errorView.bounds), 20);
    titleLbel.textAlignment = NSTextAlignmentCenter;
    titleLbel.textColor = APPCOLOR_GRAY;
    titleLbel.text = title;
    titleLbel.font = APPFONT_MID;
    [errorView addSubview:titleLbel];
    
    return errorView;
}

@end
