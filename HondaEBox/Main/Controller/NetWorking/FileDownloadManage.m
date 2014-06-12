//
//  FileDownloadManage.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-7.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "FileDownloadManage.h"
#import "CommonFunc.h"

static dispatch_once_t singleLeton;
static FileDownloadManage *fileDownloadManage = nil;
@implementation FileDownloadManage

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        self.downingList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

//+ (FileDownloadManage *)shareFileDownloadManageWithBasePath:(NSString *)basePath
//{
//    
//}

+ (FileDownloadManage *)shareFileDownloadManage
{
    dispatch_once(&singleLeton, ^{
        fileDownloadManage = [[FileDownloadManage alloc] init];
    });
    
    return fileDownloadManage;
}

#pragma mark - 下载操作 -
- (void)beginDownloadWithAppListInfo:(AppListInfo *)appListInfo basePath:(NSString *)basePath subPath:(NSString *)subPath
{
//    NSString *targetPath = [CommonFunc getTargetFilePathWithBasePath:basePath subPath:subPath];
//    targetPath = [targetPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",appListInfo.appName]];
    
    NSString *targetPath = [CommonFunc getCarsDocumentFilePath];
    targetPath = [targetPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",appListInfo.appName]];
    
//    self.appListInfo = appListInfo;
//    self.appListInfo.targetPath = targetPath;
    
    __block AppListInfo *appInfo = nil;
    appInfo = appListInfo;
    appInfo.targetPath = [CommonFunc getCarsDocumentFilePath];
    appInfo.willDownload = NO;
    appInfo.isDownloading = YES;
    appInfo.downloadFinished = NO;
    
    NSURL *url = [[NSURL alloc] initWithString:appListInfo.appUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUserInfo:[NSDictionary dictionaryWithObject:appListInfo forKey:@"appListInfo"]];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:targetPath append:NO]];
    __block AFURLConnectionOperation *operationTemp = nil;
    operationTemp = operation;
    appInfo.operation = operation;
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        DLog(@"正在下载:(%f)",(float)totalBytesRead);
        NSLog(@" 百分比:%.1f",(float)totalBytesRead / totalBytesExpectedToRead);
        appInfo.totalBytesRead = totalBytesRead;
        appInfo.totalBytesExpectedToRead = totalBytesExpectedToRead;
        [self.downloadDelegate updateCellProgress:operationTemp];
    }];
    
    [operation setCompletionBlock:^{
        DLog(@"下载完成");
        appInfo.willDownload = NO;
        appInfo.isDownloading = NO;
        appInfo.downloadFinished = YES;
        [self.downloadDelegate downloadFinished:operationTemp];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:targetPath])
        {
            NSString *zipPath = [appInfo.targetPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",appInfo.appName]];
            _targetPath = zipPath;
            [SSZipArchive unzipFileAtPath:zipPath toDestination:appInfo.targetPath delegate:self];
        }
    }];
    [operation start];
    
    [self.downingList addObject:operation];
}

- (void)downloadPause:(AFURLConnectionOperation *)operation
{
    DLog(@"暂停下载!!!!!!!");
    AppListInfo *appInfo = (AppListInfo *)[operation.userInfo objectForKey:@"appListInfo"];
    appInfo.isDownloading = NO;
    appInfo.willDownload = YES;
    [operation pause];
}

- (void)downloadResume:(AFURLConnectionOperation *)operation
{
    DLog(@"暂继续下载!!!!!!!");
    AppListInfo *appInfo = (AppListInfo *)[operation.userInfo objectForKey:@"appListInfo"];
    appInfo.isDownloading = YES;
    appInfo.willDownload = NO;
    [operation resume];
}

#pragma mark - SSZipArchiveDelegate Method -
- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo
{
    DLog(@"Will Archive");
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath
{
    DLog(@"Did Archive");
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if ([fileManager fileExistsAtPath:_targetPath])
    {
        [fileManager removeItemAtPath:_targetPath error:&error];
    }
}

@end
