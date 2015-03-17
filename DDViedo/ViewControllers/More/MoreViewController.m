//
//  MoreViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "MoreViewController.h"
#import "Cell_Personnal.h"
#import "CoucherCenterViewController.h"
#import "NewsTableViewController.h"
#import "MyCoucherCenterViewController.h"
#import "CurrentActViewController.h"
#import "NewsDetailViewController.h"
#import "SettingViewController.h"
@interface MoreViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation MoreViewController
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"更多";
    
    self.dataArr = [[NSMutableArray alloc]init];
    
    NSArray * arr1 = @[@"当前活动", ];
    NSArray * arr2 = @[@"充值中心", @"点击通话"];
    NSArray * arr3 = @[@"VOIP", @"资讯"];
    
    [self.dataArr addObject:arr1];
    [self.dataArr addObject:arr2];
    [self.dataArr addObject:arr3];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - 49) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataArr objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    Cell_Personnal * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[Cell_Personnal alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSLog(@"000 --%@", NSStringFromCGRect(cell.frame));
    }
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        UIImageView * iv = cell.imgView;
        
        CGRect frame = iv.frame;
        
        frame.origin.y = (70 - 44) / 2.0 + 22 - 15;
        
        cell.imgView.frame = frame;
        
        frame = cell.lbl.frame;
        
        frame.origin.y = (70 - 44) / 2.0 + 22 - 15;
        
        cell.lbl.frame = frame;
    }
    
    cell.lbl.text = [[self.dataArr objectAtIndex:indexPath.section]  objectAtIndex:indexPath.row];
    
    cell.imgView.image = [UIImage imageNamed:@"1.png"];
    
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return 70;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        NewsDetailViewController * news = [[NewsDetailViewController alloc]init];
        
        [self.navigationController pushViewController:news animated:YES];
        
        return;
        
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
       
        NewsTableViewController * ntc = [[NewsTableViewController alloc]init];
        [self.navigationController pushViewController:ntc animated:YES];
        
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        MyCoucherCenterViewController * mccv = [[MyCoucherCenterViewController alloc]init];
        [self.navigationController pushViewController:mccv animated:YES];
        mccv.title = @"充值中心";
    }
    


}
@end
