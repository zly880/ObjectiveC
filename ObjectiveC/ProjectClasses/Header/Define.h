//
//  Define.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#ifndef Define_h
#define Define_h

// 本地图片
#define IMAGE(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:(name)]]

// 颜色
#define COLOR_RGBA(r, g, b, a)  [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]
#define COLOR_RGB(r, g, b)      [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define Color_Random            [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

// 工程中常用宏
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

#endif /* Define_h */
