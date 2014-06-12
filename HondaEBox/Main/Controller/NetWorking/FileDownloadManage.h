//
//  FileDownloadManage.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-7.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppListInfo.h"
#import "AFNetworking.h"
#import "SSZipArchive.h"

@protocol DownloadDelegate <NSObject>

- (void)updateCellProgress:(AFURLConnectionOperation *)operation;
- (void)downloadFinished:(AFURLConnectionOperation *)operation;

@end

@interface FileDownloadManage : NSObject<SSZipArchiveDelegate>
{
    __block NSString *_targetPath;
}

@property (nonatomic, strong) AppListInfo *appListInfo;
@property (nonatomic, strong) NSMutableArray *downingList;
@property (nonatomic, weak) id<DownloadDelegate> downloadDelegate;

+ (FileDownloadManage *)shareFileDownloadManage;

- (void)beginDownloadWithAppListInfo:(AppListInfo *)appListInfo basePath:(NSString *)basePath subPath:(NSString *)subPath;

- (void)downloadPause:(AFURLConnectionOperation *)operation;

- (void)downloadResume:(AFURLConnectionOperation *)operation;

@end
