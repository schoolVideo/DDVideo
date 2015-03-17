//
//  PrivillegeLifeViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
#define kMaxTag 100
#import "PrivillegeLifeViewController.h"
#import "Cell_Privillegel.h"
#import "RefreshTableView.h"
#import "UIPopoverListView.h"
#import "HMSegmentedControl.h"
#import "UIPopoverListView.h"
#import "PrivillegelDetailViewController.h"
#import "AFNHttpTools.h"
#import "PrivillegelItem.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface PrivillegeLifeViewController ()<UITableViewDataSource, UITableViewDelegate, UIPopoverListViewDelegate, UIPopoverListViewDataSource>
{

}
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UIPopoverListView * listView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableArray * categoryArray;//分类列表
@property (nonatomic, strong) NSString * currentCategory;//当前选中的分类
@property (nonatomic, assign) NSInteger curPage;
@end

@implementation PrivillegeLifeViewController
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
#pragma mark - popoverListDelegate
- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * strID = @"ID";
    UITableViewCell * cell = [popoverListView.listView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    NSDictionary * d = [self.categoryArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [d objectForKey:@"name"];
    
    return cell;
}

- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    [popoverListView dismiss];
    
    NSDictionary * dict = [self.categoryArray objectAtIndex:indexPath.row];
    
    NSString * categoryID = [dict objectForKey:@"categoryID"];
    
    self.currentCategory = categoryID;
    
    [self httpRequestWithUrl:URL_PRIVILEAGE cateGoryID:self.currentCategory pageIndex:1 numbers:@"10"];
    
}
- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return self.categoryArray.count;
}


-(void)btnClick:(UIButton *)btn
{
    NSInteger index = btn.tag - kMaxTag;
    
    CGRect frame = self.listView.frame;
    
    frame.origin.x = index * kMainScreenWidth / 2.0;
    
    self.listView.frame = frame;
    
    [self.listView show];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc]init];
    self.categoryArray = [[NSMutableArray alloc]init];
    self.title = @"惠生活";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray * name = @[@"美食分类", @"智能排序"];
    
    NSArray * imgs = @[@"t1", @"t3"];
    
    for (NSInteger i = 0; i < name.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:name[i] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(kMainScreenWidth / 2.0 * i, 0, kMainScreenWidth / 2.0, 35);
        
        [btn setBackgroundImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        
        btn.tag = kMaxTag + i;
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIPopoverListView * popover = [[UIPopoverListView alloc]initWithFrame:CGRectMake(0, 35, kMainScreenWidth / 5.0, kMainScreenHeight / 2)];
    popover.delegate = self;
    popover.datasource = self;
    self.listView = popover;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, kMainScreenWidth, kMainScreenHeight - 64 - 49 - 35) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.curPage = 1;
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        
        [weakSelf.dataArray removeAllObjects];
        [weakSelf httpRequestWithUrl:URL_PRIVILEAGE cateGoryID:weakSelf.currentCategory pageIndex:1 numbers:@"10"];
        
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        
        weakSelf.curPage++;
        
        [weakSelf httpRequestWithUrl:URL_PRIVILEAGE cateGoryID:weakSelf.currentCategory pageIndex:weakSelf.curPage numbers:@"10"];
        
    }];
    
    //请求分类
    [AFNHttpTools requestWithUrl:URL_PRIVILEAGE_CATEGORY andPostDict:nil successed:^(NSDictionary *dict) {
        
        NSArray * list = [[[dict objectForKey:@"json"] objectForKey:@"data"] objectForKey:@"list"];

        [weakSelf.categoryArray addObjectsFromArray:list];
        
        NSLog(@"%d", weakSelf.categoryArray.count);
        
        NSDictionary * d = list[0];
    
        weakSelf.currentCategory = [d objectForKey:@"categoryID"];
        
        [weakSelf httpRequestWithUrl:URL_PRIVILEAGE cateGoryID:[d objectForKey:@"categoryID"] pageIndex:1 numbers:@"10"];
        
        CGRect frame = weakSelf.listView.frame;
        frame.size.height = 44 * weakSelf.categoryArray.count;
        weakSelf.listView.frame = CGRectMake(0, 40, kMainScreenWidth / 2, frame.size.height);
        
        NSLog(@"%@", NSStringFromCGRect(weakSelf.listView.frame));
        [weakSelf.listView reloadData];
        
        
    } failed:^(NSError *err) {
        
        [SVProgressHUD showErrorWithStatus:dTips_requestError];
        
    }];
}


