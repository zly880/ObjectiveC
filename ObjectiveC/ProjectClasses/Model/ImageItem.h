//
//  ImageItem.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ImageItem : JSONModel

@property (nonatomic, copy) NSString <Optional> *urlString; // 图片链接
@property (nonatomic, copy) NSDictionary <Optional> *info;  // 图片信息
@property (nonatomic, copy) UIImage <Optional> *image;      // 图片
@property (nonatomic) BOOL select;                          // 是否选中
@property (nonatomic) NSUInteger index;                     // 图片索引

@end
