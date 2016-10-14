//
//  NSString+Extend.m
//  ObjectiveC
//
//  Created by CLee on 16/9/30.
//  Copyright © 2016年 CLee. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

// 沙盒路径：程序主路径
+ (NSString *)homeDirectory {
    
    return NSHomeDirectory();
}

// Document: 最常用的目录，iTunes同步该应用时会同步此文件夹中的内容，适合存储重要数据
+ (NSString *)documentPath {
    
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
}

// Library/Preferences: iTunes同步该应用时会同步此文件夹中的内容，通常保存应用的设置信息
+ (NSString *)preferencesPath {
    
    return NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES).lastObject;
}

// Library/Caches: iTunes不会同步此文件夹，适合存储体积大，不需要备份的非重要数据
+ (NSString *)cachesPath {
    
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
}

// tmp: iTunes不会同步此文件夹，系统可能在应用没运行时就删除该目录下的文件，所以此目录适合保存应用中的一些临时文件，用完就删除
+ (NSString *)tmpPath {
    
    return NSTemporaryDirectory();
}

/**
 *  判断是否为纯数字
 *
 *  @return 返回是，符合规定，返回否，不符合规定
 */
- (BOOL)isPureInt {
    
    if (self == nil || self.length <= 0) {
        return NO;
    }
    
    NSInteger val;
    NSScanner *scan = [NSScanner scannerWithString:self];
    return [scan scanInteger:&val] && [scan isAtEnd];
}

/**
 *  判断是否为11位手机号码,首位为1
 *
 *  @return 返回是，手机号码符合规定，返回否，手机号码不符合规定
 */
- (BOOL)isPhoneNumber {
    
    if (self == nil || self.length != 11 || [self hasPrefix:@"1"] == NO || [self isPureInt] == NO) {
        return NO;
    } else {
        return YES;
    }
}

/**
 *  判断是否是邮箱格式
 *
 *  @return 返回是，邮箱设置符合规定，返回否，邮箱设置不符合规定
 */
- (BOOL)isEmail {
    
    if (self == nil || self.length <= 0) {
        return NO;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/**
 *  判断密码是否是8到20位字母加数字
 *
 *  @return 返回是，密码设置符合规定，返回否，密码设置不符合规定
 */
- (BOOL)isPassword {
    
    if (self == nil || self.length <= 0) {
        return NO;
    }
    
    NSString *passwdRegex = @"^[a-zA-Z0-9]{8,20}+$";
    NSPredicate *passwdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwdRegex];
    BOOL ret = [passwdPredicate evaluateWithObject:self];
    if (ret == YES) {
        // 符合数字条件的有几个字元
        NSRegularExpression *numRX = [NSRegularExpression regularExpressionWithPattern:@"[0-9]"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSInteger numCount = [numRX numberOfMatchesInString:self
                                                    options:NSMatchingReportProgress
                                                      range:NSMakeRange(0, self.length)];
        // 英文字条件的有几个字元
        NSRegularExpression *letterRx = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]"
                                                                                  options:NSRegularExpressionCaseInsensitive
                                                                                    error:nil];
        NSInteger letterCount = [letterRx numberOfMatchesInString:self
                                                          options:NSMatchingReportProgress
                                                            range:NSMakeRange(0, self.length)];
        if (numCount == 0 || letterCount == 0) {
            ret = NO;
        }
    }
    
    return ret;
}

/**
 *  根据字号计算字符串的宽度,该方法适用于比较短的字符串，且不能计算特殊字符
 *
 *  @param font 字号
 *
 *  @return 字符串的宽度
 */
- (CGFloat)widthOfStringWithFont:(UIFont *)font {
    
    if (self == nil || self.length <= 0 || font == nil) {
        return 0;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName : font};
    CGFloat width = [[[NSAttributedString alloc] initWithString:self attributes:attributes] size].width;
    
    return width;
}

/**
 *  动态计算文本的尺寸
 *
 *  @param size 视图的尺寸
 *  @param font 字号
 *
 *  @return 动态计算文本的尺寸大小
 */
- (CGSize)sizeOfStringWithSize:(CGSize)size font:(UIFont *)font {
    
    // 检查参数
    if (self == nil || self.length <= 0 || font == nil) {
        return CGSizeZero;
    }
    
    //配置字符绘制规则
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine
    | NSStringDrawingUsesFontLeading
    | NSStringDrawingUsesLineFragmentOrigin;
    //计算文本大小
    CGRect rect = [self boundingRectWithSize:CGSizeMake(size.width, HUGE)
                                     options:options
                                  attributes:@{NSFontAttributeName : font}
                                     context:NULL];
    
    return rect.size;
}

/**
 *  字符串编码
 *
 *  @return 编码之后的字符串，提供给NSURL
 */
- (NSString *)stringEncode {
    
    if (self == nil || self.length <= 0) {
        return @"";
    }
    
    NSString *encodingString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return encodingString;
}

/**
 *  字符串解码
 *
 *  @return 解码之后的字符串，可直接识别
 */
- (NSString *)stringDecode {
    
    if (self == nil || self.length <= 0) {
        return @"";
    }
    
    NSString *decodeString = [self stringByRemovingPercentEncoding];
    
    return decodeString;
}

/**
 *  汉字转拼音
 *
 *  @return 拼音
 */
- (NSString *)chineseToPinyin {
    
    if (self == nil || self.length <= 0) {
        return @"";
    }
    
    CFStringRef hanzi = (__bridge CFStringRef)self;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, hanzi);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinyin = (NSString *)CFBridgingRelease(string);
    
    return pinyin;
}

@end
