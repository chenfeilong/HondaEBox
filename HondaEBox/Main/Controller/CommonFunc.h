//
//  CommonFunc.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-7.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunc : NSObject

+ (CommonFunc *)shareCommonFunc;

+ (NSString *)getDocumentFilePath;

+ (NSString *)getCarsDocumentFilePath;

+ (NSString *)getCarCacheFilePath;

+ (NSString *)getTargetFilePathWithBasePath:(NSString *)basePath subPath:(NSString *)subPath;

+ (float)getProgress:(float)totalSize andCurrentSize:(float)currentSize;

+ (NSString *)getAppFilePath;

+ (NSString *)getWidgetFilePath;

@end
