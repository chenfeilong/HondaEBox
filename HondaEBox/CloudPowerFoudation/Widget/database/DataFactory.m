//
//  DataFactory.m
//
//
//  Created by mac  on 12-12-7.
//  Copyright (c) 2012年 sky. All rights reserved.
//

#import "DataFactory.h"
#import "SandboxFile.h"
#import "LKDaoBase.h"
#import "HondaDBService.h"

#import "MessageInfo.h"
#import "FunctionInfo.h"

static FMDatabaseQueue* queue;
@implementation DataFactory
@synthesize classValues;
+(DataFactory *)shardDataFactory
{
    static id ShardInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ShardInstance=[[self alloc]init];
    });
    return ShardInstance;
}
-(BOOL)IsDataBase
{
    BOOL Value=NO;
    if (![SandboxFile IsFileExists:GetDataBasePath])
    {
        Value=YES;
    }
    return Value;
}
-(void)CreateDataBase
{
    queue=[[[FMDatabaseQueue alloc]initWithPath:GetDataBasePath]autorelease];
}
-(void)CreateTable
{
    //消息中心
    [[[MessageInfoModelBase alloc] initWithDBQueue:queue] autorelease];
    //首页功能列表
    [[[FunctionInfoModelBase alloc] initWithDBQueue:queue] autorelease];
}
-(id)Factory:(FSO)type
{
    id result = 0;
    queue=[[[FMDatabaseQueue alloc]initWithPath:GetDataBasePath]autorelease];
    switch (type)
    {
        case MESSAGE_INFO:
            result = [[[MessageInfoModelBase alloc] initWithDBQueue:queue] autorelease];
            break;
        case FUNCTION_INFO:
            result = [[[FunctionInfoModelBase alloc] initWithDBQueue:queue] autorelease];
            break;
            
        default:
            break;
    }
    
    return result;
}
-(id)insertToDB:(id)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues insertToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"添加%d",Values);
     }];
    return Model;
}
-(void)updateToDB:(id)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues updateToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"修改%d",Values);
     }];
}
-(void)deleteToDB:(id)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues deleteToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"删除%d",Values);
     }];
}
-(void)clearTableData:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues clearTableData];
    NSLog(@"删除全部数据");
}
-(BOOL)deleteWhereData:(NSDictionary *)Model Classtype:(FSO)type
{   __block BOOL result;
    self.classValues=[self Factory:type];
    [classValues deleteToDBWithWhereDic:Model callback:^(BOOL Values)
     {
         result = Values;
         if (result) {
             NSLog(@"删除成功");
         }else{
             NSLog(@"删除失败");
         }
         
     }];
    return result;
}
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result
{
    self.classValues=[self Factory:type];
    [classValues searchWhereDic:where orderBy:columeName offset:offset count:count callback:^(NSArray *array)
     {
         result(array);
     }];
}

-(void)searchWhereString:(NSString *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result
{
    self.classValues=[self Factory:type];
    [classValues searchWhere:where orderBy:columeName offset:offset count:count callback:^(NSArray *array)
     {
         result(array);
     }];
}

-(void)searchWhereTemp:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(CivicCallBack(^)(NSArray *))result
{
    self.classValues=[self Factory:type];
    [classValues searchWhereDic:where orderBy:columeName offset:offset count:count callback:^(NSArray *array)
     {
         result(array);
     }];
}
-(void)dealloc
{
    [classValues release];
    NSLog(@"DataFactory dealloc");
    [super dealloc];
}
@end
