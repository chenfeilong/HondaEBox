//
//  AppListCell.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-7.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppListInfo.h"
#import "FileDownloadManage.h"
#import "AFURLConnectionOperation.h"
#import "CarTypeFormViewController.h"

@interface AppListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgress;
@property (weak, nonatomic) IBOutlet UILabel *appVersion;
@property (weak, nonatomic) IBOutlet UIButton *operateBtn;

@property (strong, nonatomic) AppListInfo *appListInfo;
@property (strong, nonatomic) FileDownloadManage *fileDowManage;
@property (strong, nonatomic) AFURLConnectionOperation *operation;
@property (strong, nonatomic) NSString *appUrl;

@property (strong, nonatomic) UIViewController *carType;


@end
