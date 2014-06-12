//
//  TextViewController.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-13.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "TextViewController.h"
#import "UIHelpers.h"
//#import "iCarShowMainController.h"
#import "UITabBarControllerExt.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    UITabBarControllerExt *tabBar = (UITabBarControllerExt *)self.tabBarController;
    [tabBar hideRealTabBar];
    tabBar.tabBarView.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:[UIHelpers headerViewWithImage:[UIImage imageNamed:@"底部1.png"] title:@"车型" target:self]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"底部1.png"] forState:UIControlStateNormal];
    [button setTitle:@"雅阁" forState:UIControlStateNormal];
    button.tag = 1;
    [button addTarget:self action:@selector(openCar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(100, 200, 100, 40);
    button2.tag = 2;
    [button2 setBackgroundImage:[UIImage imageNamed:@"底部1.png"] forState:UIControlStateNormal];
    [button2 setTitle:@"歌诗图" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(openCar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)openCar:(UIButton *)sender
{
    NSString* carname = @"";
    if (sender.tag == 1)
    {
        carname = @"Accord";
    }
    else
    {
        carname = @"Crosstour";
    }
    
//    UITabBarControllerExt *tabBar = (UITabBarControllerExt *)self.tabBarController;
//    tabBar.tabBarView.hidden = YES;
//    
//    iCarShowMainController* iController = [[iCarShowMainController alloc] initWithCar:carname];
//    
//    iController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:iController animated:YES];
}

#pragma - BackButton Clicked -
- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
