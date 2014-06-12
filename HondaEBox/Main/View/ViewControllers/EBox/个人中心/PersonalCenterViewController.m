//
//  PersonalCenterViewController.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-16.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "LoginViewController.h"
#import "MessageViewController.h"
#import "UIHelpers.h"

@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController

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
    [self.centerTable reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:[UIHelpers headerViewWithImage:[UIImage imageNamed:@"底部1.png"] title:@"个人中心" target:self]];
    
    [self initPersonalCenter];
}

#pragma - BackButton Clicked -
- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 初始化 -
- (void)initPersonalCenter
{
    _titleArr = [[NSMutableArray alloc] initWithObjects:@"登录密码修改",@"邮箱/手机号码修改",@"车辆信息",@"我的特约店修改",@"消息中心",@"用户反馈",@"我的收藏", nil];
    
    float height = (iPhone5?442:372);
    NSLog(@"height = %f",height);
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.centerTable = tableView;
    [self.view addSubview:self.centerTable];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows;
    if (section == 0)
    {
        rows = 5;
    }
    else if (section == 1)
    {
        rows = 1;
    }
    else if (section == 2)
    {
        rows = 2;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UIImageView *backcGroudView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
            [backcGroudView setImage:[UIImage imageNamed:@"1_46-1.png"]];
            [cell.contentView addSubview:backcGroudView];
            
            UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 84, 84)];
            headerView.image = [UIImage imageNamed:@"1.png"];
            [backcGroudView addSubview:headerView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(92, 30, 212, 20)];
            titleLabel.font = [UIFont fontWithName:@"Arial" size:16.f];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.text = @"点击登录";
            [backcGroudView addSubview:titleLabel];
            
            UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(92, 50, 212, 20)];
            subLabel.font = [UIFont fontWithName:@"Arial" size:14.f];
            subLabel.textAlignment = NSTextAlignmentLeft;
            subLabel.textColor = [UIColor grayColor];
            subLabel.text = @"登录后你可以享受更多特权";
            [backcGroudView addSubview:subLabel];
        }
        else
        {
            cell.textLabel.text = [_titleArr objectAtIndex:indexPath.row - 1];
        }
    }
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = [_titleArr objectAtIndex:4];
        NSInteger count = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (count > 0)
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"您有%d条未读消息",count];
        }
    }
    else
    {
        cell.textLabel.text = [_titleArr objectAtIndex:indexPath.row + 5];
    }
    
    return cell;
}

//自定义TableHeaderView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 100;
    }
    else
        return 44;
}

#pragma mark - UITableViewDelegate Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        MessageViewController *messageVC = [[MessageViewController alloc] init];
        [self.navigationController pushViewController:messageVC animated:YES];
    }
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
