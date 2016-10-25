//
//  AppDelegate.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "AppDelegate.h"
#import "RootController.h"
#import "NavController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 初始化界面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RootController *root = [[RootController alloc] init];
    NavController *rootNav = [[NavController alloc] initWithRootViewController:root];
    self.window.rootViewController = rootNav;
    [self.window makeKeyAndVisible];
    // 注册通知
    [[Notification shareInstance] registerRemoteNotification];
    [[Notification shareInstance] registerLocalNotification];
    // 请求定位
    [[Location shareInstance] locationService:YES fromVc:self];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    // 进入前台取消应用消息图标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 触摸事件

// 触摸开始时执行
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

// 触摸移动时候执行
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

// 触摸意外取消时执行
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

// 触摸结束时执行
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - 运动事件

// 运动开始时执行
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

// 运动被意外取消时执行
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

// 运动结束时执行
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

#pragma mark - 远程控制事件

// 接收到远程控制事件时执行
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    
}

#pragma mark - 自定义方法

@end
