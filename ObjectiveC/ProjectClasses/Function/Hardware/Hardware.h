//
//  Hardware.h
//  ObjectiveC
//
//  Created by CLee on 16/10/8.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Hardware : NSObject

/**
 获取模块单例
 
 @return 实例对象
 */
+ (Hardware *)shareInstance;

/**
 屏幕亮度设置
 
 @param bright 亮度值为0.0-1.0
 */
- (void)screenBrightSetting:(CGFloat)bright;

/**
 获取当前的屏幕亮度
 
 @return 亮度值为0.0-1.0
 */
- (CGFloat)screenBright;

/**
 电池监听返回结果
 
 @param battertyLevel 电量0-1
 @param batteryState  电池状态
 */
typedef void (^BatteryResult)(CGFloat battertyLevel, UIDeviceBatteryState batteryState);
/**
 电池监听
 
 @param check        是否监听电池
 @param timeInterval 监听时间间隔
 @param result       监听返回的结果
 */
- (void)checkBattery:(BOOL)check
        timeInterval:(CGFloat)timeInterval
              result:(BatteryResult)result;

/**
 设置灯的开关
 
 @param on YES 标识开灯，NO 标识关灯
 */
- (void)torchSetting:(BOOL)on;

@end
