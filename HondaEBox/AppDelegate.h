//
//  AppDelegate.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APPDELEGATE  ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *rootViewController;

@end
