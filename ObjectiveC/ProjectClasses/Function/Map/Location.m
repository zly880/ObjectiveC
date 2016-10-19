//
//  Location.m
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "Location.h"

@interface Location () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation Location

/**
 获取模块单例
 
 @return 实例对象
 */
+ (Location *)shareInstance {
    
    static Location *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[Location alloc] init];
        instance.locationManager = [[CLLocationManager alloc] init];
    });
    
    return instance;
}

/**
 定位
 
 @param start  YES表示开启定位服务，NO表示关闭定位服务
 @param fromVc 来源控制器
 */
- (void)locationService:(BOOL)start fromVc:(id)fromVc {
    
    // iOS9适配 需要在plist文件里面添加以下内容；
    // <key>NSLocationWhenInUseUsageDescription</key>
    // <string>ObjectiveC 请求定位权限</string>
    // <key>UIBackgroundModes</key>
    // <array>
    // <string>location</string>
    // </array>
    if (start == YES) {
        if ([CLLocationManager locationServicesEnabled] == NO) {
            [Toast showFailed:@"定位服务尚未打开，请设置打开！"];
        } else {
            [_locationManager requestWhenInUseAuthorization];
            // 设置代理
            _locationManager.delegate = self;
            // 定位频率和定位精度并不应当越精确越好，需要视实际情况而定，因为越精确越耗性能，也就越费电。
            // 设置定位精度
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            // 定位频率,十米定位一次
            _locationManager.distanceFilter = 10.0;
            // iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。
            _locationManager.allowsBackgroundLocationUpdates = YES;
            // 开始定位
            [_locationManager startUpdatingLocation];
        }
    } else {
        [_locationManager stopUpdatingLocation];
    }
}

// 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if (locations.count > 0) {
        [self locationService:NO fromVc:nil];
        _location = [locations firstObject];
        if (_CurrentLocation) {
            _CurrentLocation(_location);
        }
    }
}

/**
 测试距离
 
 @param location 目标位置
 
 @return 距离，单位“米”
 */
- (CGFloat)distance:(CLLocation *)location {
    
    return [_location distanceFromLocation:location];
}

/**
 地理编码，根据地名确定地理坐标
 
 @param address 地名
 @param result  地理坐标，地址结构
 */
- (void)coordinateFromAddress:(NSString *)address
                       result:(void(^)(CLLocation *location, NSDictionary *addressDictionary))result {
    
    [[[CLGeocoder alloc] init] geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocation *location = placemark.location;
        NSDictionary *addressDic = placemark.addressDictionary;
        if (result) {
            result(location, addressDic);
        }
    }];
}

/**
 反地理编码，根据地理坐标取得地名
 
 @param location 地理坐标
 @param result   包含地址信息的字典
 */
- (void)addressFromCLLocation:(CLLocation *)location
                       result:(void(^)(NSDictionary *addressDictionary))result {
    
    [[[CLGeocoder alloc] init] reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        NSDictionary *addressDic = placemark.addressDictionary;
        if (result) {
            result(addressDic);
        }
    }];
}

@end
