//
//  AudioPlayer.h
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioPlayer : NSObject

/**
 获取单例模块
 
 @return 实例对象
 */
+ (AudioPlayer *)shareInstance;

#pragma mark - 音效

/**
 播放音效文件
 
 @param name    音效文件名称
 @param vibrate YES表示播放音效并震动，NO表示只播放音效不震动
 */
- (void)playSoundEffect:(NSString *)name vibrate:(BOOL)vibrate;

#pragma mark - 本地音频播放

/**
 创建音频播放器
 
 @param name 本地音频文件名称
 */
- (void)createAudioPlayer:(NSString *)name;
// 播放
- (void)playAudioPlayer;
// 暂停
- (void)pauseAudioPlayer;
// 停止
- (void)stopAudioPlayer;

@end
