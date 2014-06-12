//
//  MessageInfo.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-19.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "MessageInfo.h"

@implementation MessageInfoModelBase

+ (Class)getBindingModelClass
{
    return [MessageInfo class];
}

const static NSString* tableName = @"message_info"; //表名
+ (const NSString *)getTableName
{
    return tableName;
}

@end

@implementation MessageInfo

//- (id)init
//{
//    self = [super init];
//    if (self)
//    {
//        self.primaryKey = @"messageID";   //主键
//    }
//    
//    return self;
//}

- (id)initMessageInfo:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"ID";   //主键
//        self.rowid = 1;
        
        self.alert = [[dic objectForKey:@"aps"] objectForKey:@"alert"];
        self.badge = [[dic objectForKey:@"aps"] objectForKey:@"badge"];
        self.sound = [[dic objectForKey:@"aps"] objectForKey:@"sound"];
        self.ID = [dic objectForKey:@"id"];
        self.type = [dic objectForKey:@"type"];
        self.url = [dic objectForKey:@"url"];
        self.read = @"0";
    }
    
    return self;
}

@end
