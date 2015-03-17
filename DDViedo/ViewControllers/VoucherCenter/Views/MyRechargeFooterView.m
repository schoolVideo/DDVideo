//
//  MyRechargeFooterView.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/5.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "MyRechargeFooterView.h"

@implementation MyRechargeFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)instanceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MyRechargeFooterView" owner:nil options:nil] lastObject];
}
@end
