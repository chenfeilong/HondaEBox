//
//  AppDelegate.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"              //首页
#import "CarTypeFormViewController.h"       //车型（品牌）
#import "MoreViewController.h"              //更多
#import "UITabBarControllerExt.h"
#import "SBJSON.h"
#import "JSONKit.h"
#import "Define.h"
#import "MessageInfo.h"
#import "CommonFunc.h"
#import "HondaDBService.h"
#import "NetWorking.h"
#import "ExtendClass.h"

@implementation AppDelegate

#pragma mark - 私有方法 -
- (UITabBarController *)createTabBar
{
    //车型(品牌)
    CarTypeFormViewController *carTypeFormVC = [[CarTypeFormViewController alloc] init];
    UINavigationController *carTypeFormNC = [[UINavigationController alloc] initWithRootViewController:carTypeFormVC];
    [carTypeFormNC setNavigationBarHidden:YES];
    //    carTypeFormVC.view.backgroundColor = [UIColor cyanColor];
    UITabBarItem *carTypeItem = [[UITabBarItem alloc] initWithTitle:@"品牌" image:[UIImage imageNamed:@"底部2"] tag:1];
    carTypeFormVC.tabBarItem = carTypeItem;
    
    //首页
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    [mainNC setNavigationBarHidden:YES];
    UITabBarItem *mainViewItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"底部3"] tag:2];
    mainVC.tabBarItem = mainViewItem;
    
    //更多
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    UINavigationController *moreNC = [[UINavigationController alloc] initWithRootViewController:moreVC];
    [moreNC setNavigationBarHidden:YES];
    UITabBarItem *moreViewItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:[UIImage imageNamed:@"底部4"] tag:3];
    moreVC.tabBarItem = moreViewItem;
    
    UITabBarControllerExt *tabBarController = [[UITabBarControllerExt alloc] init];
    [tabBarController setViewControllers:[NSArray arrayWithObjects:carTypeFormNC,mainNC,moreNC, nil] animated:YES];
    tabBarController.currentSelectedIndex = 1;
    tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@""];
    tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"底部1"];
    tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    return tabBarController;
}

- (void)changeIconBadgeNumber
{
    NSArray *messages = [[HondaDBService shareHondaDBService] getNotificationMessageArray];
    NSInteger count = 0;
    if (messages != nil || messages.count > 0)
    {
        for (MessageInfo *messageInfo in messages)
        {
            if ([messageInfo.read isEqualToString:@"0"])
            {
                count++;
            }
        }
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = count;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getNewNotificationFinished" object:[NSString stringWithFormat:@"%d",count]];
}

- (void)sendTokenToServer:(NSString *)deviceToken
{
    //设备信息字典
    NSMutableDictionary *deviceDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    //设备型号
    [deviceDic setObject:[NSString deviceString] forKey:@"name"];
//    [deviceDic setObject:@"iPhone5,2" forKey:@"name"];
    //IOS1、Android2平台类型
    [deviceDic setObject:@"1" forKey:@"type"];
    //Token
    [deviceDic setObject:deviceToken forKey:@"deviceId"];
//    [deviceDic setObject:@"e8742fc20e6e45ac5bf97bf16ab147190576d02d834be806639e0d0f805678b1" forKey:@"deviceId"];
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
}

#pragma mark - Application Method -
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    [self sendTokenToServer:@"12312312"];
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    else
    {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        
        /**********初始化TabBar**********/
        UITabBarController *tabController = [self createTabBar];
        tabController.delegate = self;
        self.window.rootViewController = tabController;
        [self.window makeKeyAndVisible];
        
        /**********读取数据库消息**********/
        [self changeIconBadgeNumber];
        
//        NSDictionary *aps = [NSDictionary dictionaryWithObjectsAndKeys:@"Text12345678谢旺贵",@"alert",@"1",@"badge",@"default",@"sound", nil];
//        NSDictionary *notifyDic = [NSDictionary dictionaryWithObjectsAndKeys:aps,@"aps",@"1234567890",@"id",@"1",@"type",@"http://www.baidu.com",@"url", nil];
//        MessageInfo *messageInfo = [[MessageInfo alloc] initMessageInfo:notifyDic];
//        [self cheshiDB:messageInfo];
        
        /**********推送通知**********/
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *deviceToken = [userDefaults objectForKey:KEY_TOKEN];
        if ((![[UIApplication sharedApplication] enabledRemoteNotificationTypes]) || deviceToken == nil || deviceToken.length == 0)
        {
            UIRemoteNotificationType types = (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert);
            //注册消息推送
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
        }
        else
        {
            [self sendTokenToServer:deviceToken];
        }
    }
    return YES;
}

