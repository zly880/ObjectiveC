//
//  UIGestureRecognizer+Extend.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "UIGestureRecognizer+Extend.h"

@implementation UIGestureRecognizer (Extend)

/**
 *  封装的手势
 *
 *  @param view        手势要添加到得父视图
 *  @param gestureType 手势类型
 *  @param blocks      手势的操作函数
 */
+ (void)gestureOnView:(UIView *)view
          gestureType:(GestureType)gestureType
               blocks:(gesture)blocks {
    
    if (blocks) {
        _gesture = blocks;
    }
    // 避免崩溃
    [view setExclusiveTouch:YES];
    switch (gestureType) {
        case GestureTypeLeftSwipe: {
            UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(processgestureReconizer:)];
            leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
            [view addGestureRecognizer:leftSwipe];
            break;
        }
        case GestureTypeRightSwipe: {
            UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(processgestureReconizer:)];
            rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
            [view addGestureRecognizer:rightSwipe];
            break;
        }
        case GestureTypeSingleTap: {
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(processgestureReconizer:)];
            singleTap.numberOfTapsRequired = 1;
            [view addGestureRecognizer:singleTap];
            break;
        }
        case GestureTypeDoubleTap: {
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(processgestureReconizer:)];
            doubleTap.numberOfTapsRequired = 2;
            [view addGestureRecognizer:doubleTap];
            break;
        }
        case GestureTypePan: {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(processgestureReconizer:)];
            [view addGestureRecognizer:pan];
            break;
        }
        case GestureTypePinch: {
            UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(processgestureReconizer:)];
            [view addGestureRecognizer:pinch];
            break;
        }
        case GestureTypeRotation: {
            UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(processgestureReconizer:)];
            [view addGestureRecognizer:rotation];
            break;
        }
        case GestureTypeLongPress: {
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(processgestureReconizer:)];
            longPress.minimumPressDuration = 1.0;
            [view addGestureRecognizer:longPress];
            break;
        }
        default:
            break;
    }
}

+ (void)processgestureReconizer:(UIGestureRecognizer *)gesture {
    
    if (_gesture) {
        _gesture(gesture);
    }
}

// 手势处理函数
//- (void)processgestureReconizer:(UIGestureRecognizer *)gesture {
//    // 拖拽
//    if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
//        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gesture;
//        CGPoint startCenter;
//        if (pan.state == UIGestureRecognizerStateBegan) {
//            startCenter = gesture.view.center;
//        } else if (pan.state == UIGestureRecognizerStateChanged) {
//            // 此处必须从self.view中获取translation，因为translation和view的transform属性挂钩，若transform改变了则translation也会变
//            CGPoint translation = [pan translationInView:self.view];
//            gesture.view.center = CGPointMake(startCenter.x + translation.x, startCenter.y + translation.y);
//        } else if (pan.state == UIGestureRecognizerStateEnded) {
//            startCenter = CGPointZero;
//        }
//    }
//    // 缩放
//    else if ([gesture isKindOfClass:[UIPinchGestureRecognizer class]]) {
//        UIPinchGestureRecognizer *pinch = (UIPinchGestureRecognizer *)gesture;
//        CGFloat startScale;
//        if (pinch.state == UIGestureRecognizerStateBegan) {
//            startScale = pinch.scale;
//        } else if (pinch.state == UIGestureRecognizerStateChanged) {
//            CGFloat scale = (pinch.scale - startScale) / 2 + 1;
//            gesture.view.transform = CGAffineTransformScale(gesture.view.transform, scale, scale);
//            startScale = pinch.scale;
//        } else if (pinch.state == UIGestureRecognizerStateEnded) {
//            startScale = 1;
//        }
//    }
//    // 旋转
//    else if ([gesture isKindOfClass:[UIRotationGestureRecognizer class]]) {
//        UIRotationGestureRecognizer *rotate = (UIRotationGestureRecognizer *)gesture;
//        CGFloat startRotation;
//        if (rotate.state == UIGestureRecognizerStateBegan) {
//            startRotation = rotate.rotation;
//        } else if (rotate.state == UIGestureRecognizerStateChanged) {
//            CGFloat rotation = (rotate.rotation - startRotation) / 2;
//            gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, rotation);
//            startRotation = rotate.rotation;
//        } else if (rotate.state == UIGestureRecognizerStateEnded) {
//            startRotation = 0;
//        }
//    }
//}

@end
