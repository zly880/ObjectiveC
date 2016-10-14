//
//  UITextField+Extend.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extend)

/**
 *  是否允许粘贴，选择，替换
 *
 *  @param action 粘贴，选择，替换操作
 *  @param sender 消息发送者
 *
 *  @return YES表示允许操作，NO表示禁止操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender;

@end
