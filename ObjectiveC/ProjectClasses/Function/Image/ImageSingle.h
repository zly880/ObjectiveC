//
//  ImageSingle.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PickerCompletion)(UIImage *image, NSURL *url);
typedef void (^PickerCancel)();

@interface ImageSingle : NSObject

/**
 获取模块单例
 
 @return 实例对象
 */
+ (ImageSingle *)shareInstance;

/**
 弹出列表，选择拍照或者选择照片
 
 @param fromVC     来源控制器
 @param completion 完成回调
 @param cancel     取消回调
 */
- (void)imageSingleFromVC:(UIViewController *)fromVC
               completion:(PickerCompletion)completion
                   cancel:(PickerCancel)cancel;

@end
