//
//  UIAlertController+Extend.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "UIAlertController+Extend.h"

@implementation UIAlertController (Extend)

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
             blocks:(void (^)(UIAlertAction *action))blocks {
    
    if (vc == nil || buttonTitles == nil || buttonTitles.count <= 0) {
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    for (NSString *buttonTitle in buttonTitles) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (blocks) {
                                                                    blocks(action);
                                                                }
                                                            }];
        [alert addAction:alertAction];
    }
    [vc presentViewController:alert animated:YES completion:nil];
}

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
                   blocks:(void (^)(UIAlertAction *action))blocks {
    
    if (vc == nil || buttonTitles == nil || buttonTitles.count <= 0) {
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *buttonTitle in buttonTitles) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (blocks) {
                                                                    blocks(action);
                                                                }
                                                            }];
        [alert addAction:alertAction];
    }
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
