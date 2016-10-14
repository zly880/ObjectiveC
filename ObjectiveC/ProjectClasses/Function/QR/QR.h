//
//  QR.h
//  ObjectiveC
//
//  Created by CLee on 16/10/8.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "BaseController.h"

@interface QR : BaseController

@property (nonatomic, copy) void(^QRScanResult)(NSString *qrScanResult);

@end
