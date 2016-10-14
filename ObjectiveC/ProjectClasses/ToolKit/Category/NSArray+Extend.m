//
//  NSArray+Extend.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "NSArray+Extend.h"

@implementation NSArray (Extend)

/**
 *  数组元素拼接成字符串
 *
 *  @param separateChar 字符串的分隔符
 *
 *  @return 拼接完成的字符串
 */
- (NSString *)stringWithSeparateChar:(NSString *)separateChar {
    
    if (self == nil || self.count <= 0) {
        return @"";
    }
    
    NSMutableString *string = [NSMutableString string];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"%@%@", obj, separateChar];
    }];
    
    return [string substringToIndex:string.length - 1];
}

/**
 *  数组交集
 *
 *  @param otherArray 其他数组
 *
 *  @return 交集组成的数组
 */
- (NSArray *)intersectionWithOtherArray:(NSArray *)otherArray {
    
    if(self == nil || self.count <= 0 || otherArray == nil || otherArray.count <= 0) {
        return nil;
    }
    
    NSMutableArray *intersectionArray = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([otherArray containsObject:obj] == YES) {
            [intersectionArray addObject:obj];
        }
    }];
    
    return intersectionArray;
}

@end
