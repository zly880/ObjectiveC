//
//  Map.m
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

// CLLocation：用于表示位置信息，包含地理坐标、海拔等信息，包含在CoreLoaction框架中。
// MKUserLocation：一个特殊的大头针，表示用户当前位置。
// CLPlacemark：定位框架中地标类，封装了详细的地理信息。
// MKPlacemark：类似于CLPlacemark，只是它在MapKit框架中，可以根据CLPlacemark创建MKPlacemark。

#import "Map.h"
#import <MapKit/MapKit.h>

@interface Map () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation Map

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"地图";
    [self initMapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMapView {
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    // 地图类型
    _mapView.mapType = MKMapTypeStandard;
    // 用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    // 是否显示指南针
    _mapView.showsCompass = NO;
    // 是否显示比例尺
    _mapView.showsScale = NO;
    // 是否显示交通
    _mapView.showsTraffic = YES;
    // 是否显示建筑
    _mapView.showsBuildings = YES;
    // 显示用户的位置
    _mapView.showsUserLocation = YES;
}

#pragma mark - <MKMapViewDelegate>
#pragma mark - 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    // 设置显示区域
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    MKCoordinateRegion region = {userLocation.coordinate, span};
    [mapView setRegion:region];
    
    [[Location shareInstance] addressFromCLLocation:userLocation.location result:^(NSDictionary *addressDictionary) {
        // 改变用户大头针的数据
        userLocation.title = [NSString stringWithFormat:@"%@%@%@",
                              addressDictionary[@"State"],
                              addressDictionary[@"City"],
                              addressDictionary[@"SubLocality"]];
        userLocation.subtitle = [NSString stringWithFormat:@"%@", addressDictionary[@"Street"]];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PinAnnotation"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PinAnnotation"];
    }
    annotationView.pinTintColor = APPCOLOR_TINT;
    annotationView.animatesDrop = NO;
    annotationView.canShowCallout = YES;
    UIImage *image = [UIImage imageNamed:@"Default_left"];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:image];
    leftImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    leftImageView.tintColor = APPCOLOR_TINT;
    annotationView.leftCalloutAccessoryView = leftImageView;
    image = [UIImage imageNamed:@"Default_right"];
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:image];
    rightImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    rightImageView.tintColor = APPCOLOR_TINT;
    annotationView.rightCalloutAccessoryView = rightImageView;
    
    return annotationView;
}

@end
