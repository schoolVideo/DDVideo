//
//  NewsTableViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/5.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
#define kMaxTag 100
#define kTableViewTag 1000
#import "NewsTableViewController.h"
#import "Cell_News.h"
#import "RefreshTableView.h"
#import "HMSegmentedControl.h"
#import "NewsDetailViewController.h"
#import "AFNHttpTools.h"
#import "NewsItem.h"
#import "CurrentActViewController.h"

@interface NewsTableViewController ()<UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView * sv;
@property (nonatomic, strong) UIPageControl * pc;
@property (nonatomic, strong) HMSegmentedControl * seg;

@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, strong) UIImageView * bgView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation NewsTableViewController

@synthesize page;

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资讯";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    [self createUI];
    
//    [self addObserver:self forKeyPath:@"curPage" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"curPage"]) {
        
        NSInteger old = [[change objectForKey:@"old"] integerValue];
        NSInteger new = [[change objectForKey:@"new"] integerValue];
        CGRect oldFrame = CGRectMake(old * (kMainScreenWidth - 20) /3.0 + 10, 27, kMainScreenWidth / 3.0 - 20, 27);
        CGRect newFrame = CGRectMake(new * (kMainScreenWidth) /3.0 + 10, 27, kMainScreenWidth / 3.0 - 20, 27);
        self.bgView.frame = oldFrame;
        [UIView animateWithDuration:0.1 animations:^{
            self.bgView.frame = newFrame;
        }];
    }
}

-(void)btnClick:(UIButton *)btn
{
    self.curPage = btn.tag - kMaxTag;
    NSInteger index = btn.tag - kMaxTag;
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point = self.sv.contentOffset;
        point.x = index * kMainScreenWidth;
        self.sv.contentOffset = point;
    }];

}
#pragma mark - refreshDelegate
-(void)headerRefresh
{
    NSLog(@"下拉刷新");
    
    page = 1;
    [self startHttpRequest:URL_NESLIST categoryID:1 pageIndex:page nums:10];
}

-(void)footerRefresh
{
    NSLog(@"上拉加载更多");
    page++;
    [self startHttpRequest:URL_NESLIST categoryID:1 pageIndex:page nums:10];
    
    
}
-(void)createUI
{
    NSArray * arr = @[@"最新资讯", @"生活服务", @"查询黄页"];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag = kMaxTag + i;
//        btn.backgroundColor = [UIColor greenColor];
        [btn setBackgroundImage:[UIImage imageNamed:@"t1"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(kMainScreenWidth / 3.0 * i, 0, kMainScreenWidth / 3.0, 30);
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];

    }
    self.bgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 27, kMainScreenWidth / 3.0 - 20, 3)];
    self.bgView.image = [UIImage imageNamed:@"t3"];
    [self.view addSubview:self.bgView];
    
    UIScrollView * sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30 , kMainScreenWidth, kMainScreenHeight - 44 - 30)];
    
    sv.showsVerticalScrollIndicator = NO;
    
    sv.showsHorizontalScrollIndicator = NO;
    
    
    sv.delegate = self;
    sv.pagingEnabled = YES;
    
    sv.backgroundColor = [UIColor redColor];
    sv.contentSize = CGSizeMake(kMainScreenWidth * 3, kMainScreenHeight - 44 - 30);
    [self.view addSubview:sv];
    self.sv = sv;
    
    [self.view addSubview:self.sv];
    
    for (int i = 0; i < 3; i++) {

       RefreshTableView * tableView = [[RefreshTableView alloc]initWithFrame:CGRectMake(kMainScreenWidth * i, 0, kMainScreenWidth, kMainScreenHeight - 64 - 30) style:UITableViewStylePlain];
        
        tableView.tag = kTableViewTag + i;
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        tableView.refreshDelegate =self;
        
        [self.sv addSubview:tableView];
        
        
        NSLog(@"%@", NSStringFromCGRect(tableView.frame));
    }
    
    page = 1;
    [self startHttpRequest:URL_NESLIST categoryID:1 pageIndex:page nums:10];
}
#pragma mark - 网络请求
-(void)startHttpRequest:(NSString *)url categoryID:(NSInteger)categoryID pageIndex:(NSInteger)pageIndex nums:(NSInteger)nums
{
    
    NSString * categoryIDStr = [NSString stringWithFormat:@"%d", categoryID];
    
    NSString * pageIndexStr = [NSString stringWithFormat:@"%d", pageIndex];
    
    NSString * numsStr = [NSString stringWithFormat:@"%d", nums];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:categoryIDStr, @"categoryID", pageIndexStr,@"pageIndex", numsStr, @"nums", nil];
    
    
    NSLog(@"%@", postDict);
    
    NewsTableViewController * weakSelf = self;
    
    __weak RefreshTableView * tableview =(RefreshTableView *) [weakSelf.view viewWithTag:kTableViewTag + self.curPage];
    
    [AFNHttpTools requestWithUrl:url andPostDict:postDict successed:^(NSDictionary *dict) {
        
        NSString * state = [[dict objectForKey:@"json"]  objectForKey:@"state"];
        
        if (state.integerValue == 1) {
            
            NSArray  * list = [[[dict objectForKey:@"json"] objectForKey:@"data"]  objectForKey:@"list"];
            
            NSLog(@"%@", list);
            
            if (![list isKindOfClass:[NSNull class]]) {
                
                for (NSDictionary * d in list) {
                    
                    NewsItem * item = [[NewsItem alloc]init];
                    
                    item.content = [d objectForKey:@"content"];
                    
                    item.mid = [[d objectForKey:@"mid"] integerValue];
                    
                    item.title = [d objectForKey:@"title"];
                    
                    [weakSelf.dataArray addObject:item];
                }
                
                [tableview reloadData];
                
                [tableview endRefresh];
                
            }else{
                
                [tableview endRefresh];
                
                 [SVProgressHUD showErrorWithStatus:dTips_noData];
                
            }
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:dTips_noData];
            
             [tableview endRefresh];
        }
        
    } failed:^(NSError *err) {
        
        [SVProgressHUD showErrorWithStatus:dTips_requestError];
        
         [tableview endRefresh];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * strID = @"ID";
    
    Cell_News * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_News" owner:nil options:nil] lastObject];
    }
    
    
    NewsItem * item = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.titleLbl.text = item.title;
    
    
    [cell.numBtn setTitle:[NSString stringWithFormat:@"%d", indexPath.row + 1] forState:UIControlStateNormal];
    
    NSData *data = [item.content dataUsingEncoding:NSUTF8StringEncoding];
//    NSAttributedString *string = [[NSAttributedString alloc] initWithHTML:data documentAttributes:NULL];


//    cell.detailLbl.attributedString = string;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NewsItem * item = [self.dataArray objectAtIndex:indexPath.row];
    
    NewsDetailViewController * vc =[[NewsDetailViewController alloc]init];
    
    vc.content = item.content;
    vc.myTitle = item.title;
    
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - scrollViewDelegate


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView) {
//        <#statements#>
//    }
//    NSInteger curPage = scrollView.contentOffset.x / kMainScreenWidth;
////    self.pc.currentPage = curPage;
//    self.seg.selectedSegmentIndex = curPage;
////    self.curPage = curPage;
}

@end
