//
//  UIImage+Extend.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名称
 *
 *  @return 图片
 */
+ (UIImage *)resizableImage:(NSString *)name;

/**
 *  重置图片尺寸
 *
 *  @param newSize 新尺寸
 *
 *  @return 重置尺寸后的新图片
 */
- (UIImage *)imageResetSize:(CGSize)newSize;

/**
 *  压缩图片
 *
 *  @param newSize 大小超过多少才进行压缩，单位 KB
 *
 *  @return 压缩后的新图片
 */
- (UIImage *)imageCompress:(NSUInteger)newSize;

@end
