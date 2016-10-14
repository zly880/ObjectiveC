//
//  TextFieldInsets.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldInsets : UITextField

// 输入框的偏移位置
@property (nonatomic) UIEdgeInsets textInset;

/**
 *  设置输入框的左右图片视图
 *
 *  @param leftOrRight    YES 表示左边图片，NO 表示右边图片
 *  @param imageName      图片名称
 *  @param imageBackColor 图片的背景颜色
 */
- (void)textFieldModify:(BOOL)leftOrRight
              imageName:(NSString *)imageName
         imageBackColor:(UIColor *)imageBackColor;

@end
