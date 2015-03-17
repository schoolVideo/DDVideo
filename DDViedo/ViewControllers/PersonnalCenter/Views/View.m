//
//  View.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/3.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "View.h"

@implementation View

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)instanceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"View" owner:nil options:nil] lastObject];

}
@end
