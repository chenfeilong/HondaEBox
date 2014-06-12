//
//  CarTypeFormViewController.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "CarTypeFormViewController.h"
#import "UIHelpers.h"
#import "Define.h"
#import "AppListInfo.h"
#import "CommonFunc.h"
#import "NetWorking.h"
#import "TextViewController.h"
#import "Define.h"
#define IP @"http://192.168.2.254:8080"

@interface CarTypeFormViewController ()

@end

@implementation CarTypeFormViewController

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
    NetWorking *netWork = [NetWorking shareNetWorking];
    [netWork upgradeDataPack];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upgradeDataPackFinished:) name:@"upgradeDataPackFinished" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"upgradeDataPackFinished" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:[UIHelpers headerViewWithImage:[UIImage imageNamed:@"底部1.png"] title:@"应用中心"]];
    
    FileDownloadManage *fileDowManage = [FileDownloadManage shareFileDownloadManage];
    fileDowManage.downloadDelegate = self;
    
    self.appListArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.finishedList = [[NSMutableArray alloc] initWithCapacity:0];
    [self loadFinishedFiles];
    
//    NetWorking *netWork = [NetWorking shareNetWorking];
//    [netWork getAppForm];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAppFormFinished:) name:@"getAppFormFinished" object:nil];
    
    //创建车型目录
    NSString *carsFilePath = [CommonFunc getDocumentFilePath];
    carsFilePath = [carsFilePath stringByAppendingPathComponent:@"App/Cars"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:carsFilePath])
    {
        carsFilePath = [CommonFunc getCarsDocumentFilePath];
    }
    
    NSString *carCacheFilePath = [CommonFunc getDocumentFilePath];
    carCacheFilePath = [carCacheFilePath stringByAppendingPathComponent:@"App/CarCache"];
    if (![fileManager fileExistsAtPath:carCacheFilePath])
    {
        carCacheFilePath = [CommonFunc getCarCacheFilePath];
    }
    
    
    [self initAppList];
}
/**
 *  初始化
 */
- (void)initAppList
{
    
    float origin_x = 0, origin_y = IsIOS7?64:44;
    float width = 320, height = (IsIOS7?480:580) - 49 - origin_y;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(origin_x, origin_y, width, height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
//
//    NSArray *onlineBooksUrl = [NSArray arrayWithObjects:@"https://codeload.github.com/AFNetworking/AFNetworking/zip/master",
//                               @"http://219.239.26.11/download/46280417/68353447/3/dmg/105/192/1369883541097_192/KindleForMac._V383233429_.dmg",
//                               @"http://free2.macx.cn:81/Tools/Office/UltraEdit-v4-0-0-7.dmg",
//                               @"http://124.254.47.46/download/53349786/76725509/1/exe/13/154/53349786_1/QQ2013SP4.exe",
//                               @"http://dldir1.qq.com/qqfile/qq/QQ2013/QQ2013SP5/9050/QQ2013SP5.exe",
//                               @"http://dldir1.qq.com/qqfile/tm/TM2013Preview1.exe",
//                               @"http://dldir1.qq.com/invc/tt/QQBrowserSetup.exe",
//                               @"http://dldir1.qq.com/music/clntupate/QQMusic_Setup_100.exe",
//                               @"http://image.baidu.com/channel/listdownload?word=download&fr=channel&ie=utf8&countop=0&url=http%3A%2F%2Fg.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fb3b7d0a20cf431adb55484bc4936acaf2fdd98b5.jpg&image_id=11642518398&col=%E7%BE%8E%E5%A5%B3&tag=%E7%94%9C%E7%B4%A0%E7%BA%AF&sorttype=0&sortlog=0", nil];
//    NSArray *names = [NSArray arrayWithObjects:@"MacQQ", @"KindleForMac",@"UltraEdit",@"QQ2013SP4",@"QQ2013SP5",@"TM2013",@"QQBrowser",@"QQMusic",@"QQPinyin",nil];
//    
//    self.downloadingList = [[NSMutableArray alloc] initWithCapacity:0];
//    for (int i = 0; i < names.count; i++)
//    {
//        AppListInfo *appListInfo = [[AppListInfo alloc] init];
//        appListInfo.appName = [names objectAtIndex:i];
//        appListInfo.appUrl = [onlineBooksUrl objectAtIndex:i];
//        appListInfo.appVersion = @"1.0.1";
//        [self.appListArr addObject:appListInfo];
//    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource - 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.finishedList != nil && self.finishedList.count > 0)
    {
        return 2;
    }
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.finishedList.count > 0)
    {
        if (section == 0)
        {
            return _finishedList.count;
        }
        else
            return _appListArr.count;
    }
    else
        return _appListArr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.finishedList.count > 0)
    {
        if (section == 0)
        {
            return @"已下载";
        }
        else
            return @"未下载";
    }
    else
        return @"未下载";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *appListCell = @"appListCell";
