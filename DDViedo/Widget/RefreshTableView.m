//
//  RefreshTableView.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/3.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "RefreshTableView.h"
@implementation RefreshTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerBlock:(tableFooterRefresh)headerBlock footerBlock:(tableFooterRefresh)footerBlock
{
    if (self = [super initWithFrame:frame style:style]) {
        
        [self setupRefresh:self];
        self.headerBlock = headerBlock;
        self.footerBlock = footerBlock;
    }
    
    return self;
    
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
          [self setupRefresh:self];
    }
    return self;
}

-(void)setMyHeaderBlock:(tableHeaderRefresh)headerBlock andMyFooterRefreshBlock:(tableFooterRefresh)footerBlock
{
  
    self.headerBlock = headerBlock;
    self.footerBlock = footerBlock;

}

/*
 增加下拉和上拉刷新
 **/
- (void)setupRefresh:(UITableView *)newTableView
{
}
-(void)footerRefreshMethod
{
    if ([self.refreshDelegate respondsToSelector:@selector(footerRefresh)]) {
        
        [self.refreshDelegate footerRefresh];
    }
}
-(void)headerRefreshMethod
{
    if ([self.refreshDelegate respondsToSelector:@selector(footerRefresh)]) {
        
        [self.refreshDelegate headerRefresh];
    }
}

-(void)endRefresh
{
    [self headerEndRefreshing];
    [self footerEndRefreshing];
}
@end
