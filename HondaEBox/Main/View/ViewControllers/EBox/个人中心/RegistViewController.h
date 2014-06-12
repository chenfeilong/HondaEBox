//
//  RegistViewController.h
//  HondaEBox
//
//  Created by cloudpower on 14-5-18.
//  Copyright (c) 2014年 cloudPower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistViewController : UIViewController<UITextFieldDelegate>{
    UITextField *_number;

}
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *fdsf;

@property (strong, nonatomic) IBOutlet UIButton *btn;

@end
