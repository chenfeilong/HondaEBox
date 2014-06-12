//
//  UITabBarControllerExt.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarControllerExt : UITabBarController
{
//    NSMutableArray *buttons;
//    NSInteger currentSelectedIndex;
    BOOL isNeedCreatTab;
    UIImageView *slideBg;
    UIImageView *tabBg;
}

@property (nonatomic, assign) NSInteger currentSelectedIndex;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *tabBarView;

- (void)hideRealTabBar;
- (void)customTabBar;
- (void)selectedTab:(UIButton *)button;
//- (void)hideCustomTabBar;
//- (void)showCustomTabBar;

@end
