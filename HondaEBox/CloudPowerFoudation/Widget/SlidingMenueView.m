//
//  SlidingMenueView.m
//  eBox
//
//  Created by HsiehWangKuei on 14-4-2.
//  Copyright (c) 2014年 GB_HONDA. All rights reserved.
//

#import "SlidingMenueView.h"

@implementation SlidingMenueView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame menueItems:(NSArray *)items delegate:(id<SlidingMenueDelegate>)slidingMenueDelegate
{
    if ((self = [super initWithFrame:frame]))
    {
        _itemCount = items.count;
        _items = items;
        if (_itemCount > 0)
        {
            _itemWidth = frame.size.width / _itemCount;
            _itemHeight = frame.size.height;
            [self drawItems];
            [self drawSlider];
            self.delegate = slidingMenueDelegate;
        }
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.backgroundColor = [UIColor whiteColor];
    UIImageView * backgroundImageView = [[[UIImageView alloc]initWithFrame:rect] autorelease];
    backgroundImageView.image = [UIImage imageNamed:@"slideBackGroud.png"];
    [self insertSubview:backgroundImageView atIndex:0];
}

#pragma mark - 局部函数 -
//封装滑块
-(void)moveItemToIndex:(NSUInteger)toIndex{
    
    self.selectedIndex = toIndex;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    UIImageView * sliderImageView = (UIImageView * )[self viewWithTag:2111];
    sliderImageView.frame = CGRectMake(_itemWidth * toIndex, 0, _itemWidth, _itemHeight);
    [UIView commitAnimations];
    
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    for (int i=0; i<_itemCount; i++) {
        UILabel * label = (UILabel*)[self viewWithTag:[[@"111" stringByAppendingString:[NSString stringWithFormat:@"%d", i]] intValue]];
        
        if (i == selectedIndex) {
            label.font = [UIFont boldSystemFontOfSize:18];
        }else{
            label.font = [UIFont boldSystemFontOfSize:16];
        }
    }
}

- (void)drawSlider
{
    UIImageView *sliderImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(_itemWidth * _selectedIndex, 0, _itemWidth, _itemHeight)] autorelease];
    sliderImageView.image = [UIImage imageNamed:@"8-1"];
    sliderImageView.tag = 2111;
    [self insertSubview:sliderImageView atIndex:0];
}

- (void)drawItems
{
    for (int i = 0; i < _itemCount; i++)
    {
        UIView * itemView = [[[UIView alloc]initWithFrame: CGRectMake(_itemWidth*i, 0, _itemWidth, _itemHeight) ] autorelease];
        UIImageView * backgroundImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(_itemWidth-1, 0, 1, _itemHeight)] autorelease];
        backgroundImageView.image = [UIImage imageNamed:@"8-2.png"];
        [itemView insertSubview:backgroundImageView atIndex:0];
        UILabel * titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _itemWidth, _itemHeight)] autorelease];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [_items objectAtIndex:i];
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment =NSTextAlignmentCenter;
        
        titleLabel.tag =  [[@"111" stringByAppendingString:[NSString stringWithFormat:@"%d", i]] intValue];
        titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.35];
        titleLabel.shadowOffset = CGSizeMake(0, -1.0);
        
        [itemView addSubview: titleLabel];
        itemView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGesture = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSlidingMenuSelectedAtIndex:) ] autorelease];
        itemView.tag = i;
        [itemView addGestureRecognizer:tapGesture];
        [self addSubview:itemView];
    }
}

#pragma mark - slidingMenu 点击事件响应 -
-(void)didSlidingMenuSelectedAtIndex:(id)sender{
    [self moveItemToIndex:((UITapGestureRecognizer * )sender).view.tag];
    if (self.delegate ) {
        [self.delegate touchUpInsideMenuItemIndex:((UITapGestureRecognizer * )sender).view.tag];
    }
}

@end
