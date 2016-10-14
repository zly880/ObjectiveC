//
//  ImagePreViewController.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "BaseController.h"

@interface ImagePreViewController : BaseController

@property (nonatomic, copy  ) NSArray *dataSource;  // 数据源：包括图片、本地路径、网络路径、二进制流
@property (nonatomic, assign) NSUInteger index;     // 当前显示数据源中的第几张图片

@end
