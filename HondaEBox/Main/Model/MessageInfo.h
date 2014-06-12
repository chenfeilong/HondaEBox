//
//  MessageInfo.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-19.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDaoBase.h"

@interface MessageInfoModelBase : LKDAOBase

@end

@interface MessageInfo : LKModelBase

@property (nonatomic, copy) NSString *alert;
@property (nonatomic, copy) NSString *badge;
@property (nonatomic, copy) NSString *sound;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *read;     //0-未读 1-已读

- (id)initMessageInfo:(NSDictionary *)dic;

@end
