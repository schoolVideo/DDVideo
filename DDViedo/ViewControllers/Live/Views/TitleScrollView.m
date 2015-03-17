//
//  TitleScrollView.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/3.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
typedef NS_OPTIONS(NSUInteger, TendState) {

    TendStateLeft,
    TendStateMiddle,
    TendStateRight
    
};
#define kPadding 10
#import "TitleScrollView.h"

@interface TitleScrollView ()
{
    CGRect lastFrame;
}
@property (nonatomic, strong) UIView * lastBtn;
@property (nonatomic, strong) UIScrollView * sv;
@end

@implementation TitleScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)arr block:(TitleScrollViewBlock)block
{
    if (self = [super initWithFrame:frame]) {
        
        UIScrollView * sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        sv.backgroundColor = [UIColor whiteColor];
        sv.bounces = NO;
        sv.showsHorizontalScrollIndicator = NO;
        sv.showsVerticalScrollIndicator = NO;
        CGSize size = CGSizeMake(arr.count * kMainScreenWidth / 5.0, 0);
        
        if (size.width < frame.size.width) {
            size.width = frame.size.width;
        }
        sv.contentSize = size;
        
        int i = 0;
        
        for (NSString * name in arr) {
            
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i * kMainScreenWidth / 5, 0, kMainScreenWidth / 5.0, 40 - kPadding)];
            
            [btn setTitle:name forState:UIControlStateNormal];
            
            if (i % 3 == 0) {
                [btn setBackgroundImage:[UIImage imageNamed:@"t1"] forState:UIControlStateNormal];
            }
            if (i % 3 == 1) {
                [btn setBackgroundImage:[UIImage imageNamed:@"t2"] forState:UIControlStateNormal];
            }
            if (i % 3 == 2) {
                [btn setBackgroundImage:[UIImage imageNamed:@"t3"] forState:UIControlStateNormal];
            }
            
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            btn.tag = 100 + i;
            
            [sv addSubview:btn];
            
            i++;
        }
        [self addSubview:sv];
        
        self.sv = sv;
        //默认页码是0
        self.currentPage = 0;
        
        [self addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
        self.block =block;
        
    }
    return self;

}
///KVO iOS大招
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (self.lastBtn == nil) {
        self.lastBtn = [[UIView alloc]init];
        self.lastBtn.backgroundColor = [UIColor grayColor];
        self.lastBtn.alpha = 0.3;
        [self.sv addSubview:self.lastBtn];
    }
    
    NSInteger curPage = [[change objectForKey:@"new"] integerValue];
    
    NSInteger lastPage = [[change objectForKey:@"old"] integerValue];
    
    self.lastBtn.frame = CGRectMake(lastPage * kMainScreenWidth / 5.0, 0, kMainScreenWidth / 5.0, CGRectGetHeight(self.sv.frame));
    if ([keyPath isEqualToString:@"currentPage"]) {
        
        NSLog(@"%@", change);
        
        [UIView animateWithDuration:0.3 animations:^{
            
             self.lastBtn.frame = CGRectMake(curPage * kMainScreenWidth / 5.0, 0, kMainScreenWidth / 5.0, CGRectGetHeight(self.sv.frame));
            
        } completion:^(BOOL finished) {
            
            
            //真正的第几页
            NSInteger index = CGRectGetMinX(self.lastBtn.frame) / ( kMainScreenWidth / 5.0);
            
            NSInteger bigPage = (index) / 5;
            
            
            CGPoint point = self.sv.contentOffset;
            
            point.x = bigPage * self.sv.frame.size.width;
            
            self.sv.contentOffset = point;
            
        }];
    }
}
-(void)btnClick:(UIButton *)button
{
    self.currentPage = button.tag - 100;
    

    self.block(button.tag - 100);
}
-(id)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)arr
{
    if (self = [super initWithFrame:frame]) {
        
        UIScrollView * sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        sv.backgroundColor = [UIColor redColor];
        sv.bounces = NO;
        sv.showsHorizontalScrollIndicator = NO;
        sv.showsVerticalScrollIndicator = NO;
        CGSize size = CGSizeMake(arr.count * kMainScreenWidth / 5.0, 0);
        
        if (size.width < frame.size.width) {
            size.width = frame.size.width;
        }
        sv.contentSize = size;
        
        int i = 0;
        
        for (NSString * name in arr) {
            
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i * kMainScreenWidth / 5, 0, kMainScreenWidth / 5.0, 40)];
            
//            btn.backgroundColor = [UIColor purpleColor];
            
            btn.tag = 100 + i;
            
            [btn setTitle:name forState:UIControlStateNormal];
            
            [sv addSubview:btn];
            
            i++;
        }
        [self addSubview:sv];
    }
    return self;
}
@end
