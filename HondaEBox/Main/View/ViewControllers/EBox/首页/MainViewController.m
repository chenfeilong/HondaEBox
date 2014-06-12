//
//  MainViewController.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "MainViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "NSObject+SBJSON.h"
#import "NSString+SBJSON.h"
#import "NetWorking.h"
#import "UIHelpers.h"
#import "Define.h"
#import "ExtendClass.h"
#import "HondaDBService.h"
#import "FunctionInfo.h"

#import "MaintenanceCalendar.h"
#import "PersonalCenterViewController.h"

#define BTN_TAG_MAINTENANCE     700         //预约保养
#define BTN_TAG_ROADRESCUE      701         //道路救援
#define BTN_TAG_CARBOOK         702         //用车宝典
#define BTN_TAG_SEARCHESTORE    703         //特约店查询
#define BTN_TAG_GBCONSULT       704         //广本资讯台
#define BTN_TAG_CARPART         705         //纯正零部件
#define BTN_TAG_CALLPHONE       706         //服务热线
#define BTN_TAG_CARSTORE        707         //门店
#define BTN_TAG_CARFRIEND       708         //车友会

@interface MainViewController ()

@end

@implementation MainViewController

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
    //自定义nav
    [self.view addSubview:[UIHelpers homeViewHeaderWithImage:[UIImage imageNamed:@"底部1.png"] title:@"首页" target:self]];
    
//    [self chushihua];
    [self initHomeView];
    [self loadAppGrid];
}

- (void)initHomeView
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, IsIOS7?64:44, 320, 150)];
    [self.view addSubview:contentView];
    
    NSArray *images = [NSArray arrayWithObjects:@"广告.png",@"广告.png",@"广告.png",@"广告.png", nil];
    [self loadADScrollView:contentView adverImages:images];
    
    float origin_y = contentView.frame.origin.y + contentView.frame.size.height,height = (iPhone5?580:480) - 49 - 150 - (IsIOS7?64:44);
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, origin_y, 320, height)];
    [_rootScrollView setContentSize:CGSizeMake(0, 480)];
    [self.view addSubview:_rootScrollView];
}

- (void)saveFunctionsToDB
{
    NSArray *appNames = [NSArray arrayWithObjects:@"预约保养",@"道路救援",@"门店查询",@"特约店查询",@"广本资讯台",@"纯正零部件",@"服务热线",@"门店",@"车友会", nil];
    for (NSString *obj in appNames)
    {
        
    }
}

- (void)initFunctionGrid
{
    NSArray *functions = [[HondaDBService shareHondaDBService] getFunctions];
}

#pragma mark - 构建界面 -
//构建广告位
- (void)loadADScrollView:(UIView *)contentView adverImages:(NSArray *)images
{
    float width = contentView.frame.size.width, height = contentView.frame.size.height;
    UIScrollView *AD_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [AD_scrollView setShowsHorizontalScrollIndicator:NO];
    [AD_scrollView setShowsVerticalScrollIndicator:NO];
    float AD_images = images.count;
    [AD_scrollView setContentSize:CGSizeMake(width * AD_images, height)];
    for (int i = 0; i < AD_images; i++)
    {
        CGRect frame = CGRectMake(width * i, 0, width, height);
        UIImageView *AD_imageView = [[UIImageView alloc] initWithFrame:frame];
        [AD_imageView setUserInteractionEnabled:YES];
        AD_imageView.image = [UIImage imageNamed:[images objectAtIndex:i]];
        [AD_scrollView addSubview:AD_imageView];
    }
    
    [contentView addSubview:AD_scrollView];
}

//构建天气预报

