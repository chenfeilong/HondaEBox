//
//  SlidingMenueView.h
//  eBox
//
//  Created by HsiehWangKuei on 14-4-2.
//  Copyright (c) 2014年 GB_HONDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlidingMenueDelegate <NSObject>

-(void)touchUpInsideMenuItemIndex:(NSUInteger)selectedIndex;

@end

@interface SlidingMenueView : UIView
{
    NSArray *_items;
    UIImageView *_slideBg;
    NSUInteger _itemCount;
    float _itemWidth;
    float _itemHeight;
//    id<SlidingMenueDelegate> delegate;
}

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) id<SlidingMenueDelegate>delegate;

- (id)initWithFrame:(CGRect)frame menueItems:(NSArray *)items delegate:(id<SlidingMenueDelegate>)slidingMenueDelegate;

@end
