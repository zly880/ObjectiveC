//
//  CollectionViewCell.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleLabel.font = APPFONT_MID;
    _titleLabel.textColor = APPCOLOR_TINT;
    self.backgroundColor = APPCOLOR_WHITE;
}

@end
