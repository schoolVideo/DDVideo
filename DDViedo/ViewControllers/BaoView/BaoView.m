//
//  BaoView.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/4.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "BaoView.h"
#import "HMSegmentedControl.h"

@interface BaoView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * sv;

@property (nonatomic, strong) HMSegmentedControl * ctrl;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableArray * viewsArray;
@end

@implementation BaoView


-(id)initWithFrame:(CGRect)frame title:(NSString *)title andAView:(UIView *)aView
{
    if (self = [super initWithFrame:frame]) {
        
        self.dataArray = [[NSMutableArray alloc]init];
        
        self.viewsArray = [[NSMutableArray alloc]init];
        
//        [self.viewsArray addObject:aView];
        
        [self.dataArray addObject:title];
        
        HMSegmentedControl * seg = [[HMSegmentedControl alloc]initWithSectionTitles:self.dataArray];
        
        seg.layer.borderWidth = 2;
        
        seg.layer.borderColor = [UIColor blueColor].CGColor;
        
        seg.frame = CGRectMake(0, 0, frame.size.width, 30);
        
        seg.backgroundColor = [UIColor redColor];
        
//        seg.textColor = [UIColor blackColor];
        
        seg.selectionStyle = HMSegmentedControlSelectionStyleBox;
        
//        [seg setFont:[UIFont systemFontOfSize:14]];
        
        __weak BaoView * weakSelf = self;
        
        [seg setIndexChangeBlock:^(NSInteger index) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
               CGPoint point = weakSelf.sv.contentOffset;
                
                point.x = index * CGRectGetWidth(weakSelf.sv.frame);
                
                weakSelf.sv.contentOffset = point;
                
            }];
    
        }];
        
        [self addSubview:seg];
        
        self.ctrl = seg;
        
        self.sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(seg.frame), frame.size.width, frame.size.height - CGRectGetHeight(seg.frame))];
        self.sv.backgroundColor = [UIColor redColor];
        self.sv.bounces = NO;
        self.sv.pagingEnabled = YES;
        self.sv.contentSize = CGSizeMake(CGRectGetWidth(self.sv.frame), CGRectGetHeight(self.sv.frame));
        self.sv.delegate = self;
        self.sv.backgroundColor = [UIColor purpleColor];
        [self addSubview:self.sv];
        
        aView.frame = CGRectMake(0, 0, CGRectGetWidth(self.sv.frame), CGRectGetHeight(self.sv.frame));
        [self.sv addSubview:aView];
    }
    return self;
}
-(void)addSubview:(UIView *)view withTabName:(NSString *)name
{
    CGSize size = self.sv.contentSize;
    size.width += self.sv.frame.size.width;
    self.sv.contentSize = size;
    view.frame = CGRectMake(size.width - self.sv.frame.size.width, 0, self.sv.frame.size.width, self.sv.frame.size.height);
    [self.dataArray addObject:name];
    
    self.ctrl.sectionTitles = self.dataArray;
    
    [self.sv addSubview:view];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        NSInteger curPage = self.sv.contentOffset.x / CGRectGetWidth(self.sv.frame);
        self.ctrl.selectedSegmentIndex = curPage;
    }];
}
@end
