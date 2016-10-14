//
//  VideoPlayer.m
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "VideoPlayer.h"

@implementation VideoPlayer

/**
 获取模块单例
 
 @return 实例对象
 */
+ (VideoPlayer *)shareInstance {
    
    static VideoPlayer *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[VideoPlayer alloc] init];
    });
    
    return instance;
}

@end
