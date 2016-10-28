//
//  ImageMultipleController.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "ImageMultipleController.h"
#import "ImageMultipleCell.h"
#import <Photos/Photos.h>

@interface ImageMultipleController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) UIViewController *fromVc;         // 来源控制器
@property (nonatomic, assign) NSInteger maxCount;               // 最多允许选择多少张图片
@property (nonatomic, strong) UICollectionView *collectionView; // 图片显示视图
@property (nonatomic, strong) NSMutableArray *dataSource;       // 所有图片数据
@property (nonatomic, strong) NSMutableArray *selectItems;      // 选中的图片数据

@end

@implementation ImageMultipleController

/**
 初始化
 
 @param fromVc   来源控制器
 @param maxCount 最多允许选择多少张图片
 
 @return 实例对象
 */
- (instancetype)initWithFromVc:(UIViewController *)fromVc
                      maxCount:(NSUInteger)maxCount {
    
    self = [super init];
    
    if (self) {
        _fromVc = fromVc;
        _maxCount = maxCount;
    }
    
    return self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self customData];
    [self customUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"图片多选";
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(completeButtonHandler:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customData {
    
    _dataSource = [NSMutableArray array];
    _selectItems = [NSMutableArray array];
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *asserts = [PHAsset fetchAssetsWithOptions:options];
    for (NSInteger i = 0; i < asserts.count; i++) {
        ImageItem *imageItem = [[ImageItem alloc] init];
        [_dataSource addObject:imageItem];
        PHAsset *assert = (PHAsset *)asserts[i];
        [[PHImageManager defaultManager] requestImageForAsset:assert targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:PHImageRequestOptionsResizeModeNone resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSInteger index = [asserts indexOfObject:assert];
            ImageItem *imageItemNew = [[ImageItem alloc] init];
            imageItemNew.image = result;
            imageItemNew.info = info;
            [_dataSource replaceObjectAtIndex:index withObject:imageItemNew];
            [_collectionView reloadData];
        }];
    }
}

- (void)customUI {
    
    UICollectionViewFlowLayout *usualLayout = [[UICollectionViewFlowLayout alloc] init];
    usualLayout.minimumLineSpacing = 1;
    usualLayout.minimumInteritemSpacing = 1;
    usualLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    usualLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:usualLayout];
    self.collectionView.backgroundColor = APPCOLOR_WHITE;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageMultipleCell" bundle:nil]
          forCellWithReuseIdentifier:@"ImageMultipleCell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - 点击完成按钮，传递选中的图片数据

- (void)completeButtonHandler:(UIBarButtonItem *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
    if (_ImageMultipleResult != nil) {
        _ImageMultipleResult(_selectItems);
    }
}

#pragma  mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageMultipleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageMultipleCell" forIndexPath:indexPath];
    if (indexPath.row < _dataSource.count) {
        ImageItem *imageItem = _dataSource[indexPath.row];
        cell.imageView.image = imageItem.image;
        cell.selectImage.hidden = !imageItem.select;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger itemNumberPerLine = 4;
    UICollectionViewFlowLayout *flowLayout = ((UICollectionViewFlowLayout *)collectionView.collectionViewLayout);
    CGFloat left = flowLayout.sectionInset.left;
    CGFloat right = flowLayout.sectionInset.right;
    CGFloat space = flowLayout.minimumInteritemSpacing * (itemNumberPerLine - 1);
    CGFloat width = (CGRectGetWidth(collectionView.bounds) - left - right - space) / itemNumberPerLine;
    
    return  CGSizeMake(width, width);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageItem *imagItem = _dataSource[indexPath.row];
    if (imagItem.image == nil) {
        return;
    }
    if ([_selectItems containsObject:imagItem] == YES) {
        [_selectItems removeObject:imagItem];
        imagItem.select = NO;
    } else {
        if (_selectItems.count >= self.maxCount) {
            return;
        } else {
            imagItem.select = YES;
            [_selectItems addObject:imagItem];
        }
    }
    [_dataSource replaceObjectAtIndex:indexPath.row withObject:imagItem];
    
    NSString *titleString = @"";
    if (_dataSource.count <= self.maxCount) {
        titleString = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)_selectItems.count, (long)_dataSource.count];
    } else {
        titleString = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)_selectItems.count, (long)self.maxCount];
    }
    self.navigationItem.title = titleString;
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

@end