//    NSString *appListCell = [NSString stringWithFormat:@"appListCell%d%d",indexPath.section,indexPath.row];
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:appListCell];
    if (cell == nil)
    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:appListCell];
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AppListCell" owner:self options:nil];
        if (nibArray.count > 0)
        {
            cell = [nibArray lastObject];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
    }
    
    if (indexPath.section == 0 && _finishedList.count > 0)
    {
        AppListInfo *finishedApp = (AppListInfo *)[self.finishedList objectAtIndex:indexPath.row];
        cell.downloadProgress.hidden = YES;
        cell.appVersion.hidden = NO;
        cell.appName.text = finishedApp.appName;
        cell.appVersion.text = finishedApp.appVersion;
        cell.appListInfo = finishedApp;
        cell.appUrl = finishedApp.appUrl;
        cell.carType = self;
        
        if (cell.appListInfo.downloadFinished)
        {
            [cell.operateBtn setTitle:@"已下载" forState:UIControlStateNormal];
        }
    }
    else
    {
        AppListInfo *appListInfo = (AppListInfo *)[self.appListArr objectAtIndex:indexPath.row];
        
        cell.downloadProgress.hidden = YES;
        cell.appVersion.hidden = NO;
        cell.appName.text = appListInfo.appName;
        cell.appVersion.text = appListInfo.appVersion;
        cell.appListInfo = appListInfo;
        cell.appUrl = appListInfo.appUrl;
        cell.carType = self;
        
        if (cell.appListInfo.willDownload && !cell.appListInfo.isDownloading)
        {
            [cell.operateBtn setTitle:@"下载" forState:UIControlStateNormal];
        }
        else if (!cell.appListInfo.willDownload && cell.appListInfo.isDownloading)
        {
            [cell.operateBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }
    }
    
    
//    if (cell.appListInfo.downloadFinished)
//    {
//        [cell.operateBtn setTitle:@"完成" forState:UIControlStateNormal];
//    }
    
    return cell;
}

