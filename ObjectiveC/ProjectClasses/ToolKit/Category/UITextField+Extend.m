//
//  UITextField+Extend.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "UITextField+Extend.h"

@implementation UITextField (Extend)

/**
 *  是否允许粘贴，选择，替换
 *
 *  @param action 粘贴，选择，替换操作
 *  @param sender 消息发送者
 *
 *  @return YES表示允许操作，NO表示禁止操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    
    if (action == @selector(paste:))
        return NO;
    if (action == @selector(select:))
        return NO;
    if (action == @selector(selectAll:))
        return NO;
    if (action == @selector(replaceRange:withText:)) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end
