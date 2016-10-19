//
//  Banner.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "Banner.h"

@implementation BannerCell

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (void)config {
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    _imageView.userInteractionEnabled = YES;
    _imageView.layer.masksToBounds = YES;
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
    WS(weakSelf);
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf);
    }];
}

@end

/////////////////////////////////////////////////////////////////////

CGFloat PageControlHeight = 20.0f;

@interface Banner () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) BannerCell *leftView;
@property (nonatomic, strong) BannerCell *centerView;
@property (nonatomic, strong) BannerCell *rightView;
@property (nonatomic, assign) NSInteger leftIndex;
@property (nonatomic, assign) NSInteger centerIndex;
@property (nonatomic, assign) NSInteger rightIndex;

@property (nonatomic, weak  ) id <BannerDelegate> delegate;
@property (nonatomic, assign) NSUInteger dataSourceCount;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation Banner

#pragma mark - 外部接口

- (instancetype)init:(id <BannerDelegate>)delegate {
    self = [super init];
    
    if (self) {
        _delegate = delegate;
        _dataSourceCount = 0;
        _timer = nil;
        
        _interval = 4.0f;
        _showPageControl = YES;
        _offset = UIOffsetZero;
        
        [self initApperrance];
        [self reloadData];
    }
    
    return self;
}

- (void)reloadData {
    
    if (_delegate && [_delegate respondsToSelector:@selector(bannerCount)]) {
        _dataSourceCount = [_delegate bannerCount];
        // 判断是否滚动
        _scrollView.scrollEnabled = _dataSourceCount <= 1 ? NO : YES;
        // 设置滚动指针
        if (_dataSourceCount <= 1) {
            _leftIndex = 0;
            _centerIndex = 0;
            _rightIndex = 0;
        } else if (_dataSourceCount > 1) {
            _leftIndex = _dataSourceCount - 1;
            _centerIndex = 0;
            _rightIndex = 1;
        }
        // 判断 UIPageControl 是否显示
        if (_showPageControl == YES) {
            _pageControl.hidden = _dataSourceCount <= 1 ? YES : NO;
            _pageControl.numberOfPages = _dataSourceCount;
            _pageControl.currentPage = 0;
            // 设置 UIPageControl 的偏移位置
            WS(weakSelf);
            if (_offset.horizontal != 0 || _offset.vertical != 0) {
                [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(PageControlHeight));
                    make.left.right.equalTo(weakSelf).with.offset(_offset.horizontal);
                    make.top.bottom.equalTo(weakSelf).with.offset(_offset.vertical);
                }];
            }
        } else {
            _pageControl.hidden = YES;
        }
        // 设置 cell 显示
        [self updateShowWithCell];
        // 开始计时
        [self stop];
        if (_dataSourceCount > 1) {
            [self start];
        }
    }
}

- (void)dismiss {
    
    _delegate = nil;
    _dataSourceCount = 0;
    [self stop];
    
    _leftView = nil;
    _centerView = nil;
    _rightView = nil;
    _leftIndex = 0;
    _centerIndex = 0;
    _rightIndex = 0;
    
    _scrollView = nil;
    _pageControl = nil;
}

#pragma mark - 初始化

- (void)initApperrance {
    
    WS(weakSelf);
    // 初始化滚动视图
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf);
    }];
    // 初始化三个子视图
    if (_delegate &&  [_delegate respondsToSelector:@selector(bannerCell)]) {
        _leftView = [_delegate bannerCell];
        _centerView = [_delegate bannerCell];
        _rightView = [_delegate bannerCell];
        if (_leftView && _centerView && _rightView) {
            [_scrollView addSubview:_leftView];
            [_scrollView addSubview:_centerView];
            [_scrollView addSubview:_rightView];
            [UIGestureRecognizer gestureOnView:_centerView
                                   gestureType:GestureTypeSingleTap
                                        blocks:^(UIGestureRecognizer *gesture) {
                                            [self gestureHandler:gesture];
                                        }];
        }
    }
    // 初始化分页显示
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 0;
    _pageControl.currentPageIndicatorTintColor = APPCOLOR_TINTLIGHT;
    _pageControl.pageIndicatorTintColor = APPCOLOR_TINT;
    _pageControl.enabled = NO;
    [self addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(PageControlHeight));
        make.left.right.bottom.equalTo(weakSelf);
    }];
    if (_delegate && [_delegate respondsToSelector:@selector(bannerPageControl:)]) {
        [_delegate bannerPageControl:_pageControl];
    }
}

