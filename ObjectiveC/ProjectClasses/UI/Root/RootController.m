//
//  RootController.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "RootController.h"
#import "HomeController.h"
#import "MineController.h"

@interface RootController ()

@end

@implementation RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 主色调
    self.tabBar.tintColor = APPCOLOR_TINT;
    
    // 图片显示模式
    UIImageRenderingMode imageMode = UIImageRenderingModeAlwaysOriginal;
    // 初始化Home
    UIImage *image = [[UIImage imageNamed:@"Root_home"] imageWithRenderingMode:imageMode];
    UIImage *selectImage = [[UIImage imageNamed:@"Root_homeSelect"] imageWithRenderingMode:imageMode];
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:image selectedImage:selectImage];
    homeItem.tag = 0;
    HomeController *homeVc = [[HomeController alloc] init];
    homeVc.tabBarItem = homeItem;
    homeVc.navigationItem.title = @"Home";
    // 初始化Mine
    image = [[UIImage imageNamed:@"Root_mine"] imageWithRenderingMode:imageMode];
    selectImage = [[UIImage imageNamed:@"Root_mineSelect"] imageWithRenderingMode:imageMode];
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"Mine" image:image selectedImage:selectImage];
    mineItem.tag = 1;
    MineController *mineVc = [[MineController alloc] init];
    mineVc.tabBarItem = mineItem;
    mineVc.navigationItem.title = @"Mine";
    // 设置子控制器
    self.viewControllers = @[homeVc, mineVc];
    
    // 默认显示Home
    [self setSelectedViewController:homeVc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 通过此方法能够让子控制器的 NavigationItem 替换为 TabBarController 的 NavigationItem
- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    [super setSelectedViewController:selectedViewController];
    
    if (nil != selectedViewController.navigationItem.titleView) {
        self.navigationItem.titleView = selectedViewController.navigationItem.titleView;
    } else {
        selectedViewController.navigationItem.titleView = nil;
        self.navigationItem.titleView = nil;
        self.navigationItem.title = selectedViewController.navigationItem.title;
    }
    self.navigationItem.leftBarButtonItem = selectedViewController.navigationItem.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = selectedViewController.navigationItem.rightBarButtonItem;
}

@end
