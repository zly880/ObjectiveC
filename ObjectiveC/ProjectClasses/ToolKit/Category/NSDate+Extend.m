//
//  NSDate+Extend.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "NSDate+Extend.h"

NSUInteger unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
NSUInteger unitFlagLong = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

@implementation NSDate (Extend)

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
                        second:(NSInteger)second {
    
    NSDateComponents *components  = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return date;
}

/**
 *  根据出生日期计算年龄
 *
 *  @return 年龄
 */
- (NSInteger)age {
    
    if (self == nil) {
        return 0;
    }
    
    NSDateComponents *birthComponents = [[NSCalendar currentCalendar] components:unitFlag fromDate:self];
    NSInteger birthDateYear  = [birthComponents year];
    NSInteger birthDateMonth = [birthComponents month];
    NSInteger birthDateDay   = [birthComponents day];
    NSDateComponents *currentComponents = [[NSCalendar currentCalendar] components:unitFlag fromDate:[NSDate date]];
    NSInteger currentDateYear  = [currentComponents year];
    NSInteger currentDateMonth = [currentComponents month];
    NSInteger currentDateDay   = [currentComponents day];
    NSInteger iAge = currentDateYear - birthDateYear - 1;
    if ((currentDateMonth > birthDateMonth) || (currentDateMonth == birthDateMonth && currentDateDay >= birthDateDay)) {
        iAge++;
    }
    
    return iAge;
}

/**
 *  根据时间戳获取日历
 *
 *  @return 日历
 */
- (NSString *)calenderString {
    
    if (self == nil) {
        return @"";
    }
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlag fromDate:self];
    NSInteger year  = [components year];
    NSInteger month = [components month];
    NSInteger day   = [components day];
    
    return [NSString stringWithFormat:@"%ld年%ld月%ld日", (long)year, (long)month, (long)day];
}

/**
 *  根据时间戳获取时间
 *
 *  @return 时间
 */
- (NSString *)timeString {
    
    if (self == nil) {
        return @"";
    }
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateStyle:NSDateFormatterShortStyle];
    [timeFormatter setTimeStyle:NSDateFormatterShortStyle];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    
    return  [timeFormatter stringFromDate:self];
}

/**
 *  获取过去某一时间相对于现在的时间距离
 *
 *  @return 如果超过七天       返回日历格式
 *          如果没有超过七天    返回 XX 前
 *          如果没有超过一秒    返回 刚刚
 */
- (NSString *)timeDistance {
    
    if (self == nil || [[NSDate date] compare:self] == NSOrderedAscending) {
        return @"";
    }
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *component = [calender components:unitFlagLong fromDate:self toDate:[NSDate date] options:0];
    NSInteger year   = [component year];
    NSInteger month  = [component month];
    NSInteger day    = [component day];
    NSInteger hour   = [component hour];
    NSInteger minute = [component minute];
    NSInteger second = [component second];
    
    NSString *resultString;
    if (year > 0) {
        resultString = [self calenderString];
    } else if (month > 0) {
        resultString = [self calenderString];
    } else if (day > 0) {
        if (day > 7) {
            resultString = [self calenderString];
        } else {
            resultString = [NSString stringWithFormat:@"%ld天前", (long)day];
        }
    } else if (hour > 0) {
        resultString = [NSString stringWithFormat:@"%ld小时前", (long)hour];
    } else if (minute > 0) {
        resultString = [NSString stringWithFormat:@"%ld分钟前", (long)minute];
    } else if (second > 30) {
        resultString = [NSString stringWithFormat:@"%ld秒前", (long)second];
    } else {
        resultString = @"刚刚";
    }
    
    return resultString;
}

/**
 *  仿照 QQ 聊天时候的时间显示
 *
 *  @return 一天以前的时间 显示日历格式时间
 *          昨天的时间    显示昨天上午/下午 时间
 *          今天的时间    显示上午/下午 时间
 */
- (NSString *)timeDistanceQQ {
    
    if (self == nil || [[NSDate date] compare:self] == NSOrderedAscending) {
        return @"";
    }
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *component = [calender components:unitFlagLong fromDate:self];
    NSInteger year   = [component year];
    NSInteger month  = [component month];
    NSInteger day    = [component day];
    NSInteger hour   = [component hour];
    NSInteger minute = [component minute];
    NSInteger second = [component second];
    
    NSDateComponents *componentCurrent = [calender components:unitFlagLong fromDate:[NSDate date]];
    NSInteger yearCurrent   = [componentCurrent year];
    NSInteger monthCurrent  = [componentCurrent month];
    NSInteger dayCurrent    = [componentCurrent day];
    NSInteger hourCurrent   = [componentCurrent hour];
    NSInteger minuteCurrent = [componentCurrent minute];
    NSInteger secondCurrent = [componentCurrent second];
    
    NSString *resultString;
    NSString *upOrDown = hour >= 12 ? @"下午" : @"上午";
    if (year < yearCurrent) {
        resultString = [self calenderString];
    } else if (month < monthCurrent) {
        resultString = [self calenderString];
    } else if (day < dayCurrent) {
        if (dayCurrent - day > 1) {
            resultString = [self calenderString];
        } else {
            resultString = [NSString stringWithFormat:@"昨天%@ %@", upOrDown, [self timeString]];
        }
    } else if (hour < hourCurrent) {
        resultString = [NSString stringWithFormat:@"%@ %@", upOrDown, [self timeString]];
    } else if (minute < minuteCurrent) {
        resultString = [NSString stringWithFormat:@"%@ %@", upOrDown, [self timeString]];
    } else if (second < secondCurrent) {
        resultString = [NSString stringWithFormat:@"%@ %@", upOrDown, [self timeString]];
    } else {
        resultString = @"";
    }
    
    return resultString;
}

@end
