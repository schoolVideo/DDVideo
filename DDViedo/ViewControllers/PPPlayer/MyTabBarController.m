//
//  MyTabBarController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "MyTabBarController.h"
#import "DemandPlayViewController.h"
#import "LiveViewController.h"
#import "PersonCenterViewController.h"
#import "PrivillegeLifeViewController.h"
#import "MoreViewController.h"
@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    DemandPlayViewController * demandVC = [[DemandPlayViewController alloc]init];
    UINavigationController * nc01 = [[UINavigationController alloc]initWithRootViewController:demandVC];
    LiveViewController * liveVC = [[LiveViewController alloc]init];
    UINavigationController * nc02 = [[UINavigationController alloc]initWithRootViewController:liveVC];
    PersonCenterViewController * personVC = [[PersonCenterViewController alloc]init];
    UINavigationController * nc03 = [[UINavigationController alloc]initWithRootViewController:personVC];
    PrivillegeLifeViewController * privillegeVC = [[PrivillegeLifeViewController alloc]init];
    UINavigationController * nc04 = [[UINavigationController alloc]initWithRootViewController:privillegeVC];
    MoreViewController * moreVC = [[MoreViewController alloc]init];
    UINavigationController * nc05 = [[UINavigationController alloc]initWithRootViewController:moreVC];
    NSArray * viewControllers = @[nc01, nc02, nc03, nc04, nc05];
    
    //导航条不透明
    NSInteger i = 0;
    
    NSArray * name = @[@"首页", @"校园TV", @"个人中心", @"惠生活", @"更多"];
    
    for (UINavigationController * nc in viewControllers) {
        
        nc.navigationBar.translucent = NO;
        
        UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:name[i] image:nil selectedImage:nil];
        
        nc.tabBarItem = item;
        
        i++;
        
    }
    self.viewControllers = viewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
