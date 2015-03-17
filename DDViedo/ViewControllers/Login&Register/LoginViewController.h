//
//  LoginViewController.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/17.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UILabel *forgetPwdLbl;
@property (weak, nonatomic) IBOutlet UILabel *registerLbl;

@end
