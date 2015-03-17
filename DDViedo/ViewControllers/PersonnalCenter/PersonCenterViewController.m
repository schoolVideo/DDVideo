//
//  PersonCenterViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "InterfaceManager.h"
#import "Cell_Personnal.h"
#import "PersonDataViewController.h"
#import "SettingViewController.h"
#import "MyCollectViewController.h"
@interface PersonCenterViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation PersonCenterViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [_dataArray addObjectsFromArray:[InterfaceManager personVCData]];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 49 - 44) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [self createHeaderView];
    
}
-(void)btnClick:(UIButton *)btn
{
    
}
-(UIView *)createHeaderView
{
    UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 240 * kRatio)];
    view.image = [UIImage imageNamed:@"1.jpg"];
    
    view.userInteractionEnabled = YES;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMidX(view.frame) - 35, CGRectGetMidY(view.frame) - 70, 70, 70)];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"3.jpg"] forState:UIControlStateNormal];
    
    [view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame) , CGRectGetMaxY(btn.frame)+ 10, CGRectGetWidth(btn.frame), 20)];
    
    lbl.textAlignment = NSTextAlignmentCenter;
    
    lbl.backgroundColor = [UIColor greenColor];
    
    lbl.text = @"未登录";
    
    [view addSubview:lbl];
    
    return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataArray objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"ID";
    
    Cell_Personnal * cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (nil == cell) {
        
        cell = [[Cell_Personnal alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
    cell.lbl.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        PersonDataViewController * vc = [[PersonDataViewController alloc]initWithNibName:@"PersonDataViewController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 2 && indexPath.section == 1) {
        
        SettingViewController * setVC = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
        
        [self.navigationController pushViewController:setVC animated:YES];
    }
    if (indexPath.row == 0 && indexPath.section == 1) {
        
        MyCollectViewController * myCollectionVC = [[MyCollectViewController alloc]init];
        [self.navigationController pushViewController:myCollectionVC animated:YES];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
@end
