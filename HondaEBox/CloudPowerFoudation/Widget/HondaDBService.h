//
//  HondaDBService.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-19.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageInfo;
@class FunctionInfo;
typedef NSArray* (^CivicCallBack)(NSArray*);
@interface HondaDBService : NSObject{
@private CivicCallBack _CiviCallBack;
}
/**
 *  单例
 *
 *  @return HondaDBService对象
 */
+ (HondaDBService *)shareHondaDBService;

/**********************************
 ***  messageInfo
 **********************************/

/**
 *  从数据库中获取MessageInfo对象
 *
 *  @param messageID messageID识别号
 *
 *  @return MessageInfo对象
 */
- (MessageInfo *)getMessageInfoByMessageID:(NSString *)messageID;
/**
 *  保存MessageInfo到数据库
 *
 *  @param messageInfo messageInfo对象
 */
- (void)saveMessageInfo:(MessageInfo *)messageInfo;
/**
 *  更新数据库MessageInfo对象
 *
 *  @param messageInfo message
 */
- (void)updateMessageInfo:(MessageInfo *)messageInfo;
/**
 *  获取数据库保存的所有消息
 *
 *  @return 所有消息数组
 */
- (NSArray *)getNotificationMessageArray;

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
- (FunctionInfo *)getFunctionInfoByFunctionID:(NSString *)functionID;
/**
 *  将FunctionInfo对象保存到数据库
 *
 *  @param functionInfo FunctionInfo对象
 */
- (void)saveFunctionInfo:(FunctionInfo *)functionInfo;
/**
 *  更新FunctionInfo数据表
 *
 *  @param functionInfo FunctionInfo对象
 */
- (void)updateFunctionInfo:(FunctionInfo *)functionInfo;
/**
 *  从数据库中获取所有的FunctionInfo(功能模块)
 *
 *  @return FunctioInfo数组
 */
- (NSArray *)getFunctions;

@end
