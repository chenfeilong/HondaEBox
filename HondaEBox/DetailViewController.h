//
//  DetailViewController.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-4.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
