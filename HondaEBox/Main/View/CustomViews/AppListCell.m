//
//  AppListCell.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-7.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "AppListCell.h"
#import "FileDownloadManage.h"
#import "TextViewController.h"

@implementation AppListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)downloadFunction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.titleLabel.text;
    FileDownloadManage *fileDowManage = [FileDownloadManage shareFileDownloadManage];
    if ([buttonTitle isEqualToString:@"下载"])
    {
        [fileDowManage beginDownloadWithAppListInfo:_appListInfo basePath:@"AppCenter" subPath:_appName.text];
        
        [button setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else if ([buttonTitle isEqualToString:@"暂停"])
    {
        [fileDowManage downloadPause:self.operation];
        [button setTitle:@"继续" forState:UIControlStateNormal];
    }
    else if ([buttonTitle isEqualToString:@"继续"])
    {
        [fileDowManage downloadResume:self.operation];
        [button setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else if ([buttonTitle isEqualToString:@"启动"])
    {
        DLog(@"应用启动");
        TextViewController *textVC = [[TextViewController alloc] init];
        [self.carType.navigationController pushViewController:textVC animated:YES];
    }
}


@end
