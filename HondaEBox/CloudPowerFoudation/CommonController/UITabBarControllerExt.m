//
//  UITabBarControllerExt.m
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import "UITabBarControllerExt.h"

@interface UITabBarControllerExt ()

@end

@implementation UITabBarControllerExt

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
    isNeedCreatTab = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (isNeedCreatTab)
    {
        isNeedCreatTab = NO;
        slideBg = [[UIImageView alloc] initWithImage:self.tabBar.selectionIndicatorImage];
        [self hideRealTabBar];
        [self customTabBar];
    }
}

//隐藏真正的TabBar
- (void)hideRealTabBar
{
    for(UIView *view in self.view.subviews){
		if([view isKindOfClass:[UITabBar class]]){
			[(UITabBar *)view setHidden:YES];
			break;
		}
	}
}

- (void)customTabBar
{
    self.tabBarView = [[UIView alloc] initWithFrame:self.tabBar.frame];
    UIColor *bgColor = [UIColor colorWithPatternImage:self.tabBar.backgroundImage];
    self.tabBarView.backgroundColor = bgColor;
    
    //创建按钮
	int viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
	self.buttons = [NSMutableArray arrayWithCapacity:viewCount];
	float _width = 30 , _height = 40;
    float origin_x = 20, origin_y = 4.5;
    [self.tabBarView addSubview:slideBg];
    
    for (int i = 0; i < viewCount; i++)
    {
        UIViewController *VC = [self.viewControllers objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setBackgroundImage:VC.tabBarItem.image forState:UIControlStateNormal];
        if (i == 0) {
            button.frame = CGRectMake(origin_x, origin_y, _width, _height / 2);
            UILabel *tabTitle = [[UILabel alloc] initWithFrame:CGRectMake(origin_x, origin_y + _height / 2, _width, _height /2)];
            tabTitle.backgroundColor = [UIColor clearColor];
            tabTitle.text = VC.tabBarItem.title;
            tabTitle.textAlignment = NSTextAlignmentCenter;
            tabTitle.font = [UIFont fontWithName:@"Arial" size:15.f];
            tabTitle.textColor = [UIColor blackColor];
            [self.tabBarView addSubview:tabTitle];
        }
        else if ( i == 1)
        {
            button.frame = CGRectMake(0, 0, _width * 2, _height);
            button.center = CGPointMake(160, 24.5);
        }
        else
        {
            button.frame = CGRectMake(278, origin_y, _width - 8, _height / 2);
            UILabel *tabTitle = [[UILabel alloc] initWithFrame:CGRectMake(278, origin_y + _height / 2, _width, _height /2)];
            tabTitle.center = CGPointMake(button.center.x, button.center.y + 20);
            tabTitle.backgroundColor = [UIColor clearColor];
            tabTitle.text = VC.tabBarItem.title;
            tabTitle.textAlignment = NSTextAlignmentCenter;
            tabTitle.font = [UIFont fontWithName:@"Arial" size:15.f];
            tabTitle.textColor = [UIColor blackColor];
            [self.tabBarView addSubview:tabTitle];
        }
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttons addObject:button];
        [self.tabBarView addSubview:button];
    }
    
    [self.view addSubview:_tabBarView];
    [self selectedTab:[self.buttons objectAtIndex:self.currentSelectedIndex]];
}

- (void)selectedTab:(UIButton *)button
{
    if (self.currentSelectedIndex == button.tag) {
		
	}
	self.currentSelectedIndex = button.tag;
	self.selectedIndex = self.currentSelectedIndex;
	[self performSelector:@selector(slideTabBg:) withObject:button];
}

- (void)slideTabBg:(UIButton *)btn{
    // 采用旧方式
    //	[UIView beginAnimations:nil context:nil];
    //	[UIView setAnimationDuration:0.20];
    //	[UIView setAnimationDelegate:self];
    //	slideBg.frame = btn.frame;
    //	[UIView commitAnimations];
    //采用新方式
    [UIView animateWithDuration:0.20
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         slideBg.frame = btn.frame;
                     }
                     completion:nil];
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
