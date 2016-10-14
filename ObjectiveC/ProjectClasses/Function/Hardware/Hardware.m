//
//  Hardware.m
//  ObjectiveC
//
//  Created by CLee on 16/10/8.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "Hardware.h"

@interface Hardware ()
{
    BatteryResult _batteryResult;
    NSTimer *_timer; // 电池检测专用计时器
}

@end

@implementation Hardware

/**
 获取模块单例
 
 @return 实例对象
 */
+ (Hardware *)shareInstance {
    
    static Hardware *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[Hardware alloc] init];
    });
    
    return instance;
}

/**
 屏幕亮度设置
 
 @param bright 亮度值为0.0-1.0
 */
- (void)screenBrightSetting:(CGFloat)bright {
    
    [[UIScreen mainScreen] setBrightness:bright];
}

/**
 获取当前的屏幕亮度
 
 @return 亮度值为0.0-1.0
 */
- (CGFloat)screenBright {
    
    return [UIScreen mainScreen].brightness;
}

/**
 电池监听
 
 @param check        是否监听电池
 @param timeInterval 监听时间间隔
 @param result       监听返回的结果
 */
- (void)checkBattery:(BOOL)check
        timeInterval:(CGFloat)timeInterval
              result:(BatteryResult)result {
    
    if (result) {
        _batteryResult = result;
    }
    if (check == YES) {
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(checkBattery)
                                                     name:UIDeviceBatteryStateDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(checkBattery)
                                                     name:UIDeviceBatteryLevelDidChangeNotification
                                                   object:nil];
        if (_timer == nil) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                      target:self
                                                    selector:@selector(checkBattery)
                                                    userInfo:nil
                                                     repeats:YES];
        }
    } else {
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIDeviceBatteryStateDidChangeNotification
                                                      object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIDeviceBatteryLevelDidChangeNotification
                                                      object:nil];
        if ( _timer != nil) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)checkBattery {
    
    if (_batteryResult) {
        _batteryResult([UIDevice currentDevice].batteryLevel, [UIDevice currentDevice].batteryState);
    }
}

/**
 设置灯的开关
 
 @param on YES 标识开灯，NO 标识关灯
 */
- (void)torchSetting:(BOOL)on {
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode:(on ? AVCaptureTorchModeOn : AVCaptureTorchModeOff)];
            [device unlockForConfiguration];
        }
    }
}

@end