-(void)httpRequestWithUrl:(NSString *)url cateGoryID:(NSString *)mID pageIndex:(NSInteger)pageIndex numbers:(NSString *)numbers
{
    
    NSString * pageStr = [NSString stringWithFormat:@"%d", pageIndex];
    
    NSDictionary * postDict = [[NSDictionary alloc]initWithObjectsAndKeys:mID, @"categoryID", pageStr, @"pageIndex", numbers, @"nums", nil];
    
    __weak PrivillegeLifeViewController * weakSelf = self;
    
    [AFNHttpTools requestWithUrl:URL_PRIVILEAGE andPostDict:postDict successed:^(NSDictionary *dict) {
        
        NSString * state = [[dict objectForKey:@"json"] objectForKey:@"state"];
        
        if (state.intValue == 1) {
            
            NSArray * list = [[[dict objectForKey:@"json"] objectForKey:@"data"] objectForKey:@"list"];
            
            NSLog(@"%@", list);
            
            if (![list isKindOfClass:[NSNull class]]) {
                
                for (NSDictionary * d in list) {
                    
                    PrivillegelItem * item = [[PrivillegelItem alloc]init];
                    
                    item.contentID = [d objectForKey:@"contentID"];
                    
                    if ([[d objectForKey:@"imgUrl"] isKindOfClass:[NSNull class]]) {
                     
                        item.imgUrl = @"";
                    }else{
                        
                        item.imgUrl = [d objectForKey:@"imgUrl"];
            
                    }
                    
                    
                    item.shopName = [d objectForKey:@"shopName"];
                    
                    item.titleName = [d objectForKey:@"titleName"];
                    
                    item.content = [d objectForKey:@"content"];
                    
                    item.tureMoney = [d objectForKey:@"trueMoney"];
                    
                    NSLog(@"%@", [d objectForKey:@"tureMoney"]);
    
                    item.marketMoney = [d objectForKey:@"marketMoney"];
                    
                    item.browseCount = [d objectForKey:@"browseCount"];
                    
                    item.endDate = [d objectForKey:@"endDate"];
                    
                    item.address = [d objectForKey:@"address"];
                    
                    item.phoneNum = [d objectForKey:@"phoneNum"];
                    
                    item.categoryName = [d objectForKey:@"categoryName"];
                    
                    [weakSelf.dataArray addObject:item];
                    
                }
                
                
                [weakSelf.tableView reloadData];
                
                [weakSelf.tableView.header endRefreshing];
                
                [weakSelf.tableView.footer endRefreshing];


            }else{
                
                weakSelf.tableView.footer.state = MJRefreshFooterStateNoMoreData;
                [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
            }
                
            
        }
        
    } failed:^(NSError *err) {
        
        [SVProgressHUD showErrorWithStatus:dTips_requestError];
        
        [weakSelf.tableView.header endRefreshing];
        
        [weakSelf.tableView.footer endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    Cell_Privillegel * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (nil == cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_Privillegel" owner:nil options:nil] lastObject];
    }
    
    PrivillegelItem * item = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.seeCountLbl.text = item.browseCount;
    
    cell.pricousPrice.text = item.marketMoney;
    
    cell.curPrice.text = item.tureMoney;
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:[UIImage imageNamed:@"1"]];
    
    cell.titleLbl.text = item.titleName;
    
    cell.detailLbl.text = item.content;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrivillegelDetailViewController * detailVC = [[PrivillegelDetailViewController alloc]initWithNibName:@"PrivillegelDetailViewController" bundle:nil];
    detailVC.item = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
