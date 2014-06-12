//
//  CarTypeFormViewController.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileDownloadManage.h"
#import "AppListInfo.h"
#import "AppListCell.h"

@interface CarTypeFormViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DownloadDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *appListArr;
@property (nonatomic, strong) NSMutableArray *downloadingList;
@property (nonatomic, strong) NSMutableArray *finishedList;

@end
