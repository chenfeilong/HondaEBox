//
//  NetWorking.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "JSONKit.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"

@interface NetWorking : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *responsseData;
}

//单例
+ (NetWorking*)shareNetWorking;

/******************************************************
 ** 功能:     初始化系统
 ** 参数:     设备信息
 ** 返回:     初始化结果成功/失败
 ******************************************************/
- (void)chushiSystemWithPostBody:(NSDictionary *)postBody;

/******************************************************
 ** 功能:     登录
 ** 参数:     账号（手机号、邮箱）、密码（md5加密）、设备Token字符串(deviceNo)
 ** 返回:     登录结果成功/失败
 ******************************************************/
- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andDeviceNo:(NSString *)deviceNo;

/******************************************************
 ** 功能:     应用列表查询
 ** 参数:     暂无
 ** 返回:     暂无
 ******************************************************/
-(void)getAppForm;

/******************************************************
 ** 功能:     数据包升级
 ** 参数:     暂无
 ** 返回:     暂无
 ******************************************************/
- (void)upgradeDataPack;

/******************************************************
 ** 功能:     注册
 ** 参数:     暂无
 ** 返回:     暂无
 ******************************************************/
//- (void)registUserInfo:(NSDictionary *)parameters;

/******************************************************
 ** 功能:     预约保养
 ** 参数:     暂无
 ** 返回:     暂无
 ******************************************************/
- (void)mainTainServer:(NSDictionary *)bodyDic;

@end
