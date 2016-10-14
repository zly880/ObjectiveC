//
//  ImagePreViewController.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "ImagePreViewController.h"

@interface ImagePreViewCell : UICollectionViewCell <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy  ) void(^TapImage)();

@end

@implementation ImagePreViewCell

// 初始化显示
- (void)config {
    
    self.backgroundColor = APPCOLOR_BLACK;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    _scrollView.frame = self.bounds;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentOffset = CGPointZero;
    _scrollView.contentSize = _scrollView.bounds.size;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 5;
    _scrollView.zoomScale = 1;
    [self addSubview:_scrollView];
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_imageView];
    
    [UIGestureRecognizer gestureOnView:_imageView
                           gestureType:GestureTypeSingleTap
                                blocks:^(UIGestureRecognizer *gesture) {
                                    if (_TapImage) {
                                        _TapImage();
                                    }
                                }];
}

// 重置图片视图尺寸，重置_scrollView的contentSize
- (void)resizeWithImage:(UIImage *)image {
    
    CGFloat imgWidth = image.size.width;
    CGFloat imgHeight = image.size.height;
    CGFloat s = imgWidth / imgHeight;
    CGFloat S = SCREEN_WIDTH / SCREEN_HEIGHT;
    
    if (s >= S) {
        // 以宽为标准
        if (s > 2) {
            // 长图
            imgHeight = SCREEN_HEIGHT;
            imgWidth = imgHeight * s;
        } else {
            imgWidth = SCREEN_WIDTH;
            imgHeight = imgWidth / s;
        }
        CGFloat top = (SCREEN_HEIGHT - imgHeight) / 2;
        _imageView.frame = CGRectMake(0, top, imgWidth, imgHeight);
    } else if (s < S) {
        // 以高为标准
        if (s < 1 / 2) {
            // 长图
            imgWidth = SCREEN_WIDTH;
            imgHeight = imgWidth / s;
        } else {
            imgHeight = SCREEN_HEIGHT;
            imgWidth = imgHeight * s;
        }
        CGFloat left = (SCREEN_WIDTH - imgWidth) / 2;
        _imageView.frame = CGRectMake(left, 0, imgWidth, imgHeight);
    }
    _scrollView.contentSize = _imageView.bounds.size;
}

// 显示：content 包括图片、本地路径、网络路径、二进制流
- (void)showWithContent:(NSObject *)content {
    
    [self config];
    if (content == nil) {
        [_imageView setImage:[UIImage imageNamed:@"Default_banner"]];
        return;
    }
    
    if ([content isKindOfClass:[UIImage class]]) {
        // 图片
        UIImage *image = [(UIImage *)content copy];
        _imageView.image = image;
        [self resizeWithImage:image];
    } else if ([content isKindOfClass:[NSString class]]) {
        NSString *path = [(NSString *)content copy];
        if ([path hasPrefix:@"/"]) {
            // 本地路径
            NSData *imageData = [NSData dataWithContentsOfFile:path];
            UIImage *image = [UIImage imageWithData:imageData];
            [self resizeWithImage:image];
        } else {
            // 网络路径
            [_imageView sd_setImageWithURL:[NSURL URLWithString:path]
                          placeholderImage:[UIImage imageNamed:@"Default_banner"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     if (image && !error) {
                                         [self resizeWithImage:image];
                                     } else {
                                         [Toast showFailed:error.localizedDescription];
                                     }
                                 }];
        }
    } else if ([content isKindOfClass:[NSData class]]) {
        // 二进制文件
        NSData *data = [(NSData *)content copy];
        UIImage *image = [UIImage imageWithData:data];
        [self resizeWithImage:image];
    }
}

#pragma mark - <UIScrollViewDelegate>

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGSize originalSize = scrollView.bounds.size;
        CGSize contentSize = scrollView.contentSize;
        CGFloat s = originalSize.width / originalSize.height;
        CGFloat S = SCREEN_WIDTH / SCREEN_HEIGHT;
        CGRect frame = _imageView.frame;
        // 图片的宽高比大于屏幕的宽高比，即图片横向适配
        if (s >= S) {
            if (originalSize.height > contentSize.height) {
                CGFloat top = (originalSize.height - contentSize.height) / 2;
                frame.origin.y = top;
            } else {
                frame.origin.y = 0;
            }
        } else if (s < S) {
            if (originalSize.width > contentSize.width) {
                CGFloat left = (originalSize.width - contentSize.width) / 2;
                frame.origin.x = left;
            } else {
                frame.origin.x = 0;
            }
        }
        _imageView.frame = frame;
    }];
}

@end

/////////////////////////////////////////////////////////////////////

@interface ImagePreViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation ImagePreViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customMainUI];
    [self customOtherUI];
    
    if (_index >= _dataSource.count) {
        _index = _dataSource.count - 1;
    }
    _titleLable.text = [NSString stringWithFormat:@"%@ / %@", @(_index + 1), @(_dataSource.count)];
    _collectionView.contentOffset = CGPointMake(SCREEN_WIDTH * _index, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customMainUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    self.collectionView.backgroundColor = APPCOLOR_BLACK;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[ImagePreViewCell class] forCellWithReuseIdentifier:@"ImagePreViewCell"];
    [self.view addSubview:self.collectionView];
}

- (void)customOtherUI {
    
    _titleLable = [[UILabel alloc] init];
    _titleLable.bounds = CGRectMake(0, 0, 120, 40);
    _titleLable.center = CGPointMake(SCREEN_WIDTH * 0.5, 45);
    _titleLable.layer.cornerRadius = 20;
    _titleLable.layer.masksToBounds = YES;
    _titleLable.backgroundColor = [APPCOLOR_BLACK colorWithAlphaComponent:0.5];
    _titleLable.font = APPFONT_BIG;
    _titleLable.textColor = APPCOLOR_WHITE;
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLable];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(10, CGRectGetMinY(_titleLable.frame), 40, 40);
    _backButton.layer.cornerRadius = 20;
    _backButton.layer.masksToBounds = YES;
    [_backButton setBackgroundColor:[APPCOLOR_BLACK colorWithAlphaComponent:0.5]];
    [_backButton setImage:[UIImage imageNamed:@"Nav_back"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(buttonHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
}

- (void)buttonHandler:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImagePreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImagePreViewCell" forIndexPath:indexPath];
    if (indexPath.row < _dataSource.count) {
        [cell showWithContent:_dataSource[indexPath.row]];
        [cell setTapImage:^{
            [self buttonHandler:_backButton];
        }];
    }
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _index = round(scrollView.contentOffset.x / scrollView.bounds.size.width);
    _titleLable.text = [NSString stringWithFormat:@"%@ / %@", @(_index + 1), @(_dataSource.count)];
}

@end
