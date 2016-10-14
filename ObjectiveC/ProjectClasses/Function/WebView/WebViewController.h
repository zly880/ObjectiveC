//
//  WebViewController.h
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "BaseController.h"

typedef NS_ENUM(NSUInteger, WebViewType) {
    WebViewType_Local,
    WebViewType_Web,
    WebViewType_H5,
};

@interface WebViewController : BaseController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) WebViewType webViewType;
@property (nonatomic, strong) NSString  *titleString;
@property (nonatomic, strong) NSString  *contentString;
// 属性webViewType==WebViewType_Local contentString表示本地文件名称，包括后缀名
// 属性webViewType==WebViewType_Web contentString表示请求链接
// 属性webViewType==WebViewType_H5 contentString表示H5文本

#pragma mark - 外部接口

- (void)initUI;                     // 初始化UI
- (NSString *)configContentString;  // 配置链接
- (void)startLoadWebview;           // 开始加载
- (void)configLeftButton;           // 自定义导航栏左边按钮
- (void)configRightButton;          // 自定义导航栏右边按钮

@end
