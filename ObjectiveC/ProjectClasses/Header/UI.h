//
//  UI.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#ifndef UI_h
#define UI_h

// 获取屏幕尺寸
#define SCREEN_SIZE     [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

// 不同屏幕的点
#define HEIGHT_3P5      480.0f
#define HEIGHT_4P0      568.0f
#define HEIGHT_4P7      667.0f
#define HEIGHT_5P5      736.0f
#define WIDTH_3P5       320.0f
#define WIDTH_4P0       320.0f
#define WIDTH_4P7       375.0f
#define WIDTH_5P5       414.0f

// 状态栏，导航栏，标签栏的高度
#define STATUS_HEIGHT   20.0f
#define NAV_HEIGHT      44.0f
#define TOP_HEIGHT      64.0f
#define TABBAR_HEIGHT   49.0f

// 系统主色调
#define APPCOLOR_TINT       COLOR_RGB( 48, 177, 229)
#define APPCOLOR_TINTLIGHT  COLOR_RGB(198, 236, 255)
#define APPCOLOR_GRAY       COLOR_RGB(130, 130, 130)
#define APPCOLOR_GRAYLIGHT  COLOR_RGB(234, 234, 234)
#define APPCOLOR_CLEAR      [UIColor clearColor]
#define APPCOLOR_WHITE      COLOR_RGB(255, 255, 255)
#define APPCOLOR_BLACK      COLOR_RGB( 30,  30,  30)
#define APPCOLOR_RED        COLOR_RGB(255,   0,   0)

// 系统字体规范
#define APPFONT_BIG         [UIFont systemFontOfSize:18]
#define APPFONT_MID         [UIFont systemFontOfSize:15]
#define APPFONT_SMALL       [UIFont systemFontOfSize:13]
#define APPFONT_MINI        [UIFont systemFontOfSize:10]

#endif /* UI_h */
