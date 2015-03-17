//
//  RefreshTableView.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/3.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

@protocol RefreshTableViewDelegate <NSObject>

@required

-(void)headerRefresh;

-(void)footerRefresh;

@end

typedef void (^tableFooterRefresh)(void);
typedef void (^tableHeaderRefresh)(void);
#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface RefreshTableView : UITableView

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerBlock:(tableFooterRefresh)headerBlock footerBlock:(tableFooterRefresh)footerBlock;
@property (nonatomic, copy)tableFooterRefresh footerBlock;
@property (nonatomic, copy)tableHeaderRefresh headerBlock;
@property (nonatomic, weak) id <RefreshTableViewDelegate> refreshDelegate;
///结束刷新
-(void)endRefresh;
@end
