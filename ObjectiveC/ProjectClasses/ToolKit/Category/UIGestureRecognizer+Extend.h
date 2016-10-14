//
//  UIGestureRecognizer+Extend.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GestureType) {
    GestureTypeLeftSwipe,     // 左滑
    GestureTypeRightSwipe,    // 右滑
    GestureTypeSingleTap,     // 单击
    GestureTypeDoubleTap,     // 双击
    GestureTypePan,           // 拖拽
    GestureTypePinch,         // 缩放
    GestureTypeRotation,      // 旋转
    GestureTypeLongPress,     // 长按
};

typedef void(^gesture)(UIGestureRecognizer *gesture);
static gesture _gesture;

@interface UIGestureRecognizer (Extend)

/**
 *  封装的手势
 *
 *  @param view        手势要添加到得父视图
 *  @param gestureType 手势类型
 *  @param blocks      手势的操作函数
 */
+ (void)gestureOnView:(UIView *)view
          gestureType:(GestureType)gestureType
               blocks:(gesture)blocks;

@end
