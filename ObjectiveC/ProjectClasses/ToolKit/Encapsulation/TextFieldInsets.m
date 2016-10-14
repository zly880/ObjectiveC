//
//  TextFieldInsets.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "TextFieldInsets.h"

@implementation TextFieldInsets

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _textInset = UIEdgeInsetsZero;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _textInset = UIEdgeInsetsZero;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _textInset = UIEdgeInsetsZero;
    }
    
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    CGRect textRectForBounds = [super textRectForBounds:bounds];
    textRectForBounds = UIEdgeInsetsInsetRect(textRectForBounds, _textInset);
    return textRectForBounds;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    
    CGRect placeholderRectForBounds = [super placeholderRectForBounds:bounds];
    placeholderRectForBounds = UIEdgeInsetsInsetRect(placeholderRectForBounds, _textInset);
    return placeholderRectForBounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    CGRect editingRectForBounds = [super textRectForBounds:bounds];
    editingRectForBounds = UIEdgeInsetsInsetRect(editingRectForBounds, _textInset);
    return editingRectForBounds;
}

/**
 *  设置输入框的左右图片视图
 *
 *  @param leftOrRight    YES 表示左边图片，NO 表示右边图片
 *  @param imageName      图片名称
 *  @param imageBackColor 图片的背景颜色
 */
- (void)textFieldModify:(BOOL)leftOrRight
              imageName:(NSString *)imageName
         imageBackColor:(UIColor *)imageBackColor {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.backgroundColor = imageBackColor ? imageBackColor : [UIColor whiteColor];
    imageView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    imageView.contentMode = UIViewContentModeCenter;
    imageView.layer.masksToBounds = YES;
    
    if (leftOrRight == YES) {
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
    } else {
        self.rightView = imageView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    self.returnKeyType = UIReturnKeyDone;
}

@end
