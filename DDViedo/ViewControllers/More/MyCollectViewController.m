//
//  MyCollectViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/16.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
#define kMaxTag 100
#import "MyCollectViewController.h"
#import "SVSegmentedControl.h"
#import "Cell_Live.h"
#import "Cell_Demand.h"
@interface MyCollectViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIScrollView * bgSV;

@end

@implementation MyCollectViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray * titles = @[@"直播频道", @"点播节目"];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn  setTitle:titles[i] forState:UIControlStateNormal];
        
        btn.backgroundColor = [UIColor redColor];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i * kMainScreenWidth / 2, 0, kMainScreenWidth /2, 30);
        btn.tag = i;
        [self.view addSubview:btn];
    }
    
    UIView * animaView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainScreenWidth / 2, 5)];
    animaView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:animaView];
    animaView.tag = kMaxTag + 1;
    
    self.bgSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(animaView.frame), kMainScreenWidth, kMainScreenHeight - 64 - CGRectGetMaxY(animaView.frame))];
    self.bgSV.delegate = self;
    [self.view addSubview:self.bgSV];
    self.bgSV.pagingEnabled = YES;
    self.bgSV.contentSize = CGSizeMake(kMainScreenWidth * 2, kMainScreenHeight - 64 - CGRectGetMaxY(animaView.frame));
    
    [self.view addSubview:self.bgSV];
    
    for (NSInteger i = 0; i < 2; i++) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(kMainScreenWidth * i, 0, kMainScreenWidth, kMainScreenHeight - 64 - CGRectGetMaxY(animaView.frame)) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = kMaxTag * 10 + i;
        [self.bgSV addSubview:tableView];
    }
    
    
    
    [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
}
  
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentIndex"]) {
        
        NSInteger curPage = [[change objectForKey:@"new"] integerValue];
        [self commonAimationWithIndex:curPage];
        
    }
}
-(void)commonAimationWithIndex:(NSInteger)index
{
   
    UIView * v = [self.view viewWithTag:kMaxTag + 1];
    
    CGRect frame = v.frame;
    
    frame.origin.x = self.currentIndex * kMainScreenWidth / 2.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        v.frame = frame;
        
    }];
    
    UITableView * tableView =(UITableView *) [self.view viewWithTag:kMaxTag * 10 + index];
    [tableView reloadData];
    
}
-(void)btnClick:(UIButton *)btn
{
    self.currentIndex = btn.tag;
   
}
#pragma mark - uitableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentIndex == 0) {
        
        return 80;
    }else{
        
        return 200;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentIndex == 1) {
        
        static NSString * strID1 = @"Cell_Demand_ID";
        
        Cell_Demand * cell = [tableView dequeueReusableCellWithIdentifier:strID1];
        
        if (nil == cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_Demand" owner:self options:nil] lastObject];
        }
        
        return cell;

        
    }else{
        
        static NSString * strID2 = @"Cell_Live_ID";
        
        Cell_Live * cell = [tableView dequeueReusableCellWithIdentifier:strID2];
        
        if (nil == cell) {
            
           cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_Live" owner:self options:nil] lastObject];
        }
        
        return cell;
    }
    
    return nil;
}
#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.bgSV]) {
    
        NSInteger curPage = scrollView.contentOffset.x / kMainScreenWidth;
        
        self.currentIndex = curPage;

    }
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"currentIndex"];
}
@end
