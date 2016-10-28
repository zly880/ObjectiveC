//
//  HomeController.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "HomeController.h"
#import "CollectionViewCell.h"
#import "CollectionViewHeader.h"
#import "CollectionViewFooter.h"

#import "LoginController.h"

#define HEADER_HEIGHT (SCREEN_WIDTH * 200 / 320)
#define FOOTER_HEIGHT 40

@interface HomeController ()

<UICollectionViewDataSource
, UICollectionViewDelegate
, BannerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) Banner *banner;
@property (nonatomic, strong) NSMutableArray *bannerList;

@end

@implementation HomeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_banner start];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_banner stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"登录"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(leftButtonHandler:)];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"退出"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(rightButtonHandler:)];
    
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIBarButtonItem handler

- (void)leftButtonHandler:(UIBarButtonItem *)sender {
    
    LoginController *vc = [[LoginController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightButtonHandler:(UIBarButtonItem *)sender {
    
    [UIView animateWithDuration:0.2f animations:^{
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

#pragma mark - init

- (void)initData {
    
    _dataSource = @[@"硬件检测", @"系统应用", @"系统通知", @"字体列表",
                    @"二维码扫描", @"图片", @"WebView", @"地图定位",
                    @"音频", @"视频", @"支付", @"即时通讯",
                    @"友盟"];
    _bannerList = [NSMutableArray array];
}

- (void)initUI {
    
    CGFloat space = 1;
    UICollectionViewFlowLayout *usualLayout = [[UICollectionViewFlowLayout alloc] init];
    usualLayout.minimumLineSpacing = space;
    usualLayout.minimumInteritemSpacing = space;
    usualLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    usualLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - TABBAR_HEIGHT);
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:usualLayout];
    _collectionView.backgroundColor = APPCOLOR_GRAYLIGHT;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil]
      forCellWithReuseIdentifier:@"CollectionViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewHeader" bundle:nil]
      forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
             withReuseIdentifier:@"CollectionViewHeader"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewFooter" bundle:nil]
      forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
             withReuseIdentifier:@"CollectionViewFooter"];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row < _dataSource.count) {
        cell.titleLabel.text = _dataSource[indexPath.row];
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
    
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), HEADER_HEIGHT + 41);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), FOOTER_HEIGHT);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionViewHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewHeader" forIndexPath:indexPath];
        header.backgroundColor = APPCOLOR_WHITE;
        
        // 轮播广告
        _banner = [[Banner alloc] init:self];
        _banner.frame = CGRectMake(0, 0, CGRectGetWidth(header.bounds), HEADER_HEIGHT);
        [header addSubview:_banner];
        // 五星评价
        CGRect frame = CGRectMake(0, HEADER_HEIGHT + 10, 105, 21);
        StarRating *view1 = [[StarRating alloc] initWithFrame:frame originScore:1 isEdit:YES result:^(CGFloat score) {
            [Toast showMessage:[NSString stringWithFormat:@"%.2f", score]];
        }];
        [header addSubview:view1];
        // 五星显示
        frame = CGRectMake(SCREEN_WIDTH - 105, HEADER_HEIGHT + 10, 105, 21);
        StarRating *view2 = [[StarRating alloc] initWithFrame:frame originScore:0.3 isEdit:NO result:nil];
        [header addSubview:view2];
        
        return header;
    } else {
        CollectionViewFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionViewFooter" forIndexPath:indexPath];
        return footer;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *titleString = cell.titleLabel.text;
    
    if ([titleString isEqualToString:@"硬件检测"]) {
        [UIAlertController alertFromVC:self title:titleString message:nil buttonTitles:@[@"开启电池检测", @"关闭电池检测", @"开灯", @"关灯", @"取消"] blocks:^(UIAlertAction *action) {
            if ([action.title isEqualToString:@"开启电池检测"]) {
                [[Hardware shareInstance] checkBattery:YES timeInterval:2 result:^(CGFloat battertyLevel, UIDeviceBatteryState batteryState) {
                    [Toast showMessage:[NSString stringWithFormat:@"电池电量:%.2f\n电池状态:%ld", battertyLevel, (long)batteryState]];
                }];
            } else if ([action.title isEqualToString:@"关闭电池检测"]) {
                [[Hardware shareInstance] checkBattery:NO timeInterval:0 result:nil];
            } else if ([action.title isEqualToString:@"开灯"]) {
                [[Hardware shareInstance] torchSetting:YES];
            } else if ([action.title isEqualToString:@"关灯"]) {
                [[Hardware shareInstance] torchSetting:NO];
            }
        }];
    } else if ([titleString isEqualToString:@"系统应用"]) {
        [UIAlertController alertFromVC:self title:titleString message:nil buttonTitles:@[@"打开Safari", @"拨打电话", @"取消"] blocks:^(UIAlertAction *action) {
            if ([action.title isEqualToString:@"打开Safari"]) {
                [[CallSystemApp shareInstance] openSafari:@"www.baidu.com"];
            } else if ([action.title isEqualToString:@"拨打电话"]) {
                [[CallSystemApp shareInstance] callWithPhoneNumber:@"15228895234"];
            }
        }];
    } else if ([titleString isEqualToString:@"系统通知"]) {
        [[Notification shareInstance] showLocalNotificationWithTitle:@"我是标题"
                                                            subTitle:@"我是子标题"
                                                                body:@"我是内容"
                                                           imagePath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]
                                                            userInfo:nil];
    } else if ([titleString isEqualToString:@"字体列表"]) {
        FontList *vc = [[FontList alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleString isEqualToString:@"二维码扫描"]) {
        QR *vc = [[QR alloc] init];
        [vc setQRScanResult:^(NSString *qrScanResult) {
            [Toast showMessage:qrScanResult];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([titleString isEqualToString:@"图片"]) {
        [UIAlertController alertFromVC:self title:titleString message:nil buttonTitles:@[@"单选", @"多选", @"预览", @"取消"] blocks:^(UIAlertAction *action) {
            if ([action.title isEqualToString:@"单选"]) {
                [[ImageSingle shareInstance] imageSingleFromVC:self completion:^(UIImage *image, NSURL *url) {
                    collectionView.backgroundColor = [UIColor colorWithPatternImage:image];
                } cancel:^{
                }];
            } else if ([action.title isEqualToString:@"多选"]) {
                ImageMultipleController *vc = [[ImageMultipleController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            } else if ([action.title isEqualToString:@"预览"]) {
                if (_bannerList.count > 0) {
                    ImagePreViewController *vc = [[ImagePreViewController alloc] init];
                    vc.dataSource = [NSArray arrayWithArray:_bannerList];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }];
    } else if ([titleString isEqualToString:@"WebView"]) {
        [UIAlertController alertFromVC:self title:titleString message:nil buttonTitles:@[@"文件", @"网页", @"H5文本", @"取消"] blocks:^(UIAlertAction *action) {
            if ([action.title isEqualToString:@"文件"]) {
                WebViewController *vc = [[WebViewController alloc] init];
                vc.webViewType = WebViewType_Local;
                vc.titleString = @"正则表达式.rtf";
                vc.contentString = @"正则表达式.rtf";
                [self.navigationController pushViewController:vc animated:YES];
            } else if ([action.title isEqualToString:@"网页"]) {
                WebViewController *vc = [[WebViewController alloc] init];
                vc.webViewType = WebViewType_Web;
                vc.contentString = @"www.baidu.com";
                [self.navigationController pushViewController:vc animated:YES];
            } else if ([action.title isEqualToString:@"H5文本"]) {
                WebViewController *vc = [[WebViewController alloc] init];
                vc.webViewType = WebViewType_H5;
                vc.titleString = @"H5文本";
                vc.contentString = @"<p>H5测试文本<img style=\"width: 100%\" src=\"http://a.hiphotos.baidu.com/zhidao/pic/item/54fbb2fb43166d22c7e78a8e402309f79052d21c.jpg\"/>H5测试文本：中国量子卫星在轨测试顺利。</p>";
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    } else if ([titleString isEqualToString:@"地图定位"]) {
        [UIAlertController alertFromVC:self title:titleString message:nil buttonTitles:@[@"定位", @"地图", @"取消"] blocks:^(UIAlertAction *action) {
            if ([action.title isEqualToString:@"定位"]) {
                [[Location shareInstance] locationService:YES fromVc:self];
                [Toast showLoading:@"定位中..."];
                [[Location shareInstance] setCurrentLocation:^(CLLocation *currentLocation) {
                    CLLocationCoordinate2D coordinate = currentLocation.coordinate;
                    [Toast showMessage:[NSString stringWithFormat:@"经度：%f\n纬度：%f", coordinate.longitude, coordinate.latitude]];
                }];
            } else if ([action.title isEqualToString:@"地图"]) {
                Map *vc = [[Map alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    } else if ([titleString isEqualToString:@"音频"]) {
        [UIAlertController alertFromVC:self title:titleString message:nil buttonTitles:@[@"音效", @"播放音频", @"暂停音频", @"停止音频", @"取消"] blocks:^(UIAlertAction *action) {
            if ([action.title isEqualToString:@"音效"]) {
                [[AudioPlayer shareInstance] playSoundEffect:@"音效.caf" vibrate:YES];
            } else if ([action.title isEqualToString:@"播放音频"]) {
                [[AudioPlayer shareInstance] createAudioPlayer:@"音频_光阴的故事.mp3"];
                [[AudioPlayer shareInstance] playAudioPlayer];
            } else if ([action.title isEqualToString:@"暂停音频"]) {
                [[AudioPlayer shareInstance] pauseAudioPlayer];
            } else if ([action.title isEqualToString:@"停止音频"]) {
                [[AudioPlayer shareInstance] stopAudioPlayer];
            }
        }];
    } else if ([titleString isEqualToString:@"视频"]) {
        [Toast showMessage:@"敬请期待"];
    } else if ([titleString isEqualToString:@"支付"]) {
        [Toast showMessage:@"敬请期待"];
    } else if ([titleString isEqualToString:@"即时通讯"]) {
        [Toast showMessage:@"敬请期待"];
    } else if ([titleString isEqualToString:@"友盟"]) {
        // TUDO: 统计和分享
        [Toast showMessage:@"敬请期待友盟统计和分享"];
    }
}

#pragma mark - <BannerDelegate>

- (BannerCell *)bannerCell {
    
    BannerCell *cell = [[BannerCell alloc] init];
    
    return cell;
}

- (NSUInteger)bannerCount {
    
    return _bannerList.count;
}

- (void)bannerCell:(BannerCell *)bannerCell cellIndex:(NSUInteger)index {
    
    if (_bannerList.count > 0) {
        if (index < _bannerList.count) {
            [bannerCell.imageView setImage:_bannerList[index]];
        } else {
            [bannerCell.imageView setImage:[UIImage imageNamed:@"Default_banner"]];
        }
    } else {
        [bannerCell.imageView setImage:[UIImage imageNamed:@"Default_banner"]];
    }
}

@end
