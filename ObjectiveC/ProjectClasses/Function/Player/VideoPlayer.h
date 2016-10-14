//
//  VideoPlayer.h
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoPlayer : NSObject

/**
 获取模块单例
 
 @return 实例对象
 */
+ (VideoPlayer *)shareInstance;

@end
