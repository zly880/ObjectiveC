//
//  Banner.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Banner;

@interface BannerCell : UIView

@property (nonatomic, strong) UIImageView *imageView; // 默认图片视图

@end

/////////////////////////////////////////////////////////////////////

@protocol BannerDelegate <NSObject>

@required
- (BannerCell *)bannerCell;
- (NSUInteger)bannerCount;
- (void)bannerCell:(BannerCell *)bannerCell cellIndex:(NSUInteger)index;
@optional
- (void)bannerClicked:(Banner *)banner cellIndex:(NSUInteger)index;
- (void)bannerPageControl:(UIPageControl *)pageControl;

@end

/////////////////////////////////////////////////////////////////////

@interface Banner : UIView

#pragma mark - 默认初始化方法
- (instancetype)init:(id <BannerDelegate>)delegate; // 默认初始化方法
- (void)reloadData;                                 // 根据数据刷新显示
- (void)dismiss;                                    // 释放该页面的时候调用必须调用

#pragma mark - 计时相关，避免进入子页面视图滚动误差暂停计时器
- (void)pause;                                      // 暂停计时器
- (void)goon;                                       // 继续定时器

#pragma mark - 自定义属性
@property (nonatomic, assign) CGFloat interval;     // 设置滚动的时间间隔，默认间隔4秒
@property (nonatomic, assign) BOOL showPageControl; // 设置是否显示 PageControl, 默认显示
@property (nonatomic, assign) UIOffset offset;      // 设置 PageControl 的位置偏移，默认位于底部居中

@end
