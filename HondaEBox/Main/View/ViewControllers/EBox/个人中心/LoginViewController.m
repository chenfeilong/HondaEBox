//
//  LoginViewController.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-18.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "LoginViewController.h"
#import "UIHelpers.h"
#import "RegistViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:[UIHelpers headerViewWithImage:[UIImage imageNamed:@"底部1.png"] title:@"登录" target:self]];
}

#pragma mark - UIButton Operation -
- (IBAction)loginOperation:(id)sender {
    
}
- (IBAction)registOperation:(id)sender {
    RegistViewController *registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
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

@end
