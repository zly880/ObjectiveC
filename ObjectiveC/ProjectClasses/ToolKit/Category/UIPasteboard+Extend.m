//
//  UIPasteboard+Extend.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "UIPasteboard+Extend.h"

@implementation UIPasteboard (Extend)

/**
 *  拷贝粘贴文本
 *
 *  @param context 文本内容
 */
+ (void)copyContext:(NSString *)context {
    
    [[UIPasteboard generalPasteboard] setString:context];
}

+ (NSString *)pasteContext {
    
    return [[UIPasteboard generalPasteboard] string];
}

/**
 *  拷贝粘贴图片
 *
 *  @param image 图片
 */
+ (void)copyImage:(UIImage *)image {
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [[UIPasteboard generalPasteboard] setData:imageData forPasteboardType:@"imageCopy"];
}

+ (UIImage *)pasteImage {
    
    NSData *imageData = [[UIPasteboard generalPasteboard] dataForPasteboardType:@"imageCopy"];
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
