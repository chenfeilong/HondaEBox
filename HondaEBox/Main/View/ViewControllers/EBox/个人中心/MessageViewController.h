//
//  MessageViewController.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-19.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTableView.h"

@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _setting;
    NSMutableArray *_checkBoxArr;
}

@property(nonatomic, strong) NSMutableArray *boardMessageArr;
@property(nonatomic, strong) NSMutableArray *userMessageArr;
@property(nonatomic, strong) NSMutableArray *baoyangMessageArr;
@property(nonatomic, strong) NSMutableArray *dataSources;
@property(nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) MessageTableView *tableView;

@end
