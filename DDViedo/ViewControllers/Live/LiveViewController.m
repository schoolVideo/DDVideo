//
//  LiveViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
#define kMaxTag 1000
static NSString  * collectionID = @"collectionID";
#import "LiveViewController.h"
#import "AsyncScrollView.h"
#import "Cell_Demand.h"
#import "TitleScrollView.h"
#import "HMSegmentedControl.h"
#import "UIColor+AddColor.h"
#import "Cell_Personnal.h"
#import "InterfaceManager.h"
#import "Cell_Live.h"
#import "Cell_LiveColleciton.h"
#import "MoreLiveTableViewController.h"
#import "UIViewTool.h"
#import "GridCateGoryViewController.h"
@interface LiveViewController ()<UITableViewDataSource, UITableViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) NSInteger segIndex;
@property (nonatomic, strong) UIScrollView * bgScrollView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * titleArr;
@property (nonatomic, strong) TitleScrollView * titleSV;

@property (nonatomic, strong) UITableView * liveTableView;

@property (nonatomic, strong) UITableView * vipTableView;

@property (nonatomic, strong) UIView * mainView;
@end

@implementation LiveViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.dataArray = [[NSMutableArray alloc]init];
    self.titleArr = [[NSMutableArray alloc] init];
    [self.dataArray addObjectsFromArray:[InterfaceManager liveVCData]];
    
    [self createSeg];
    
    [self createUI];
    
    [self createLiveTable];
    
    [self createVIPVideo];
}

-(void)createVIPVideo
{
    self.vipTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - 49) style:UITableViewStylePlain];
    self.vipTableView.delegate = self;
    self.vipTableView.dataSource = self;
    [self.view addSubview:self.vipTableView];
    self.vipTableView.tag = kMaxTag;
}

///创建直播tableView并且把它放在self.view的最上部
-(void)createLiveTable
{
    self.liveTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 49 - 44) style:UITableViewStylePlain];
    self.liveTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.liveTableView.delegate = self;
    self.liveTableView.dataSource = self;
    [self.view addSubview:self.liveTableView];
//    [self.view sendSubviewToBack:self.liveTableView];
}
#pragma mark - 创建segment
-(void)createSeg
{
    NSArray * images = @[@"t1", @"t2", @"t3"];
    
    NSMutableArray * imageArr = [[NSMutableArray alloc]init];
    
    for (NSString * str in images) {
        
        UIImage * img = [UIImage imageNamed:str];
        
        [imageArr addObject:img];
        
    }
    
    NSArray * name = @[@"直播", @"点播", @"VIP"];
    
    HMSegmentedControl * seg = [[HMSegmentedControl alloc]initWithSectionTitles:name];
    
    seg.layer.borderWidth = 2;
    
    seg.layer.borderColor = [UIColor blueColor].CGColor;
    
    seg.frame = CGRectMake(0, 0, kMainScreenWidth - 80, 30);
    
    seg.selectionStyle = HMSegmentedControlSelectionStyleBox;
    
    [seg setFont:[UIFont systemFontOfSize:14]];
    
    __weak LiveViewController * weakSelf = self;
    
    [seg setIndexChangeBlock:^(NSInteger index) {
        
         weakSelf.segIndex = index;
        
        if (index == 0) {
            
            [weakSelf.view bringSubviewToFront:self.liveTableView];
            [weakSelf.liveTableView reloadData];
        }else if(index == 1){
            
//            [weakSelf.view sendSubviewToBack:self.collectionView];
//            [weakSelf.view bringSubviewToFront:self.collectionView];
//            [weakSelf.view bringSubviewToFront:self.titleSV];
            [weakSelf.view bringSubviewToFront:weakSelf.mainView];
              [weakSelf.collectionView reloadData];
        }else{
//            [weakSelf.vipTableView sendSubviewToBack:self.vipTableView];
            [weakSelf.view bringSubviewToFront:self.vipTableView];
            [weakSelf.vipTableView reloadData];
        }
        
       

      
        
    }];
    self.navigationItem.titleView = seg;
}

-(void)btnClick:(UIButton *)btn
{
    GridCateGoryViewController * gridVC = [[GridCateGoryViewController alloc]init];
    [self.navigationController pushViewController:gridVC animated:YES];
}

-(void)createUI
{
    self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - 49)];
    
    self.mainView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.mainView];
    
    NSArray * titleArr = @[@"精选", @"电视剧", @"电影", @"综艺", @"好莱坞",@"精选", @"电视剧", @"电影", @"综艺", @"好莱坞"];
    [self.titleArr addObjectsFromArray:titleArr];
    
    __weak LiveViewController * weakSelf = self;
    
    TitleScrollView * tv = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth - kMainScreenWidth / 5, 40) andTitleArr:self.titleArr block:^(NSInteger index) {
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        
        [UIView animateWithDuration:0.3 animations:^{
             [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }];

    }];
    self.titleSV = tv;
//    [self.view addSubview:tv];
    [self.mainView addSubview:self.titleSV];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(CGRectGetMaxX(self.titleSV.frame), 0, kMainScreenWidth / 5, 30);
//    [self.view addSubview:btn];
    [self.mainView addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kMainScreenWidth, kMainScreenHeight - 44 - 49 - CGRectGetHeight(tv.frame));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tv.frame), kMainScreenWidth, kMainScreenHeight - 44 - 49 - CGRectGetHeight(tv.frame)) collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"Cell_LiveColleciton" bundle:nil] forCellWithReuseIdentifier:collectionID];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.bounces = NO;
//    [self.view addSubview:self.collectionView];
    [self.mainView addSubview:self.collectionView];
}
#pragma mark - 创建点播collectionView的tableview的HeaderView
-(UIView *)createHeaderView
{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
    UISearchBar * sb = [[UISearchBar alloc]initWithFrame:CGRectMake(15, 5, kMainScreenWidth - 40, 30)];
    sb.searchBarStyle = UISearchBarStyleMinimal;
    [headerView addSubview:sb];
    sb.placeholder = @"搜索";
    return headerView;
}

///加载可见行
-(void)loadScreenIndex
{
    NSArray * arr = [self.collectionView indexPathsForVisibleItems];
    
    for (NSIndexPath * index in arr) {
        
        NSLog(@"%d", index.row);
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        
        NSInteger index = scrollView.contentOffset.x / self.collectionView.frame.size.width;
        NSLog(@"--------%d", index);
        
        self.titleSV.currentPage = index;
    }
    
    [UIViewTool cancelKeyBoard:self.view];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segIndex == 0) {
        
        NSString * strID = @"Cell_Live_ID";
        
        Cell_Live * cell = [tableView dequeueReusableCellWithIdentifier:strID];
        
        if (nil == cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_Live" owner:nil options:nil] lastObject];
        }
        
        cell.imgView.image = [UIImage imageNamed:@"1.jpg"];
        
        cell.lbl.text = [self.dataArray objectAtIndex:indexPath.row];
        
        return cell;
        
    }
        NSString * strID = @"Cell_Demand_ID";
        
        Cell_Demand * cell = [tableView dequeueReusableCellWithIdentifier:strID];
        
        if (nil == cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_Demand" owner:self options:nil] lastObject];
        }
        
        
        return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segIndex == 0) {
        
        return 80;
        
    }
    return 175 ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"被选中了");
}
#pragma mark - uicolleciotndelegate & datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_LiveColleciton * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame)) style:UITableViewStylePlain];
    
    tableView.tableHeaderView = [self createHeaderView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [cell addSubview:tableView];
    
    return cell;
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


@end