//构建功能列表
- (void)loadAppGrid
{
    NSArray *appNames = [NSArray arrayWithObjects:@"预约保养",@"道路救援",@"门店查询",@"特约店查询",@"广本资讯台",@"纯正零部件",@"服务热线", nil];
    for (int i = 0; i < appNames.count; i++)
    {
//        NSString *imaName = nil;
//        NSString *text = nil;
//        NSString *imagPath = nil;
        
        UIImageView *bgImgView = [UIImageView squareBackgroundViewWithNum:i];
        
        NSString *imageName = [NSString stringWithFormat:@"%d.png",i + 1];
        UIImageView *iconImgView = [UIImageView squareCenterViewWithImage:[UIImage imageNamed:imageName]];
        iconImgView.tag = 700 + i;
        
        //加点击手势
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAppFuntion:)];
        tapGR.delegate = self;
        [iconImgView addGestureRecognizer:tapGR];
        
        UILabel *appNameLabel = [UILabel squareCenterLableWithText:[appNames objectAtIndex:i]];
        [bgImgView addSubview:iconImgView];
        [bgImgView addSubview:appNameLabel];
        
//        UIButton *appBtn = [UIButton squareCenterButtonWithNum:i];
        [_rootScrollView addSubview:bgImgView];
//        [_rootScrollView addSubview:appBtn];
        [_rootScrollView setContentSize:CGSizeMake(320, bgImgView.frame.origin.y + bgImgView.frame.size.height + 10)];
    }
}

- (void)chushihua
{
    //设备信息字典
    NSMutableDictionary *deviceDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    //设备型号
    //    [deviceDic setObject:[NSString deviceString] forKey:@"osName"];
    [deviceDic setObject:@"iPhone5,2" forKey:@"name"];
    //IOS1、Android2平台类型
    [deviceDic setObject:@"1" forKey:@"type"];
    //Token
    //    [deviceDic setObject:token forKey:@"devicesId"];
    [deviceDic setObject:@"e8742fc20e6e45ac5bf97bf16ab147190576d02d834be806639e0d0f805678b1" forKey:@"deviceId"];
    //经纬度(非必项)、定位出来
    [deviceDic setObject:@"" forKey:@"latitude"];
    [deviceDic setObject:@"" forKey:@"longitude"];
    //数据包版本信息字典
    //    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    //软件版本信息字典
    //    NSMutableDictionary *softwareDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    //总的字典
    NSDictionary *postBody = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:deviceDic, nil] forKeys:[NSArray arrayWithObjects:@"device", nil]];
    NSLog(@"字典:%@",postBody);
    
    NetWorking *netWork = [NetWorking shareNetWorking];
    [netWork chushiSystemWithPostBody:postBody];
//    [netWork loginWithUserName:@"18929955183" andPassWord:@"123456" andDeviceNo:nil];
}

#pragma mark - 应用响应 -
- (void)tapAppFuntion:(UITapGestureRecognizer *)sender
{
    UIImageView *tapImgView = (UIImageView *)sender.view;
    DLog(@"点击的功能:%d",tapImgView.tag);
    switch (tapImgView.tag)
    {
        case BTN_TAG_MAINTENANCE:           //预约保养
        {
            MaintenanceCalendar *maintenanceVC = [[MaintenanceCalendar alloc] init];
            [self.navigationController pushViewController:maintenanceVC animated:YES];
        }
            break;
        case BTN_TAG_ROADRESCUE:           //道路救援
        {
            
        }
            break;
        case BTN_TAG_CARBOOK:              //用车宝典
        {
            
        }
            break;
        case BTN_TAG_SEARCHESTORE:          //特约店查询
        {
            
        }
            break;
        case BTN_TAG_GBCONSULT:             //广本资讯台
        {
            
        }
            break;
        case BTN_TAG_CARPART:               //纯正零部件
        {
            
        }
            break;
        case BTN_TAG_CALLPHONE:             //服务热线
        {
            
        }
            break;
        case BTN_TAG_CARSTORE:              //门店
        {
            
        }
            break;
        case BTN_TAG_CARFRIEND:             //车友会
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - ButtonItem 响应 -
- (void)locationAction:(id)sender
{
    DLog(@"地图定位");
}

- (void)loginPersonalCenter:(id)sender
{
    DLog(@"个人中心");
    PersonalCenterViewController *personalCenterVC = [[PersonalCenterViewController alloc] init];
    [self.navigationController pushViewController:personalCenterVC animated:YES];
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