#pragma mark push MSG
//获取DeviceToken成功, 然后根据需要进行传送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //去掉字串前后的<>字符
    NSString *newToken =[deviceToken description];
    NSRange range ;
    range.location = 1;
    range.length = newToken.length-2;
    newToken = [newToken substringWithRange:range];
    
    //去掉空格
    newToken =[newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"My token is: %@", newToken);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:KEY_TOKEN];
    if (token == nil) {
        token = newToken;
        [userDefaults setObject:newToken forKey:KEY_TOKEN];
        [userDefaults synchronize];
    }
    
    [self sendTokenToServer:newToken];
}

//- (void)cheshiDB:(MessageInfo *)messageInfo
//{
//    [[HondaDBService shareHondaDBService] saveMessageInfo:messageInfo];
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Receive Nofify:%@",userInfo);
    MessageInfo *messageInfo = [[MessageInfo alloc] initMessageInfo:userInfo];
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"HoandaEBox"
                                                            message:[NSString stringWithFormat:@"%@",alert]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    [[HondaDBService shareHondaDBService] saveMessageInfo:messageInfo];
    [self changeIconBadgeNumber];
    
//    NSString *messagePath = [CommonFunc getWidgetFilePath];
//    messagePath = [messagePath stringByAppendingPathComponent:@"Message.plist"];
//    if ([userInfo writeToFile:messagePath atomically:YES])
//    {
//        DLog(@"写入成功:");
//    }
//    else
//    {
//        DLog(@"Failed!!!");
//    }
    
//    NSString *messagePath = [CommonFunc getWidgetFilePath];
//    messagePath = [messagePath stringByAppendingPathComponent:@"Message.plist"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    NSMutableArray *messageList;
//    if ([fileManager fileExistsAtPath:messagePath])
//    {
//        messageList = [[NSMutableArray alloc] initWithContentsOfFile:messagePath];
//    }
//    
//    if (messageList == nil)
//    {
//        messageList = [[NSMutableArray alloc] initWithCapacity:0];
//    }
//    [messageList addObject:messageInfo];
//    
//    if (![messageList writeToFile:messagePath atomically:YES])
//    {
//        DLog(@"Write plist fail");
//    }
//    else
//    {
//        DLog(@"写入成功:");
//    }
    
//    NSMutableDictionary *messageDic;
//    NSMutableArray *boardMessageArr;
//    NSMutableArray *userMessageArr;
//    NSMutableArray *baoyangMessageArr;
//    if ([fileManager fileExistsAtPath:messagePath])
//    {
//        messageDic = [[NSMutableDictionary alloc] initWithContentsOfFile:messagePath];
//        boardMessageArr = (NSMutableArray *)[messageDic objectForKey:@"board"];
//        userMessageArr = (NSMutableArray *)[messageDic objectForKey:@"user"];
//        baoyangMessageArr = (NSMutableArray *)[messageDic objectForKey:@"baoyang"];
//    }
//    else
//    {
//        messageDic = [[NSMutableDictionary alloc] initWithCapacity:0];
//    }
//    //1-广播消息 2-用户消息 3-保养提醒
//    if ([messageInfo.type isEqualToString:@"1"])
//    {
//        if (boardMessageArr == nil)
//        {
//            boardMessageArr = [[NSMutableArray alloc] initWithCapacity:0];
//        }
//        [boardMessageArr addObject:messageInfo];
//    }
//    else if ([messageInfo.type isEqualToString:@"2"])
//    {
//        if (userMessageArr == nil)
//        {
//            userMessageArr = [[NSMutableArray alloc] initWithCapacity:0];
//        }
//        [userMessageArr addObject:messageInfo];
//    }
//    else if ([messageInfo.type isEqualToString:@"3"])
//    {
//        if (baoyangMessageArr == nil)
//        {
//            baoyangMessageArr = [[NSMutableArray alloc] initWithCapacity:0];
//        }
//        [baoyangMessageArr addObject:messageInfo];
//    }
//    
//    [messageDic setValue:boardMessageArr forKey:@"board"];
//    [messageDic setValue:userMessageArr forKey:@"user"];
//    [messageDic setValue:baoyangMessageArr forKey:@"baoyang"];
//    
//    //写入Plisth文件
//    if (![messageDic writeToFile:messagePath atomically:YES])
//    {
//        DLog(@"Write plist fail");
//    }
}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self changeIconBadgeNumber];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self changeIconBadgeNumber];
}

@end
