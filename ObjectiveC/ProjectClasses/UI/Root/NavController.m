//
//  NavController.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "NavController.h"

@interface NavController ()

@end

@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // push跳转时隐藏底部Bar
    self.hidesBottomBarWhenPushed = NO;
    // 半透明开关
    self.navigationBar.translucent = NO;
    self.toolbar.translucent = NO;
    // 去掉导航栏黑线
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 主色调和背景颜色
    self.navigationBar.tintColor = APPCOLOR_WHITE;
    self.navigationBar.barTintColor = APPCOLOR_TINT;
    // 标题字号和颜色
    self.navigationBar.titleTextAttributes =  @{NSFontAttributeName : APPFONT_BIG,
                                                NSForegroundColorAttributeName : APPCOLOR_WHITE};
    // 定制返回按钮图片,这两个要一起用,为啥这么用，苹果言语不详
    self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"Nav_back"];
    self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"Nav_back"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - push / pop

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    // 设置返回按钮只显示图片，不显示标题
    viewController.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(popViewControllerAnimated:)];
}

@end
