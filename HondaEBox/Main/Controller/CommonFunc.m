//
//  CommonFunc.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-7.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "CommonFunc.h"

@implementation CommonFunc

+ (CommonFunc *)shareCommonFunc
{
    static CommonFunc *commonFunc = nil;
    static dispatch_once_t singleLeton;
    dispatch_once(&singleLeton, ^{
        commonFunc = [[CommonFunc alloc] init];
    });
    
    return commonFunc;
}

+ (NSString *)getDocumentFilePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return path;
}

+ (NSString *)getCarsDocumentFilePath
{
    NSString *CarsPath = [[self class] getDocumentFilePath];
    CarsPath = [CarsPath stringByAppendingPathComponent:@"App"];
    CarsPath = [CarsPath stringByAppendingPathComponent:@"Cars"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if (![fileManager fileExistsAtPath:CarsPath])
    {
        [fileManager createDirectoryAtPath:CarsPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error)
        {
            DLog(@"文件路径创建错误:%@",[error description]);
        }
    }
    return CarsPath;
}

+ (NSString *)getCarCacheFilePath
{
    NSString *CarCachePath = [[self class] getDocumentFilePath];
    CarCachePath = [CarCachePath stringByAppendingPathComponent:@"App"];
    CarCachePath = [CarCachePath stringByAppendingPathComponent:@"CarCache"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if (![fileManager fileExistsAtPath:CarCachePath])
    {
        [fileManager createDirectoryAtPath:CarCachePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error)
        {
            DLog(@"文件路径创建错误:%@",[error description]);
        }
    }
    return CarCachePath;
}

+ (NSString *)getTargetFilePathWithBasePath:(NSString *)basePath subPath:(NSString *)subPath
{
    NSString *path = [[self class] getDocumentFilePath];
    path = [path stringByAppendingPathComponent:basePath];
    path = [path stringByAppendingPathComponent:subPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error)
        {
            DLog(@"文件路径创建错误:%@",[error description]);
        }
    }
    
    return path;
}

+ (NSString *)getAppFilePath
{
    NSString *path = [[self class] getDocumentFilePath];
    path = [path stringByAppendingPathComponent:@"App"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error)
        {
            DLog(@"文件路径创建错误:%@",[error description]);
        }
    }
    return path;
}

+ (NSString *)getWidgetFilePath
{
    NSString *path =[[self class] getDocumentFilePath];
    path = [path stringByAppendingPathComponent:@"Widget"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error)
        {
            DLog(@"文件路径创建错误:%@",[error description]);
        }
    }
    return path;
}

+ (float)getProgress:(float)totalSize andCurrentSize:(float)currentSize
{
    return currentSize / totalSize;
}

@end
