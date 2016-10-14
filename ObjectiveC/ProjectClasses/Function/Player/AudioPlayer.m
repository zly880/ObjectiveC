//
//  AudioPlayer.m
//  ObjectiveC
//
//  Created by CLee on 16/10/9.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "AudioPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AudioPlayer () <AVAudioPlayerDelegate>

@property (nonatomic, assign) SystemSoundID soundID;        // 音效ID
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;   // 音频播放器

@end

@implementation AudioPlayer

/**
 获取单例模块
 
 @return 实例对象
 */
+ (AudioPlayer *)shareInstance {
    
    static AudioPlayer *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[AudioPlayer alloc] init];
    });
    
    return instance;
}

#pragma mark - 音效

//- 音频播放时间不能超过30s
//- 数据必须是PCM或者IMA4格式
//- 音频文件必须打包成.caf、.aif、.wav中的一种（注意这是官方文档的说法，实际测试发现一些.mp3也可以播放）
/**
 播放音效文件
 
 @param name    音效文件名称
 @param vibrate YES表示播放音效并震动，NO表示只播放音效不震动
 */
- (void)playSoundEffect:(NSString *)name vibrate:(BOOL)vibrate {
    
    // 关闭音频播放
    [self stopAudioPlayer];
    
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    // 获得系统声音ID
    _soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &_soundID);
    // 监听播放完成操作
    AudioServicesAddSystemSoundCompletion(_soundID, NULL, NULL, soundCompleteCallback, NULL);
    // 播放音效
    if (vibrate == NO) {
        // 播放音效
        AudioServicesPlaySystemSound(_soundID);
    } else {
        // 播放音效并震动
        AudioServicesPlayAlertSound(_soundID);
    }
}

// 关闭音效
- (void)stopSoundEffect {
    
    AudioServicesDisposeSystemSoundID(_soundID);
}

// 监听音效播放结束
void soundCompleteCallback(SystemSoundID soundID, void *clientData) {
    
    NSLog(@"音效播放结束...");
}

#pragma mark - 本地音频播放

/**
 创建音频播放器
 
 @param name 本地音频文件名称
 */
- (void)createAudioPlayer:(NSString *)name {
    
    // 关闭音效
    [self stopSoundEffect];
    
    if (self.audioPlayer == nil) {
        NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
        // 创建音频播放器
        NSError *error = nil;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
        // 设置播放器属性
        // 设置为0不循环
        self.audioPlayer.numberOfLoops = 0;
        self.audioPlayer.delegate = self;
        // 加载音频文件到缓存
        [self.audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"初始化播放器过程发生错误,错误信息:%@", error.localizedDescription);
            return;
        }
    }
}

// 播放
- (void)playAudioPlayer {
    
    if (self.audioPlayer != nil && [self.audioPlayer isPlaying] == NO) {
        [self.audioPlayer play];
    }
}

// 暂停
- (void)pauseAudioPlayer {
    
    if (self.audioPlayer != nil && [self.audioPlayer isPlaying] == YES) {
        [self.audioPlayer pause];
    }
}

// 停止
- (void)stopAudioPlayer {
    
    if (self.audioPlayer != nil) {
        [self.audioPlayer stop];
        self.audioPlayer = nil;
    }
}

#pragma mark - <AVAudioPlayerDelegate>

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    NSLog(@"音频播放结束...");
    [self playAudioPlayer];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    
    NSLog(@"音频播放失败...");
}

@end
