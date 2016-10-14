//
//  Config.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#ifndef Config_h
#define Config_h

// 用户定义的设备名称
#define PHONE_NAME      [UIDevice currentDevice].name
// APP运行的设备模型
#define RUN_MODEL       [UIDevice currentDevice].model
// 设备模型
#define DEVICE_MODEL    [UIDevice currentDevice].localizedModel
// 操作系统名称
#define SYSTEM_NAME     [UIDevice currentDevice].systemName
// 操作系统版本号
#define SYSTEM_VERSION  [UIDevice currentDevice].systemVersion
// 屏幕比率
#define SCREEN_SCALE    [[UIScreen mainScreen] scale]

// APP唯一标识
#define APP_UUID        [UIDevice currentDevice].identifierForVendor.UUIDString
// APP状态
#define APP_STATE       [UIApplication sharedApplication].applicationState
// key window
#define KEYWINDOW       [UIApplication sharedApplication].keyWindow
// 工程的单例
#define APPDELEGATE     (AppDelegate *)[[UIApplication sharedApplication] delegate]
// APP发布版本号
#define APP_VERSION_P   [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
// APP开发版本号
#define APP_VERSION_B   [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]
// APP名称
#define APP_NAME        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
// APP ID
#define APP_ID          @"3435098421"
// APPStore 链接
#define APPSTORE_STRING [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", APPId]

#endif /* Config_h */
