//
//  NSDate+Extend.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extend)

/**
 *  根据年月日时分秒构建时间
 *
 *  @param year   年
 *  @param month  月
 *  @param day    日
 *  @param hour   小时
 *  @param minute 分钟
 *  @param second 秒
 *
 *  @return 时间戳
 */
+ (NSDate *)createDateWithYear:(NSInteger)year
                         month:(NSInteger)month
                           day:(NSInteger)day
                          hour:(NSInteger)hour
                        minute:(NSInteger)minute
                        second:(NSInteger)second;

/**
 *  根据出生日期计算年龄
 *
 *  @return 年龄
 */
- (NSInteger)age;

/**
 *  根据时间戳获取日历
 *
 *  @return 日历
 */
- (NSString *)calenderString;

/**
 *  根据时间戳获取时间
 *
 *  @return 时间
 */
- (NSString *)timeString;

/**
 *  获取过去某一时间相对于现在的时间距离
 *
 *  @return 如果超过七天       返回日历格式
 *          如果没有超过七天    返回 XX 前
 *          如果没有超过一秒    返回 刚刚
 */
- (NSString *)timeDistance;

/**
 *  仿照 QQ 聊天时候的时间显示
 *
 *  @return 一天以前的时间 显示日历格式时间
 *          昨天的时间    显示昨天上午/下午 时间
 *          今天的时间    显示上午/下午 时间
 */
- (NSString *)timeDistanceQQ;

@end
