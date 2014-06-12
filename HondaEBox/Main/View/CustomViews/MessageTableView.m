//
//  MessageTableView.m
//  eBox
//
//  Created by HsiehWangKuei on 14-4-3.
//  Copyright (c) 2014年 cloudpower. All rights reserved.
//

#import "MessageTableView.h"

@implementation MessageTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextMoveToPoint(context, 43, self.bounds.origin.y);
    CGContextAddLineToPoint(context, 43, self.bounds.size.height);
    CGContextStrokePath(context);
    
}

@end
