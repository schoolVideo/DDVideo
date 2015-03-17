//
//  MyCoucherCenterViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/5.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "MyCoucherCenterViewController.h"
#import "MyReChargeViewController.h"
@interface MyCoucherCenterViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *feeBtn;

@end

@implementation MyCoucherCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}
/**
 手机充值
 */

- (IBAction)btnClick:(id)sender {
    
    NSLog(@"手机充值");
    
    MyReChargeViewController * mvc = [[MyReChargeViewController alloc]initWithNibName:@"MyReChargeViewController" bundle:nil];
    [self.navigationController pushViewController:mvc animated:YES];
}

/*
 宽带缴费

 **/
- (IBAction)btnClick2:(id)sender {
    
    NSLog(@"宽带缴费");
}

@end
