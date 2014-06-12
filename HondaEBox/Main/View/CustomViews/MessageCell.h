//
//  MessageCell.h
//  eBox
//
//  Created by HsiehWangKuei on 14-4-2.
//  Copyright (c) 2014年 cloudpower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckButton.h"

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) CheckButton *checkBtn;

@end
