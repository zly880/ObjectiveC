//
//  ImageMultipleController.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "BaseController.h"

@interface ImageMultipleController : BaseController

@property (nonatomic, copy) void(^ImageMultipleResult)(NSArray *imageMultipleResult);

/**
 初始化
 
 @param fromVc   来源控制器
 @param maxCount 最多允许选择多少张图片
 
 @return 实例对象
 */
- (instancetype)initWithFromVc:(UIViewController *)fromVc
                      maxCount:(NSUInteger)maxCount;

@end
