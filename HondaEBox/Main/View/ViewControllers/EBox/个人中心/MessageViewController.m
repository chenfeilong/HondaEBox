//
//  MessageViewController.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-19.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "MessageViewController.h"
#import "UIHelpers.h"
#import "SlidingMenueView.h"
#import "MessageCell.h"
#import "CheckButton.h"
#import "HondaDBService.h"
#import "MessageInfo.h"
#import "MessageDetailViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

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
    NSArray *messageArray = [NSArray arrayWithArray:[[HondaDBService shareHondaDBService] getNotificationMessageArray]];
    [self filtrateMessageFormDB:messageArray];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:[UIHelpers headerViewWithImage:[UIImage imageNamed:@"底部1.png"] title:@"登录" target:self]];
    
    [self initMessageView];
    
}

#pragma mark - 初始化 -
- (void)initMessageView
{
    _tableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 69 + 30 + 8, 320, 480 - 69 - 30 - 8 - 49) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _boardMessageArr = [[NSMutableArray alloc] initWithCapacity:0];
    _userMessageArr = [[NSMutableArray alloc] initWithCapacity:0];
    _baoyangMessageArr = [[NSMutableArray alloc] initWithCapacity:0];
    
//    MessageInfo *messageInfo = (MessageInfo *)[messageArray objectAtIndex:0];
//    DLog(@"messageARRay = %@",messageInfo.alert);
    
//    _boardMessageArr = [[NSMutableArray alloc] initWithObjects:@"广本雅阁大优惠",@"广本雅阁大优惠",@"广本雅阁大优惠",@"广本雅阁大优惠",@"广本雅阁大优惠",@"广本雅阁大优惠",@"广本雅阁大优惠",@"广本雅阁大优惠",@"广本雅阁大优惠",@"广本雅阁大优惠", nil];
//    _userMessageArr = [[NSMutableArray alloc] initWithObjects:@"a",@"b",@"c",@"d",@"e", nil];
//    _baoyangMessageArr = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F", nil];
    _checkBoxArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    //menue
    SlidingMenueView *slideMenue = [[SlidingMenueView alloc] initWithFrame:CGRectMake(10, 69, 300, 30) menueItems:[NSArray arrayWithObjects:@"广播消息",@"保养提醒",@"用户消息", nil] delegate:self];
    [self.view addSubview:slideMenue];
    [slideMenue.delegate touchUpInsideMenuItemIndex:0];
    
}

- (void)filtrateMessageFormDB:(NSArray *)messages
{
    if (_boardMessageArr != nil && _boardMessageArr.count > 0)
    {
        [_boardMessageArr removeAllObjects];
    }
    if (_userMessageArr != nil && _userMessageArr.count > 0)
    {
        [_userMessageArr removeAllObjects];
    }
    if (_baoyangMessageArr != nil && _baoyangMessageArr.count > 0)
    {
        [_baoyangMessageArr removeAllObjects];
    }
    
    for (MessageInfo *messageInfo in messages)
    {
        if ([messageInfo.type intValue] == 1)
        {
            [_boardMessageArr addObject:messageInfo];
        }
        else if ([messageInfo.type intValue] == 2)
        {
            [_userMessageArr addObject:messageInfo];
        }
        else if ([messageInfo.type intValue] == 3)
        {
            [_baoyangMessageArr addObject:messageInfo];
        }
    }
}

#pragma mark -----SlideMenueDelegate-----
- (void)touchUpInsideMenuItemIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    _dataSources = (_selectedIndex == 0)?_boardMessageArr:(_selectedIndex == 1?_baoyangMessageArr:_userMessageArr);
    [_tableView reloadData];
}

#pragma - BackButton Clicked -
- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowNum = 0;
    switch (_selectedIndex) {
        case 0:
            rowNum = _boardMessageArr.count;
            break;
        case 1:
            rowNum = _baoyangMessageArr.count;
            break;
        case 2:
            rowNum = _userMessageArr.count;
            break;
            
        default:
            break;
    }
    return rowNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifer";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil] lastObject];
    }
    else
    {
        [[cell.contentView viewWithTag:[[NSString stringWithFormat:@"%d",indexPath.row] integerValue]] removeFromSuperview];
    }
    
    MessageInfo *messageInfo = (MessageInfo *)[_dataSources objectAtIndex:indexPath.row];
    cell.titleLabel.text = messageInfo.alert;
    NSInteger read = [messageInfo.read integerValue];
    cell.titleLabel.textColor = read == 0 ? [UIColor blackColor] :[UIColor grayColor];
    cell.titleLabel.font = [UIFont fontWithName:@"Arial" size:read == 0 ? 17 : 15];
//    cell.titleLabel.text = [_dataSources objectAtIndex:indexPath.row];
    
//    CheckButton *checkbtn = (CheckButton *)[cell.contentView viewWithTag:[[NSString stringWithFormat:@"100%d%d",indexPath.section,indexPath.row] integerValue]];
//    checkbtn.hidden = YES;
//    if (checkbtn == nil) {
//        checkbtn = [[CheckButton alloc] initWithFrame:CGRectMake(5, 8, 20, 20)];
//        checkbtn.enabled = YES;
//        checkbtn.userInteractionEnabled = YES;
////        [checkBox setTarget:self fun:@selector(checkBoxClick:)];
//    }
//    cell.checkBtn = checkbtn;
//    cell.checkBtn.tag = [[NSString stringWithFormat:@"100%d%d",indexPath.section,indexPath.row] integerValue];
//    if ([_checkBoxArr containsObject:indexPath]) {
//        [cell.checkBtn setIsSelected:YES];
//    }
//    else
//    {
//        [cell.checkBtn setIsSelected:NO];
//    }
//    [cell.contentView addSubview:checkbtn];
    
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    backView.backgroundColor = [UIColor cyanColor];
    cell.selectedBackgroundView = backView;
    
    return cell;
}

#pragma mark -----UITableViewDelegate-----
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([_checkBoxArr containsObject:indexPath]) {
//        [_checkBoxArr removeObject:indexPath];
//    }
//    else
//    {
//        [_checkBoxArr addObject:indexPath];
//    }
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    MessageDetailViewController *messageDetailView = [[MessageDetailViewController alloc] init];
    messageDetailView.messageInfo = [_dataSources objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:messageDetailView animated:YES];
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
