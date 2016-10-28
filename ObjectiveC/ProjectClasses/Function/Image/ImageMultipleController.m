//
//  ImageMultipleController.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "ImageMultipleController.h"
#import "ImageMultipleCell.h"
#import "ImageMultipleHeader.h"
#import <Photos/Photos.h>

@interface ImageMultipleController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView; // 图片显示视图
@property (nonatomic, strong) NSMutableArray *allAlbums;        // 所有相册
@property (nonatomic, strong) NSMutableDictionary *allImages;   // 所有图片

@end

@implementation ImageMultipleController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_collectionView reloadData];
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
    
    // 初始化数据
    _allAlbums = [[NSMutableArray alloc] init];
    _allImages = [[NSMutableDictionary alloc] init];
    // 初始化UI
    [self customUI];
    // 获取所有图片的缩略图
    [self getAllImages:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data

/**
 获取所有图片
 
 @param original YES 表示原图，NO 表示缩略图
 */
- (void)getAllImages:(BOOL)original {
    
    [_allAlbums removeAllObjects];
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        [_allAlbums addObject:assetCollection];
        [self enumAssetCollection:assetCollection original:original];
    }
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [_allAlbums addObject:cameraRoll];
    [self enumAssetCollection:cameraRoll original:original];
    // 获得屏幕截图
    PHAssetCollection *shots = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumScreenshots options:nil].lastObject;
    [_allAlbums addObject:shots];
    [self enumAssetCollection:shots original:original];
}

/**
 遍历相簿中的图片
 
 @param assetCollection 相簿
 @param original        是否要原图
 */
- (void)enumAssetCollection:(PHAssetCollection *)assetCollection
                   original:(BOOL)original {
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片
    options.synchronous = YES;
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = CGSizeZero;
        if (original == YES) {
            size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        } else {
            size = CGSizeMake(asset.pixelWidth / 2, asset.pixelHeight / 2);
        }
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:size
                                                  contentMode:PHImageContentModeDefault
                                                      options:options
                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                    [self saveImages:result info:info assetCollection:assetCollection];
                                                }];
    }
}

/**
 保存图片
 
 @param result          图片
 @param info            图片信息
 @param assetCollection 相册
 */
- (void)saveImages:(UIImage *)result info:(NSDictionary *)info assetCollection:(PHAssetCollection *)assetCollection {
    
    ImageItem *item = [[ImageItem alloc] init];
    item.image = result;
    item.info = info;
    NSMutableArray *array = [NSMutableArray arrayWithArray:_allImages[assetCollection.localizedTitle]];
    [array addObject:item];
    [_allImages removeObjectForKey:assetCollection.localizedTitle];
    [_allImages setObject:array forKey:assetCollection.localizedTitle];
}

#pragma mark - UI

- (void)customUI {
    
    UICollectionViewFlowLayout *usualLayout = [[UICollectionViewFlowLayout alloc] init];
    usualLayout.minimumLineSpacing = 1;
    usualLayout.minimumInteritemSpacing = 1;
    usualLayout.sectionInset = UIEdgeInsetsZero;
    usualLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:usualLayout];
    self.collectionView.backgroundColor = APPCOLOR_WHITE;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageMultipleCell" bundle:nil]
          forCellWithReuseIdentifier:@"ImageMultipleCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageMultipleHeader" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"ImageMultipleHeader"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - 点击完成按钮，传递选中的图片数据

- (void)completeButtonHandler:(UIBarButtonItem *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return _allAlbums.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    PHAssetCollection *assetCollection = _allAlbums[section];
    NSMutableArray *images = [_allImages objectForKey:assetCollection.localizedTitle];
    
    return images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageMultipleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageMultipleCell" forIndexPath:indexPath];
    if (indexPath.section < _allAlbums.count) {
        PHAssetCollection *assetCollection = _allAlbums[indexPath.section];
        NSMutableArray *images = [_allImages objectForKey:assetCollection.localizedTitle];
        if (indexPath.row < images.count) {
            ImageItem *item = images[indexPath.row];
            cell.imageView.image = item.image;
            cell.selectImage.hidden = !item.select;
        }
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

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 44);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ImageMultipleHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ImageMultipleHeader" forIndexPath:indexPath];
        if (indexPath.section < _allAlbums.count) {
            PHAssetCollection *assetCollection = _allAlbums[indexPath.section];
            header.titleLabel.text = assetCollection.localizedTitle;;
        }
        return header;
    } else {
        return nil;
    }
}

@end
