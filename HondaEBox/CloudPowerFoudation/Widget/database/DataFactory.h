//
//  DataFactory.h
//
//
//  Created by mac  on 12-12-7.
//  Copyright (c) 2012年 sky. All rights reserved.
#import <Foundation/Foundation.h>
#import "SandboxFile.h"
#import "FMDatabaseQueue.h"
#import "HondaDBService.h"
#define GetDataBasePath [SandboxFile GetPathForDocuments:@"test.db" inDir:@"DataBase"]

@interface DataFactory : NSObject
@property(retain,nonatomic)id classValues;
typedef enum
{
    MESSAGE_INFO,
    FUNCTION_INFO
}
FSO;//这个是枚举是区别不同的实体,我这边就写一个test;
+(DataFactory *)shardDataFactory;
//是否存在数据库
-(BOOL)IsDataBase;
//创建数据库
-(void)CreateDataBase;
//创建表
-(void)CreateTable;
//添加数据
-(id)insertToDB:(id)Model Classtype:(FSO)type;
//修改数据
-(void)updateToDB:(id)Model Classtype:(FSO)type;
//删除单条数据
-(void)deleteToDB:(id)Model Classtype:(FSO)type;
//删除表的数据
-(void)clearTableData:(FSO)type;
//根据条件删除数据
-(BOOL)deleteWhereData:(NSDictionary *)Model Classtype:(FSO)type;
//查找数据
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result;
//输入sql string 语句查找数据
-(void)searchWhereString:(NSString *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result;
//查找数据
-(void)searchWhereTemp:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(CivicCallBack(^)(NSArray *))result;
@end
