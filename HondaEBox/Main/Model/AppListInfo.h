//
//  AppListInfo.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-7.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AppListInfo : NSObject

@property (nonatomic, copy) NSString * targetPath;          //下载保存目标路径
@property (nonatomic, copy) NSString * carCache;            //缓存路径
@property (nonatomic, copy) NSString * tempPath;            //临时下载路径
@property (nonatomic, copy) NSString * appName;             //应用名称
@property (nonatomic, copy) NSString * appUrl;              //应用下载地址
@property (nonatomic, copy) NSString * schema;              //应用URL schema
@property (nonatomic, copy) NSString * appIconPath;         //应用图片地址
@property (nonatomic, copy) NSString * appDesc;             //应用描述
@property (nonatomic, copy) NSString * appVersion;          //应用版本
@property (nonatomic, copy) NSString * appSize;             //应用大小
@property (nonatomic, strong) NSArray * picsPath;            //应用图片预览

@property (nonatomic, assign) long long totalBytesRead;
@property (nonatomic, assign) long long totalBytesExpectedToRead;

@property (nonatomic, strong) AFURLConnectionOperation *operation;
@property (nonatomic) BOOL willDownload;            //将要下载
@property (nonatomic) BOOL isDownloading;           //正下下载
@property (nonatomic) BOOL downloadFinished;        //下载完成
@property (nonatomic) BOOL error;

- (id)initWithApps:(NSDictionary *)appsDic;

@end
