//
//  UIPasteboard+Extend.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPasteboard (Extend)

/**
 *  拷贝粘贴文本
 *
 *  @param context 文本内容
 */
+ (void)copyContext:(NSString *)context;
+ (NSString *)pasteContext;

/**
 *  拷贝粘贴图片
 *
 *  @param image 图片
 */
+ (void)copyImage:(UIImage *)image;
+ (UIImage *)pasteImage;

@end
