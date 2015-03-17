//
//  CoucherCenterViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/4.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "CoucherCenterViewController.h"

@interface CoucherCenterViewController ()

@end

@implementation CoucherCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

-(void)createUI
{
    UILabel * lbl = [[UILabel alloc]init];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:@"手机充值" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    UIButton * btn2 = [[UIButton alloc]init];
    btn2.backgroundColor = [UIColor blueColor];
    [btn2 setTitle:@"宽带缴费" forState:UIControlStateNormal];
    btn2.translatesAutoresizingMaskIntoConstraints = NO;
    UITextView * textView = [[UITextView alloc]init];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:lbl];
    [self.view addSubview:btn];
    [self.view addSubview:btn2];
    [self.view addSubview:textView];
    
    NSArray * vfl1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[btn2]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn2)];
    NSArray * vfl2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn2(==40)]-80-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn2)];
    
    NSArray * vfl3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn]-30-[btn2]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn, btn2)];
    
    NSArray * vfl4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[btn]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn, btn2)];
    
    NSArray * vfl5 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[textView]-20-[btn]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn, textView)];
    
    NSArray * vfl6 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[btn]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn, textView)];
    
    
    [self.view addConstraints:vfl1];
    [self.view addConstraints:vfl2];
    [self.view addConstraints:vfl3];
    [self.view addConstraints:vfl4];
    [self.view addConstraints:vfl5];
    [self.view addConstraints:vfl6];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
