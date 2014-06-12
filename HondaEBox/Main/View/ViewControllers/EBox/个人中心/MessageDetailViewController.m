//
//  MessageDetailViewController.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-19.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "HondaDBService.h"
#import "UIHelpers.h"
#import "Define.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

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
    // Do any additional setup after loading the view.
    [self.view addSubview:[UIHelpers headerViewWithImage:[UIImage imageNamed:@"底部1.png"] title:@"消息详情" target:self]];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://www.baidu.com"];
//    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.1.254:8080%@",self.messageInfo.url];
    
    NSLog(@"Url :%@",urlStr);
    NSURL *ceshiUrl = [NSURL URLWithString:urlStr];
    UIWebView *messageWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64 + 8, 320, 480)];
    [messageWebView loadRequest:[NSURLRequest requestWithURL:ceshiUrl]];
    [self.view addSubview:messageWebView];
    
    [self updateMessageFromHondaDB];
}

#pragma mark - 私有方法 -
- (void)updateMessageFromHondaDB
{
    self.messageInfo.read = @"1";
    [[HondaDBService shareHondaDBService] updateMessageInfo:self.messageInfo];
    [UIApplication sharedApplication].applicationIconBadgeNumber--;
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
