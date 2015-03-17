//
//  Cell_PPScroll.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/28.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
#define kPodding 15
#import "Cell_PPScroll.h"

@implementation Cell_PPScroll

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createContentView];
    }
    return self;
}
-(void)createContentView
{
    UIScrollView * s = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 75 * kRatio)];
    s.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:s];
    s.scrollEnabled = YES;
//    s.pagingEnabled = YES;
    s.bounces = NO;
    s.showsVerticalScrollIndicator = NO;
    s.showsHorizontalScrollIndicator = NO;
    s.contentSize = CGSizeMake(kMainScreenWidth * 2, 75 * kRatio);
    CGFloat width = (s.frame.size.width - 4 * kPodding) / 3;
    self.scrollView = s;
    self.btn1 = [[UIButton alloc]init];
    self.btn2 = [[UIButton alloc]init];
    self.btn3 = [[UIButton alloc]init];
    self.btn4 = [[UIButton alloc]init];
    self.btn5 = [[UIButton alloc]init];
    self.btn6 = [[UIButton alloc]init];
    
    NSArray * arr = @[self.btn1, self.btn2, self.btn3, self.btn4, self.btn5, self.btn6];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        if (i == 0) {
            
            UIButton * btn = arr[i];
            btn.backgroundColor = [UIColor yellowColor];
            [btn setBackgroundImage:[UIImage imageNamed:@"10.jpg"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(kPodding, 0, width, self.scrollView.frame.size.height);
            [self.scrollView addSubview:btn];
        }else{
            
            CGFloat space = kPodding;
            
            if (i == 3) {
                
                space = space * 2;
                
            }
            
            UIButton * lastBtn = arr[i - 1];
            
            UIButton * currentBtn = arr[i];
            
            currentBtn.frame = CGRectMake(CGRectGetMaxX(lastBtn.frame) + space, 0, width, self.scrollView.frame.size.height);
            currentBtn.backgroundColor = [UIColor yellowColor];
            [currentBtn setBackgroundImage:[UIImage imageNamed:@"10.jpg"] forState:UIControlStateNormal];
            [self.scrollView addSubview:currentBtn];
            
        }
    }

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
