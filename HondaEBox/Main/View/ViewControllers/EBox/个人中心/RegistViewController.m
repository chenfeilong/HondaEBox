//
//  RegistViewController.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-18.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "RegistViewController.h"
#import "UIHelpers.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:[UIHelpers headerViewWithImage:[UIImage imageNamed:@"底部1.png"] title:@"注册" target:self]];
    
    
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"个人中心切图_13.png"]];
    _userName.leftView = image1;
 
    NSLog(@"left = %@",self.userName.leftView);
    _userName.leftViewMode = UITextFieldViewModeAlways;
    _userName.leftView.frame = CGRectMake(50, 5, 35, 35);
    

    
    
    
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
