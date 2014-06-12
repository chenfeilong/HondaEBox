//
//  MainViewController.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIScrollView *_rootScrollView;
}

@property (nonatomic, strong) NSMutableArray *apps;

@end