#pragma mark - UITableViewDelegate Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppListCell *cell = (AppListCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.appListInfo.downloadFinished)
    {
        TextViewController *textVC = [[TextViewController alloc] init];
        [self.navigationController pushViewController:textVC animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (_finishedList.count > 0 && indexPath.section == 0)
        {
            [_finishedList removeObjectAtIndex:indexPath.row];
            [self saveFinishedFile];
        }
        else
        {
            [_appListArr removeObjectAtIndex:indexPath.row];
        }
        [tableView reloadData];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

#pragma mark - DownloadDelegate Method -
/**
 *  应用正在下载，刷新进度
 *
 *  @param operation AFURLConnectionOperation
 */
- (void)updateCellProgress:(AFURLConnectionOperation *)operation
{
    AppListInfo *appListInfo = (AppListInfo *)[operation.userInfo objectForKey:@"appListInfo"];
    NSLog(@"已经下载:%f",(float)appListInfo.totalBytesRead);
    [self performSelectorOnMainThread:@selector(updateCellOnMainThread:) withObject:appListInfo waitUntilDone:YES];
}
/**
 *  应用下载完成
 *
 *  @param operation AFURLConnectionOperation
 */
- (void)downloadFinished:(AFURLConnectionOperation *)operation
{
    AppListInfo *appListInfo = (AppListInfo *)[operation.userInfo objectForKey:@"appListInfo"];
    DLog(@"下载完成!!!!");
    
    [self.finishedList addObject:appListInfo];
    [self.appListArr removeObject:appListInfo];
    [self saveFinishedFile];
    
    [self.tableView reloadData];
//    [self performSelectorOnMainThread:@selector(downloadFinishedOnMainThread:) withObject:appListInfo waitUntilDone:YES];
}

#pragma mark - 私有方法 -
/**
 *  刷新cell的进度条
 *
 *  @param appListInfo
 */
- (void)updateCellOnMainThread:(AppListInfo *)appListInfo
{
    NSArray *cellArr = (NSArray *)[self.tableView visibleCells];
    for (id obj in cellArr)
    {
        if ([obj isKindOfClass:[AppListCell class]])
        {
            AppListCell *cell = (AppListCell *)obj;
            if ([cell.appUrl isEqualToString:appListInfo.appUrl] && appListInfo.isDownloading)           //更新对应任务的Progress,正在下载
            {
                float currenSize = (float)appListInfo.totalBytesRead;
                float totalSize = (float)appListInfo.totalBytesExpectedToRead;
                float progress = [CommonFunc getProgress:totalSize andCurrentSize:currenSize];
                
                cell.appVersion.hidden = YES;
                cell.downloadProgress.hidden = NO;
                cell.operation = appListInfo.operation;
                [cell.downloadProgress setProgress:progress];
            }
            else if ([cell.appUrl isEqualToString:appListInfo.appUrl] && appListInfo.downloadFinished)      //下载完成
            {
                cell.appVersion.hidden = NO;
                cell.downloadProgress.hidden = YES;
                cell.operation = nil;
                [cell.operateBtn setTitle:@"启动" forState:UIControlStateNormal];
                
//                NSInteger row = [self.appListArr indexOfObject:appListInfo];
                [self.tableView reloadData];
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
//                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }
}
/**
 *  回主线程更新下载状态
 *
 *  @param appListInfo appListInfo Model
 */
- (void)downloadFinishedOnMainThread:(AppListInfo *)appListInfo
{
    NSArray *cellArr = (NSArray *)[self.tableView visibleCells];
    for (NSObject *obj in cellArr)
    {
        if ([obj isKindOfClass:[AppListCell class]])
        {
            AppListCell *cell = (AppListCell *)obj;
            if ([cell.appUrl isEqualToString:appListInfo.appUrl])
            {
                NSInteger row = [self.appListArr indexOfObject:appListInfo];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                [cell.operateBtn setTitle:@"启动" forState:UIControlStateNormal];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }
}
/**
 *  文件下载完成保存信息到本地plist文件
 */
- (void)saveFinishedFile
{
    if (_finishedList == nil || _finishedList.count == 0)
    {
        return;
    }
    
    NSMutableArray *finishedArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (AppListInfo *appListInfo in _finishedList)
    {
        NSDictionary *appDic = @{@"appName": appListInfo.appName,@"appUrl":appListInfo.appUrl,@"version":appListInfo.appVersion};
        [finishedArr addObject:appDic];
    }
    
    NSString *finishPlistPath = [CommonFunc getAppFilePath];
    finishPlistPath = [finishPlistPath stringByAppendingPathComponent:@"FinishedFiles.plist"];
    if (![finishedArr writeToFile:finishPlistPath atomically:YES])
    {
        DLog(@"Write plist fail");
    }
}
/**
 *  读取手机客户端本地保存的已经下载完成的文件
 */
- (void)loadFinishedFiles
{
    NSString *finishPlistPath = [CommonFunc getAppFilePath];
    finishPlistPath = [finishPlistPath stringByAppendingPathComponent:@"FinishedFiles.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:finishPlistPath])
    {
        NSMutableArray *finishedFiles = [[NSMutableArray alloc] initWithContentsOfFile:finishPlistPath];
        for (NSDictionary *appDic in finishedFiles)
        {
            AppListInfo *appInfo = [[AppListInfo alloc] init];
            appInfo.appName = [appDic objectForKey:@"appName"];
            appInfo.appUrl = [appDic objectForKey:@"appUrl"];
            appInfo.appVersion = [appDic objectForKey:@"version"];
            appInfo.downloadFinished = YES;
            appInfo.isDownloading = NO;
            appInfo.willDownload = NO;
            [_finishedList addObject:appInfo];
        }
    }
}

- (void)judgeCarsAppUpdate:(NSArray *)finishedList appListArr:(NSArray *)appListArr
{
    NSInteger appListCount = appListArr.count;
    for (int i = 0; i < appListCount; i++)
    {
        AppListInfo *finished_apps = (AppListInfo *)[finishedList objectAtIndex:i];
        AppListInfo *server_apps = (AppListInfo *)[appListArr objectAtIndex:i];
        
        if ([finished_apps.appName isEqualToString:server_apps.appName])
        {
//            if (finished_apps.vi) {
//                <#statements#>
//            }
        }
    }
}

#pragma mark - URL NetWorking -
/**
 *  请求应用列表
 *
 *  @param notity 接口返回信息
 */
- (void)getAppFormFinished:(NSNotification *)notity
{
    DLog(@"数据:%@",notity.object);
    NSDictionary *responseDic = (NSDictionary *)notity.object;
    if ([responseDic isKindOfClass:[NSDictionary class]])
    {
        NSArray *apps = (NSArray *)[responseDic objectForKey:@"apps"];
        if ([apps count] > 0)
        {
            for (NSDictionary *appsDic in apps)
            {
                AppListInfo *appListInfo = [[AppListInfo alloc] initWithApps:appsDic];
                [self.appListArr addObject:appListInfo];
            }
        }
        else
        {
            
        }
        
        [self.tableView reloadData];
    }
}

/**
 *  数据包升级接口请求完成
 *
 *  @param notity 请求完成返回参数
 */
- (void)upgradeDataPackFinished:(NSNotification *)notity
{
    NSObject *response = notity.object;
    
    NSLog(@"!!!!!!!!!!!");
    if (self.appListArr != nil && self.appListArr.count > 0)
    {
        [self.appListArr removeAllObjects];
    }
    if ([response isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dataPackDic = (NSDictionary *)response;
        if ([[dataPackDic objectForKey:@"rspCode"] isEqualToString:@"1"])
        {
            [UIHelpers alertWithTitle:@"温馨提示" andMSG:[dataPackDic objectForKey:@"rspDesc"]];
        }
        else
        {
            AppListInfo *appListInfo = [[AppListInfo alloc] init];
            NSArray *arr = [dataPackDic objectForKey:@"dataUpdate"];
            appListInfo.appName = [[arr objectAtIndex:0]objectForKey:@"name"];
        
            appListInfo.appUrl = [NSString stringWithFormat:@"%@%@",IP,[[arr objectAtIndex:0] objectForKey:@"url"]];
            NSLog(@"Url = %@",appListInfo.appUrl);
            appListInfo.appVersion = [dataPackDic objectForKey:@"version"];
            [self.appListArr addObject:appListInfo];
        }
    }
    
    [self.tableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"upgradeDataPackFinished" object:nil];
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
