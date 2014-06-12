//
//  FunctionInfo.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-20.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "FunctionInfo.h"

@implementation FunctionInfoModelBase

+ (Class)getBindingModelClass
{
    return [FunctionInfo class];
}

const static NSString *tableName = @"function_info";
+ (const NSString *)getTableName
{
    return tableName;
}

@end

@implementation FunctionInfo

- (id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"functionID";
    }
    
    return self;
}

@end
