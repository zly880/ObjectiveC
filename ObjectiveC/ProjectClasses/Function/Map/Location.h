//
//  Location.h
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject

@property (nonatomic, strong) CLLocation *currentLocation; // 位置

/**
 获取模块单例
 
 @return 实例对象
 */
+ (Location *)shareInstance;

/**
 定位
 
 @param start  YES表示开启定位服务，NO表示关闭定位服务
 @param fromVc 来源控制器
 */
- (void)locationService:(BOOL)start fromVc:(id)fromVc;

/**
 测试距离
 
 @param location 目标位置
 
 @return 距离，单位“米”
 */
- (CGFloat)distance:(CLLocation *)location;

/**
 地理编码，根据地名确定地理坐标
 
 @param address 地名
 @param result  地理坐标，地址结构
 */
- (void)coordinateFromAddress:(NSString *)address
                       result:(void(^)(CLLocation *location, NSDictionary *addressDictionary))result;

/**
 反地理编码，根据地理坐标取得地名
 
 @param location 地理坐标
 @param result   包含地址信息的字典
 */
- (void)addressFromCLLocation:(CLLocation *)location
                       result:(void(^)(NSDictionary *addressDictionary))result;

@end
