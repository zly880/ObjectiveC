//
//  StarRating.h
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StarRatingResult)(CGFloat score);

@interface StarRating : UIView

/**
 初始化显示
 
 @param frame       评分视图frame
 @param originScore 初始化显示范围0-1，默认1
 @param isEdit      YES 表示允许五星评分操作，NO 表示五星评分显示，不能操作
 @param result      评分结果，范围0-1
 
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                  originScore:(CGFloat)originScore
                       isEdit:(BOOL)isEdit
                       result:(StarRatingResult)result;

@end
