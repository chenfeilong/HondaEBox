//
//  NetWorking.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "NetWorking.h"
#import "Define.h"
#import "ExtendClass.h"
#import "DESUtil.h"

@implementation NetWorking

//单例
+ (NetWorking *)shareNetWorking
{
    static NetWorking *netWork = nil;
    static dispatch_once_t singleLeton;
    dispatch_once(&singleLeton, ^{
        netWork = [[NetWorking alloc] init];
    });
    
    return netWork;
}

/******************************************************
 ** 功能:     初始化系统
 ** 参数:     设备信息
 ** 返回:     初始化结果成功/失败
 ******************************************************/
- (void)chushiSystemWithPostBody:(NSDictionary *)postBody
{
    NSDictionary *parameters = @{@"body": postBody,@"method":REQCODE_CHUSHISYSTEM};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:GB_REQUEST parameters:[[parameters JSONString] JSONValue] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"初始化系统成功:%@",responseObject);
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"chushiSystemFinished" object:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"初始化系统失败:%@",[error description]);
    }];
}

/******************************************************
 ** 功能:     注册
 ** 参数:     账号，密码
 ** 返回:     注册成功/失败
 ******************************************************/
- (void)Register:(NSDictionary *)postBody
{
    NSDictionary *parameters = @{@"body": postBody,@"method":REQCODE_CHUSHISYSTEM};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:GB_REQUEST parameters:[[parameters JSONString] JSONValue] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"初始化系统成功:%@",responseObject);
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"chushiSystemFinished" object:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"初始化系统失败:%@",[error description]);
    }];
}


/******************************************************
 ** 功能:     登录
 ** 参数:     账号（手机号、邮箱）、密码（md5加密）、设备Token字符串(deviceNo)
 ** 返回:     登录结果成功/失败
 ******************************************************/
- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andDeviceNo:(NSString *)deviceNo
{
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [bodyDic setObject:userName forKey:@"userName"];
//    [bodyDic setObject:passWord forKey:@"password"];
    NSString *enCryUserName = [DESUtil encrypt:userName];
//    NSString *enCryPassWord = [DESUtil encrypt:[userName md5HexDigest]];
    [bodyDic setObject:enCryUserName forKey:@"userName"];
    [bodyDic setObject:[userName md5HexDigest] forKey:@"password"];
    [bodyDic setObject:[NSString stringWithFormat:@"userName"] forKey:@"encryptFields"];
    NSString *token = CESHI_TOKEN;
    [bodyDic setObject:token forKey:@"deviceId"];
    
    NSDictionary *parameters = @{@"body": bodyDic,@"method":REQCODE_LOGIN};
    NSLog(@"Parameters:%@",parameters);
//    NSString *dicStr = [[parameters JSONString] JSONValue];
//    DLog(@"未加密前:%@",dicStr);
//    NSString *enCryStr = [DESUtil encrypt:[NSString stringWithFormat:@"%@",dicStr]];
//    DLog(@"加密后:%@",enCryStr);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:GB_REQUEST_JIAMI parameters:[[parameters JSONString] JSONValue] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"Success:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Faile:%@",error);
    }];
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:GB_REQUEST_JIAMI]];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[enCryStr dataUsingEncoding:NSUTF8StringEncoding]];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"请求成功:%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"Failed:%@",[error description]);
//    }];
//    [operation start];
    
//    DLog(@"*****%@",[DESUtil decrypt:enCryStr]);
//    NSURL *url = [NSURL URLWithString:GB_REQUEST_JIAMI];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    NSLog(@"Data = %@",[enCryStr dataUsingEncoding:NSUTF8StringEncoding]);
//    NSString *str = [[NSString alloc] initWithData:[enCryStr dataUsingEncoding:NSUTF8StringEncoding] encoding:NSUTF8StringEncoding];
//    NSLog(@"Str = %@",str);
//    [request setHTTPBody:[enCryStr dataUsingEncoding:NSUTF8StringEncoding]];
//    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responsseData = [NSMutableData data];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responsseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *dataStr = [[NSString alloc] initWithData:responsseData encoding:NSUTF8StringEncoding];
    DLog(@"Finished:%@",[DESUtil decrypt:dataStr]);
}

/******************************************************
 ** 功能:     应用列表查询
 ** 参数:     暂无
 ** 返回:     暂无
 ******************************************************/
-(void)getAppForm
{
    NSDictionary *parameters = @{@"body": @{@"appOS": @"1"},@"method":@"REQ_0004"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:GB_REQUEST parameters:[[parameters JSONString] JSONValue] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"应用列表请求成功:%@",responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getAppFormFinished" object:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"应用列表请求失败:%@",[error description]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getAppFormFinished" object:@"请求失败"];
    }];
}

/******************************************************
 ** 功能:     数据包升级
 ** 参数:     暂无
 ** 返回:     暂无
 ******************************************************/
- (void)upgradeDataPack
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"body": @{@"code": @"Accord,Crosstour",@"version":@"-1,-1"},@"method":REQCODE_UPDATE_DATAPACK};
    DLog(@"parameters:%@",parameters);
    [manager POST:GB_REQUEST parameters:[[parameters JSONString] JSONValue] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        DLog(@"数据包升级请求成功:%@",responseDic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"upgradeDataPackFinished" object:responseDic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"数据包升级请求失败:%@",[error description]);
    }];
}

/******************************************************
 ** 功能:     预约保养
 ** 参数:     暂无
 ** 返回:     暂无
 ******************************************************/
- (void)mainTainServer:(NSDictionary *)bodyDic
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:bodyDic,@"body",REQCODE_VEHICLE_MAINTENANCE,@"method", nil];
    [manager POST:GB_REQUEST parameters:[[parameters JSONString] JSONValue] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"预约保养请求成功:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"预约保养请求失败:%@",[error description]);
    }];
}

@end
