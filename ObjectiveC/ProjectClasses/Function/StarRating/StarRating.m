//
//  StarRating.m
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "StarRating.h"

static NSInteger starCount = 5;

@interface StarRating ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *foregroundView;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, copy  ) StarRatingResult starRatingResult;

@end

@implementation StarRating

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
                       result:(StarRatingResult)result {
    
    self = [super initWithFrame:frame];
    if (self) {
        if (originScore > 1) {
            originScore = 1;
        } else if (originScore < 0) {
            originScore = 0;
        }
        self.isEdit = isEdit;
        _starRatingResult = result;
        self.backgroundView = [self buidlStarViewWithImageName:@"StarRating_back" score:1];
        self.foregroundView = [self buidlStarViewWithImageName:@"StarRating_fore" score:originScore];
        [self addSubview:self.backgroundView];
        [self addSubview:self.foregroundView];
    }
    
    return self;
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName score:(CGFloat)score {
    
    CGFloat width = CGRectGetWidth(self.bounds) * score;
    CGFloat height = CGRectGetHeight(self.bounds);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.layer.masksToBounds = YES;
    
    width = CGRectGetWidth(self.bounds) / starCount;
    for (NSInteger i = 0; i < starCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.userInteractionEnabled = YES;
        [view addSubview:imageView];
    }
    
    return view;
}

#pragma mark - 触摸事件

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    CGPoint point = [[touches anyObject] locationInView:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf changeStarForegroundViewWithPoint:point];
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    CGPoint point = [[touches anyObject] locationInView:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf changeStarForegroundViewWithPoint:point];
    }];
}

#pragma mark - 通过坐标改变前景视图

- (void)changeStarForegroundViewWithPoint:(CGPoint)point {
    
    if (self.isEdit == NO) {
        return;
    }
    
    if (point.x >= 0 && point.x <= self.frame.size.width) {
        CGFloat score = ceil(point.x / self.frame.size.width * 10) / 10;
        point.x = score * self.frame.size.width;
        self.foregroundView.frame = CGRectMake(0, 0, point.x, self.frame.size.height);
        if (_starRatingResult) {
            _starRatingResult(score);
        }
    }
}

@end
