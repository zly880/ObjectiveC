//
//  NetworkDefine.h
//  ObjectiveC
//
//  Created by CLee on 16/10/10.
//  Copyright © 2016年 CLee. All rights reserved.
//

// HTTP 请求错误码可以根据错误码从左往右第一个数字大致分为以下几类：
// 1XX: 信息提示。不代表成功或者失败，表示临时响应，比如100表示继续，101表示切换协议
// 2XX: 成功
// 3XX: 重定向
// 4XX: 客户端错误
// 5XX: 服务器错误

#ifndef NetworkDefine_h
#define NetworkDefine_h

#define __TIMEOUT__ 15          // 网络超时，15秒
#define __SELECTENVIRONMENT__ 1 // 选择开发环境

typedef NS_ENUM(NSUInteger, EnvironmentType) {
    EnvironmentTypeRelease = 1, // 正式环境
    EnvironmentTypePreRelease,  // 预发布正式环境
    EnvironmentTypePublic,      // 公测环境
    EnvironmentTypePrePublic,   // 预发布公测环境
    EnvironmentTypeDeveloper,   // 开发环境，内测环境
};

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestTypeNormal,          // 普通请求
    RequestTypeUploadImage,     // 上传图片
    RequestTypeUploadFile,      // 上传文件
    RequestTypeDownload,        // 下载文件
};

// 域名
static NSString *DomainName             = @"www.baidu.com";
static NSString *DomainNameUploadImage  = @"www.baidu.com";
static NSString *DomainNameUploadFile   = @"www.baidu.com";
static NSString *DomainNameDownloadFile = @"www.baidu.com";

// 服务端返回数据的基本格式
static NSString *Code           = @"code";      // 状态码
static NSString *Message        = @"message";   // 提示信息
static NSString *Content        = @"content";   // 数据内容
static NSString *URL            = @"url";       // 完整链接
// 状态码
static NSString *SuccessCode    = @"200";       // 成功状态码
// 提示信息
static NSString *NetError       = @"无可用网络连接,请检查网络设置";
static NSString *DataNone       = @"数据为空";
static NSString *DataError      = @"数据解析失败";
static NSString *DataNeedJSON   = @"数据格式错误";

#endif /* NetworkDefine_h */
