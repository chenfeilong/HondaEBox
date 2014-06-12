//
//  FunctionInfo.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-20.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDaoBase.h"
@interface FunctionInfoModelBase : LKDAOBase

@end

@interface FunctionInfo : LKModelBase

@property (nonatomic, copy)         NSString *functionName;
@property (nonatomic, copy)         NSString *iconImageName;
@property (nonatomic, assign)       NSInteger index;
@property (nonatomic, assign)       NSInteger buttonTag;
@property (nonatomic, copy)         NSString *version;
@property (nonatomic, copy)         NSString *functionID;
@property (nonatomic, copy)         NSString *update;       //0-有更新 1-已更新

@end