- (void)layoutSubviews {
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _scrollView.contentOffset = CGPointMake(width, 0);
    _scrollView.contentSize = CGSizeMake(width * 3, height);
    _leftView.frame = CGRectMake(0, 0, width, height);
    _centerView.frame = CGRectMake(width, 0, width, height);
    _rightView.frame = CGRectMake(width * 2, 0, width, height);
    // 避免iOS7上崩溃
    [super layoutSubviews];
}

#pragma mark - 根据数据更新显示

- (void)updateShowWithCell {
    
    if (_dataSourceCount == 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(bannerCell:cellIndex:)]) {
            [_delegate bannerCell:_centerView cellIndex:0];
        }
    } else {
        if (_leftIndex < _dataSourceCount && _leftIndex >= 0) {
            if (_delegate && [_delegate respondsToSelector:@selector(bannerCell:cellIndex:)]) {
                [_delegate bannerCell:_leftView cellIndex:_leftIndex];
            }
        }
        if (_centerIndex < _dataSourceCount && _centerIndex >= 0) {
            if (_delegate && [_delegate respondsToSelector:@selector(bannerCell:cellIndex:)]) {
                [_delegate bannerCell:_centerView cellIndex:_centerIndex];
            }
        }
        if (_rightIndex < _dataSourceCount && _rightIndex >= 0) {
            if (_delegate && [_delegate respondsToSelector:@selector(bannerCell:cellIndex:)]) {
                [_delegate bannerCell:_rightView cellIndex:_rightIndex];
            }
        }
    }
}

#pragma mark - 手势操作，只能操作最中间的视图

- (void)gestureHandler:(UIGestureRecognizer *)gesture {
    
    if (_delegate && [_delegate respondsToSelector:@selector(bannerClicked:cellIndex:)]) {
        [_delegate bannerClicked:self cellIndex:_centerIndex];
    }
}

#pragma mark - 计时相关

- (void)start {
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_interval
                                                  target:self
                                                selector:@selector(processTimer:)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

- (void)stop {
    
    if ( _timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)processTimer:(NSTimer *)timer {
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * 2, 0) animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.4
                                     target:self
                                   selector:@selector(scrollViewDidEndDecelerating:)
                                   userInfo:nil
                                    repeats:YES];
}

#pragma mark - 计时相关，避免进入子页面视图滚动误差

- (void)pause {
    
    if (_timer != nil) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)goon {
    
    if (_timer != nil) {
        [_timer setFireDate:[NSDate date]];
    }
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stop];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self start];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (_scrollView.contentOffset.x == 0) {
        --_leftIndex;
        --_centerIndex;
        --_rightIndex;
        if (_leftIndex == -1) {
            _leftIndex = _dataSourceCount - 1;
        }
        if (_centerIndex == -1) {
            _centerIndex = _dataSourceCount - 1;
        }
        if (_rightIndex == -1) {
            _rightIndex = _dataSourceCount - 1;
        }
    } else if (_scrollView.contentOffset.x == _scrollView.bounds.size.width * 2) {
        ++_leftIndex;
        ++_centerIndex;
        ++_rightIndex;
        if (_leftIndex == _dataSourceCount) {
            _leftIndex = 0;
        }
        if (_centerIndex == _dataSourceCount) {
            _centerIndex = 0;
        }
        if (_rightIndex == _dataSourceCount) {
            _rightIndex = 0;
        }
    } else {
        return;
    }
    [self updateShowWithCell];
    _pageControl.currentPage = _centerIndex;
    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
}

@end
