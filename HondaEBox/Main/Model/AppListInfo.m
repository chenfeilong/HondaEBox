//
//  AppListInfo.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-7.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "AppListInfo.h"
#import "Define.h"

@implementation AppListInfo

- (id)initWithApps:(NSDictionary *)appsDic
{
    self = [super init];
    if (self)
    {
        self.appName = [appsDic objectForKey:@"appName"];
        self.appUrl = [NSString stringWithFormat:@"%@%@",GB_REQUEST,[appsDic objectForKey:@"installFilePath"]];
        self.appIconPath = [appsDic objectForKey:@"appIconPath"];
        self.appDesc = [appsDic objectForKey:@"appDesc"];
        self.appVersion = [appsDic objectForKey:@"appCategory"];
        self.appSize = [appsDic objectForKey:@"appSize"];
        self.picsPath = [appsDic objectForKey:@"picsPath"];
        
        self.willDownload = YES;
        self.isDownloading = NO;
        self.downloadFinished = NO;
    }
    
    return self;
}

@end
