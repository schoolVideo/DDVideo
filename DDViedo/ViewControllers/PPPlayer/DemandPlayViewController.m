//
//  DemandPlayViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
#define kMaxTag 100
#import "DemandPlayViewController.h"
#import "AsyncScrollView.h"
#import "InterfaceManager.h"
#import "Cell_PPScroll.h"
#import "Cell_Demand.h"

#import "RefreshTableView.h"
#import "PlayerViewController.h"
@interface DemandPlayViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * dataArray;
}
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation DemandPlayViewController
@synthesize dataArray;
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    dataArray = [[NSMutableArray alloc]init];
    
    [dataArray addObjectsFromArray:[InterfaceManager leftVCDataArr]];
    
//    __weak DemandPlayViewController * weakSelf = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createUI];
    
   
}
#pragma mark - 创建基本UI
-(void)createUI
{
    __weak DemandPlayViewController * weakSelf = self;
    
    self.tableView = [[RefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - 49) style:UITableViewStylePlain headerBlock:^{
        
        [weakSelf.tableView headerEndRefreshing];
        
    } footerBlock:^{
        
        [weakSelf.tableView footerEndRefreshing];
        
    }];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    //
    self.tableView.tableHeaderView = [self createHeaderView];
    
    [self.view addSubview:self.tableView];
}
-(AsyncScrollView *)createHeaderView
{
    NSArray * arr = [NSArray arrayWithObjects:@"6.jpg", @"2.jpg", @"7.jpg", @"4.jpg", @"5.jpg", nil];
    
    AsyncScrollView * sv = [[AsyncScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, (414 * 320 / (527.0 * 2)) * kRatio) andImageArray:arr];

    return sv;
}

#pragma mark - 六个直播台标的点击事件
-(void)btnClick:(UIButton *)button
{
    PlayerViewController * player = [[PlayerViewController alloc]initWithContentURL:[NSURL URLWithString:URL_TEST_MOVIE]];
    
    [self presentViewController:player animated:YES completion:nil];
    
    player.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    
    [player.moviePlayer play];
}

#pragma mark - tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }
    if (section == 1) {
        
        return 10;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        NSString * strID = @"ID1";
        
        Cell_PPScroll * cell = [tableView dequeueReusableCellWithIdentifier:strID];
        
        if (nil == cell) {
            
            cell = [[Cell_PPScroll alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        }
        
        NSArray * arr = @[cell.btn1, cell.btn2, cell.btn3, cell.btn4, cell.btn5, cell.btn6];
        
        NSInteger i = 0;
        
        for (UIButton * btn in arr) {
            
            btn.tag = kMaxTag + i;
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            i++;
        }
        
        return cell;

    }else{
        
        NSString * strID = @"ID";
        
        Cell_Demand * cell = [tableView dequeueReusableCellWithIdentifier:strID];
        
        if (nil == cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_Demand" owner:self options:nil] lastObject];
        }
        
        
        return cell;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        return 175;
    }
    return 75 * kRatio;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kMainScreenWidth - 75, 35)];
    lbl.text = @"卫视直播";
    lbl.backgroundColor = [UIColor redColor];
    
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lbl.frame), 0, 60, 40)];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMaxX(lbl.frame), 0, 60, 35);
    if (section == 1) {

        [btn setTitle:@"更多" forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:[UIImage imageNamed:@"t3"] forState:UIControlStateNormal];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 35)];
    
    [view addSubview:lbl];
    [view addSubview:btn];
    view.backgroundColor = [UIColor greenColor];
    return view;
}



@end
