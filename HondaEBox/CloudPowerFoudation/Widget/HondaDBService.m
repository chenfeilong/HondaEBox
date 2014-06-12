//
//  HondaDBService.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-19.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "HondaDBService.h"
#import "DataFactory.h"
#import "LKDaoBase.h"

#import "MessageInfo.h"
#import "FunctionInfo.h"

@implementation HondaDBService

/**
 *  单例
 *
 *  @return HondaDBService对象
 */
+ (HondaDBService *)shareHondaDBService
{
    static HondaDBService *hondaDBService = nil;
    static dispatch_once_t singleLeton;
    dispatch_once(&singleLeton, ^{
        hondaDBService = [[HondaDBService alloc] init];
    });
    
    return hondaDBService;
}

- (NSDictionary *)dictionary:(NSString *)key value:(id)value
{
    if (!value || !key)
    {
        return nil;
    }
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:value forKey:key];
    return dic;
}

/**********************************
 ***  messageInfo
 **********************************/

/**
*  从数据库中获取MessageInfo对象
*
*  @param messageID messageID识别号
*/
- (MessageInfo *)getMessageInfoByMessageID:(NSString *)messageID
{
    if (messageID == nil || messageID.length == 0)
    {
        return nil;
    }
    
    __block MessageInfo *messageInfo = nil;
    [[DataFactory shardDataFactory] searchWhereString:[[@"ID = '" stringByAppendingString:messageID] stringByAppendingString:@"' "] orderBy:nil offset:0 count:50 Classtype:MESSAGE_INFO callback:^(NSArray *array) {
        if (array && array.count != 0)
        {
            messageInfo = (MessageInfo *)[array objectAtIndex:[array count] - 1];
        }
    }];
    
    return messageInfo;
}

- (void)saveMessageInfo:(MessageInfo *)messageInfo
{
    if (messageInfo == nil)
    {
        return;
    }
    
    MessageInfo *messageInfoTemp = [self getMessageInfoByMessageID:messageInfo.ID];
    if (messageInfoTemp)                //数据库中已存在此条数据，更新
    {
        [self updateMessageInfo:messageInfo];
    }
    else
    {
        [[DataFactory shardDataFactory] insertToDB:messageInfo Classtype:MESSAGE_INFO];
    }
}

/**
 *  更新数据库MessageInfo对象
 *
 *  @param messageInfo message
 */
- (void)updateMessageInfo:(MessageInfo *)messageInfo
{
    if (messageInfo == nil)
    {
        return;
    }
    
    [[DataFactory shardDataFactory] updateToDB:messageInfo Classtype:MESSAGE_INFO];
}

/**
 *  获取数据库保存的所有消息
 *
 *  @return 所有消息数组
 */
- (NSArray *)getNotificationMessageArray
{
    __block NSArray *messageArray = nil;
    [[DataFactory shardDataFactory] searchWhere:nil orderBy:nil offset:0 count:50 Classtype:MESSAGE_INFO callback:^(NSArray *array) {
        messageArray = array;
    }];
    
    return messageArray;
}

/**********************************
 ***  FunctionInfo
 **********************************/
/**
 *  根据FunctionID获得功能模块信息
 *
 *  @param functionID 功能模块ID
 *
 *  @return FunctionInfo对象
 */
- (FunctionInfo *)getFunctionInfoByFunctionID:(NSString *)functionID
{
    if (functionID == nil || functionID.length == 0)
    {
        return nil;
    }
    
    __block FunctionInfo *functionInfo = nil;
    [[DataFactory shardDataFactory] searchWhere:[self dictionary:@"functionID" value:functionID] orderBy:nil offset:0 count:9 Classtype:FUNCTION_INFO callback:^(NSArray *array) {
        if (array && array.count > 0)
        {
            functionInfo = [array objectAtIndex:array.count - 1];
        }
    }];
    
    return functionInfo;
}
/**
 *  将FunctionInfo对象保存到数据库
 *
 *  @param functionInfo FunctionInfo对象
 */
- (void)saveFunctionInfo:(FunctionInfo *)functionInfo
{
    if (functionInfo == nil)
    {
        return;
    }
    
    FunctionInfo *functionInfoTemp = [self getFunctionInfoByFunctionID:functionInfo.functionID];
    if (functionInfoTemp)
    {
        [self updateFunctionInfo:functionInfo];
    }
    else
    {
        [[DataFactory shardDataFactory] insertToDB:functionInfo Classtype:FUNCTION_INFO];
    }
}
/**
 *  更新FunctionInfo数据表
 *
 *  @param functionInfo FunctionInfo对象
 */
- (void)updateFunctionInfo:(FunctionInfo *)functionInfo
{
    if (functionInfo == nil)
    {
        return;
    }
    
    [[DataFactory shardDataFactory] updateToDB:functionInfo Classtype:FUNCTION_INFO];
}
/**
 *  从数据库中获取所有的FunctionInfo(功能模块)
 *
 *  @return FunctioInfo数组
 */
- (NSArray *)getFunctions
{
    __block NSArray *functions = nil;
    [[DataFactory shardDataFactory] searchWhere:nil orderBy:nil offset:0 count:9 Classtype:FUNCTION_INFO callback:^(NSArray *array) {
        functions = array;
    }];
    
    return functions;
}

@end
