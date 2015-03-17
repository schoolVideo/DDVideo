//
//  PlayerViewController.m
//  SB03
//
//  Created by 赵 冰冰 on 15/2/10.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
///是否可以自动旋转
-(BOOL) shouldAutorotate
{
    return YES;
}
-(NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication]  setStatusBarOrientation:UIInterfaceOrientationPortrait];
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
