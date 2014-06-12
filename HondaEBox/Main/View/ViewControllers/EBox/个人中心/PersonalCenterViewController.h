//
//  PersonalCenterViewController.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-16.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_titleArr;
}

@property (nonatomic, strong) UITableView *centerTable;
@property (nonatomic, strong) UIScrollView *centerView;

@end
