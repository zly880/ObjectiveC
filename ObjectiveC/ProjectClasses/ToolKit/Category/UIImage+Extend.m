//
//  UIImage+Extend.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名称
 *
 *  @return 图片
 */
+ (UIImage *)resizableImage:(NSString *)name {
    
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    UIImage *resizableImage = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    
    return resizableImage;
}

/**
 *  重置图片尺寸
 *
 *  @param newSize 新尺寸
 *
 *  @return 重置尺寸后的新图片
 */
- (UIImage *)imageResetSize:(CGSize)newSize {
    
    if (self == nil) {
        return nil;
    }
    
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  压缩图片
 *
 *  @param newSize 大小超过多少才进行压缩，单位 KB
 *
 *  @return 压缩后的新图片
 */
- (UIImage *)imageCompress:(NSUInteger)newSize {
    
    if (self == nil) {
        return nil;
    }
    
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0);
    if (imageData.length > 1024 * newSize) {
        imageData = UIImageJPEGRepresentation(self, 1024 * newSize / (CGFloat)imageData.length);
    }
    UIImage *newImage = [UIImage imageWithData:imageData];
    
    return newImage;
}

@end
