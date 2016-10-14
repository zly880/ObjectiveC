//
//  WebViewController.m
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = _titleString ? _titleString : @"";
    [self initUI];
    [self startLoadWebview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 外部接口

- (void)initUI {
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.scalesPageToFit = NO;
    _webView.userInteractionEnabled = YES;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_webView];
}

- (NSString *)configContentString {
    
    if (_contentString.length > 0) {
        switch (_webViewType) {
            case WebViewType_Local:
                _contentString = [[NSBundle mainBundle] pathForAuxiliaryExecutable:_contentString];
                break;
            case WebViewType_Web:
                if (![_contentString hasPrefix:@"http://"] && ![_contentString hasPrefix:@"https://"]) {
                    _contentString = [NSString stringWithFormat:@"https://%@", _contentString];
                }
                break;
            case WebViewType_H5:
                break;
            default:
                break;
        }
    }
    
    return _contentString;
}

- (void)startLoadWebview {
    
    _contentString = [self configContentString];
    if (_contentString.length > 0) {
        switch (_webViewType) {
            case WebViewType_Local: {
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:_contentString]];
                [_webView loadRequest:request];
                break;
            }
            case WebViewType_Web: {
                NSURL *URL = [NSURL URLWithString:_contentString];
                NSURLRequest *request = [NSURLRequest requestWithURL:URL];
                [_webView loadRequest:request];
                break;
            }
            case WebViewType_H5: {
                [_webView loadHTMLString:_contentString baseURL:nil];
                break;
            }
            default:
                break;
        }
        [Toast showLoading:nil];
    }
}

- (void)configLeftButton {
    
    if ([_webView canGoBack] && ![_webView.request.URL.absoluteString containsString:[self configContentString]]) {
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)configRightButton {
    
}

#pragma mark - <UIWebViewDelegate>

// 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [Toast dismissShow];
    [self configRightButton];
    switch (_webViewType) {
        case WebViewType_Local:
            break;
        case WebViewType_Web:
            self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
            break;
        case WebViewType_H5:
            break;
        default:
            break;
    }
}

// 网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [Toast dismissShow];
    [self.view addSubview:[Toast errorViewWithFrame:self.view.bounds
                                          imageName:@"Default_icon"
                                              title:error.localizedDescription]];
}

@end
