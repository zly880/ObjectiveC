//
//  CollectionViewFooter.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "CollectionViewFooter.h"

@implementation CollectionViewFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleLabel.font = APPFONT_MINI;
    _titleLabel.textColor = APPCOLOR_TINT;
    _leftView.backgroundColor = APPCOLOR_TINT;
    _rightView.backgroundColor = APPCOLOR_TINT;
}

@end
