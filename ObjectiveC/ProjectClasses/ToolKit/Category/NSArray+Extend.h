//
//  NSArray+Extend.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extend)

/**
 *  数组元素拼接成字符串
 *
 *  @param separateChar 字符串的分隔符
 *
 *  @return 拼接完成的字符串
 */
- (NSString *)stringWithSeparateChar:(NSString *)separateChar;

/**
 *  数组交集
 *
 *  @param otherArray 其他数组
 *
 *  @return 交集组成的数组
 */
- (NSArray *)intersectionWithOtherArray:(NSArray *)otherArray;

@end
