//
//  NSString+Extend.h
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

// 沙盒路径：程序主路径
+ (NSString *)homeDirectory;
// Document: 最常用的目录，iTunes同步该应用时会同步此文件夹中的内容，适合存储重要数据
+ (NSString *)documentPath;
// Library/Preferences: iTunes同步该应用时会同步此文件夹中的内容，通常保存应用的设置信息
+ (NSString *)preferencesPath;
// Library/Caches: iTunes不会同步此文件夹，适合存储体积大，不需要备份的非重要数据
+ (NSString *)cachesPath;
// tmp: iTunes不会同步此文件夹，系统可能在应用没运行时就删除该目录下的文件，所以此目录适合保存应用中的一些临时文件，用完就删除
+ (NSString *)tmpPath;

/**
 *  判断是否为纯数字
 *
 *  @return 返回是，符合规定，返回否，不符合规定
 */
- (BOOL)isPureInt;

/**
 *  判断是否为11位手机号码,首位为1
 *
 *  @return 返回是，手机号码符合规定，返回否，手机号码不符合规定
 */
- (BOOL)isPhoneNumber;

/**
 *  判断是否是邮箱格式
 *
 *  @return 返回是，邮箱设置符合规定，返回否，邮箱设置不符合规定
 */
- (BOOL)isEmail;

/**
 *  判断密码是否是8到20位字母加数字
 *
 *  @return 返回是，密码设置符合规定，返回否，密码设置不符合规定
 */
- (BOOL)isPassword;

/**
 *  根据字号计算字符串的宽度,该方法适用于比较短的字符串，且不能计算特殊字符
 *
 *  @param font 字号
 *
 *  @return 字符串的宽度
 */
- (CGFloat)widthOfStringWithFont:(UIFont *)font;

/**
 *  动态计算文本的尺寸
 *
 *  @param size 视图的尺寸
 *  @param font 字号
 *
 *  @return 动态计算文本的尺寸大小
 */
- (CGSize)sizeOfStringWithSize:(CGSize)size font:(UIFont *)font;

/**
 *  字符串编码
 *
 *  @return 编码之后的字符串，提供给NSURL
 */
- (NSString *)stringEncode;

/**
 *  字符串解码
 *
 *  @return 解码之后的字符串，可直接识别
 */
- (NSString *)stringDecode;

/**
 *  汉字转拼音
 *
 *  @return 拼音
 */
- (NSString *)chineseToPinyin;

@end
