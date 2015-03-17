//
//  NewsDetailViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/5.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "DTAttributedTextCell.h"
#import "WBNoticeView.h"
#import "WBErrorNoticeView.h"

@interface NewsDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) CGSize size;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"资讯详情";

    self.automaticallyAdjustsScrollViewInsets = NO;
  
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 64) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    CGSize size = [self.myTitle boundingRectWithSize:CGSizeMake(kMainScreenWidth - 40, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    
    self.size = size;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView prepareCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        static NSString * strID2 = @"ID2";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID2];
        
        UILabel * la = nil;
        
        if (nil == cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID2];
            
            la = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, kMainScreenWidth - 40, self.size.height + 10)];
            
            la.textAlignment = NSTextAlignmentCenter;
            
            [cell.contentView addSubview:la];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        la.text = self.myTitle;
        
        return cell;
        
    }else{
        
        static NSString * strID1 = @"ID1";
        
        DTAttributedTextCell * cell = [tableView dequeueReusableCellWithIdentifier:strID1];
        
        if (nil == cell) {
            
            cell = [[DTAttributedTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID1];
        }
        
        [cell setHTMLString:self.content];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DTAttributedTextCell * cell =  [self tableView:(UITableView *)tableView prepareCellForRowAtIndexPath:indexPath];
    

    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        return self.size.height + 20;
        
    }
    DTAttributedTextCell * cell = [self tableView:(UITableView *)tableView prepareCellForRowAtIndexPath:indexPath];
    
    return [cell requiredRowHeightInTableView:tableView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
