//
//  ImageMultipleHeader.m
//  ObjectiveC
//
//  Created by CLee on 2016/10/19.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "ImageMultipleHeader.h"

@implementation ImageMultipleHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleLabel.font = APPFONT_MID;
    _titleLabel.textColor = APPCOLOR_BLACK;
    self.backgroundColor = APPCOLOR_GRAYLIGHT;
}

@end
