//
//  UIAlertController+Extend.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extend)

/**
 *  弹出一个提示框，包含一组按钮，居屏幕正中
 *
 *  @param vc           来源控制器
 *  @param title        标题
 *  @param message      描述信息
 *  @param buttonTitles 按钮标题数组
 *  @param blocks       点击对应按钮之后的操作
 */
+ (void)alertFromVC:(UIViewController *)vc
              title:(NSString *)title
            message:(NSString *)message
       buttonTitles:(NSArray *)buttonTitles
             blocks:(void (^)(UIAlertAction *action))blocks;

/**
 *  弹出一个提示列表，包含一组按钮，居屏幕下方
 *
 *  @param vc           来源控制器
 *  @param title        标题
 *  @param message      描述信息
 *  @param buttonTitles 按钮标题数组
 *  @param blocks       点击对应按钮之后的操作
 */
+ (void)actionSheetFromVC:(UIViewController *)vc
                    title:(NSString *)title
                  message:(NSString *)message
             buttonTitles:(NSArray *)buttonTitles
                   blocks:(void (^)(UIAlertAction *action))blocks;

@end
