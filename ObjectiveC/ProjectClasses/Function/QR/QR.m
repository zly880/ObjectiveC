//
//  QR.m
//  ObjectiveC
//
//  Created by CLee on 16/10/8.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "QR.h"

CGFloat QRWidth = 220.0f; // 扫描框宽度

@interface QRBackView : UIView

@end

@implementation QRBackView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat x = (self.bounds.size.width - QRWidth) * 0.5;
    CGFloat y = (self.bounds.size.height - QRWidth) * 0.5;
    CGRect rRect = CGRectMake(x, y, QRWidth, QRWidth);
    CGContextSetBlendMode(contextRef, kCGBlendModeClear);
    CGContextFillRect(contextRef, rRect);
}

@end

//////////////////////////////////////////////////////////////

@interface QR () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) UIImageView *lineImageView;   // 扫描线
@property (nonatomic, assign) BOOL upOrDown;                // 扫描线向上或者向下
@property (nonatomic, strong) NSTimer *timer;               // 定时器

@end

@implementation QR

- (void)dealloc {
    
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_session startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_session stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"二维码扫描";
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        [self.view addSubview:[Toast errorViewWithFrame:self.view.bounds
                                              imageName:@"Default_icon"
                                                  title:@"您的设备不支持二维码扫描"]];
        return;
    }
    
    // 设置二维码扫描功能
    [self QR];
    // 添加自定义视图
    [self  addCustomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化二维码

- (void)QR {
    
    // 获取摄像设备,创建输入流,创建输出流
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 初始化链接对象,设置高质量采集率
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    // 设置视图捕获区域
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    // 设置扫码支持的编码格式
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    // 设置扫描作用区域，原点在屏幕右上角，向下是X轴，向左是Y轴
    // 设置为视图中间一片区域，非屏幕中间
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGRect rect = CGRectMake(((height - QRWidth) * 0.5) / height,
                             ((width - QRWidth) * 0.5) / width,
                             QRWidth / height,
                             QRWidth / width);
    [output setRectOfInterest:rect];
    //开始捕获
    [_session startRunning];
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate>

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if ([metadataObjects count] > 0) {
        NSString *stringValue = ((AVMetadataMachineReadableCodeObject *)[metadataObjects firstObject]).stringValue;
        if (stringValue.length > 0 && _QRScanResult != nil) {
            [_session stopRunning];
            _QRScanResult(stringValue);
        }
    }
}

#pragma mark - 添加自定义显示的视图

- (void)addCustomView {
    
    // 添加背景视图
    QRBackView *backView = [[QRBackView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [APPCOLOR_BLACK colorWithAlphaComponent:0.7];
    [self.view addSubview:backView];
    // 扫描框的原点
    CGFloat x = (CGRectGetWidth(self.view.bounds) - QRWidth) * 0.5;
    CGFloat y = (CGRectGetHeight(self.view.bounds) - QRWidth) * 0.5;
    // 提示语
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.frame = CGRectMake(0, y - 50, CGRectGetWidth(self.view.bounds), 30);
    tipLabel.text = @"将二维码放入框内，即可自动扫描";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = APPCOLOR_WHITE;
    tipLabel.font = APPFONT_MID;
    [self.view addSubview:tipLabel];
    // 动画线
    _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QR_line"]];
    _lineImageView.frame = CGRectMake(x, y, QRWidth, 2);
    [self.view addSubview:_lineImageView];
    // YES 标识向上，NO 标识向下
    _upOrDown = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:2
                                              target:self
                                            selector:@selector(timerHandler)
                                            userInfo:nil
                                             repeats:YES];
    [_timer fire];
}

- (void)timerHandler {
    
    // 扫描框的原点
    CGFloat x = (CGRectGetWidth(self.view.bounds) - QRWidth) * 0.5;
    CGFloat y = (CGRectGetHeight(self.view.bounds) - QRWidth) * 0.5;
    CGFloat height = CGRectGetHeight(_lineImageView.bounds);
    if (_upOrDown == NO) {
        [UIView beginAnimations:@"animationDown" context:NULL];
        [UIView setAnimationDuration:2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatCount:1];
        [_lineImageView setFrame:CGRectMake(x, y + QRWidth - height, QRWidth, height)];
        [UIView commitAnimations];
    } else if (_upOrDown == YES) {
        [UIView beginAnimations:@"animationUp" context:NULL];
        [UIView setAnimationDuration:2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatCount:1];
        [_lineImageView setFrame:CGRectMake(x, y, QRWidth, height)];
        [UIView commitAnimations];
    }
    _upOrDown = !_upOrDown;
}

@end
