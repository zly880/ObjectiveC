//
//  LoginController.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化显示
    self.navigationItem.title = @"登录";
    
    // 初始化登录按钮
    CGFloat space = 20;
    CGFloat height = 40;
    CGFloat width = CGRectGetWidth(self.view.bounds) - space * 2;
    CGRect frame = CGRectMake(space, CGRectGetMaxY(self.view.frame) - (space + height) * 3, width, height);
    _QQLoginBtn = [self createLoginButton:@"QQ登录" frame:frame];
    frame = CGRectMake(space, CGRectGetMaxY(_QQLoginBtn.frame) + space, width, height);
    _WXLoginBtn = [self createLoginButton:@"微信登录" frame:frame];
    frame = CGRectMake(space, CGRectGetMaxY(_WXLoginBtn.frame) + space, width, height);
    _WBLoginBtn = [self createLoginButton:@"微博登录" frame:frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建登录按钮

- (UIButton *)createLoginButton:(NSString *)title frame:(CGRect)frame {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundColor:APPCOLOR_TINT];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:APPCOLOR_WHITE forState:UIControlStateNormal];
    [button.titleLabel setFont:APPFONT_MID];
    [button.layer setCornerRadius:4];
    [button.layer setMasksToBounds:YES];
    [button addTarget:self action:@selector(buttonHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    return button;
}

#pragma mark - 按钮处理

- (void)buttonHandler:(UIButton *)button {
    
    if (button == _QQLoginBtn) {
    } else if (button == _WXLoginBtn) {
    } else if (button == _WBLoginBtn) {
    }
    
    // 从登陆页面回退到当前页面
    [self.navigationController popViewControllerAnimated:YES];
}

@end
