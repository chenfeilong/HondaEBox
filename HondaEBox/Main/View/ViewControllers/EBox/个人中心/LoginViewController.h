//
//  LoginViewController.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-18.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckButton.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tf_loginNo;
@property (weak, nonatomic) IBOutlet UITextField *tf_loginPassWord;
@property (weak, nonatomic) IBOutlet CheckButton *CB_autoLogin;

@end
