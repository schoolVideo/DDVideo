//
//  Cell_Gird.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/13.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "Cell_Gird.h"

@implementation Cell_Gird

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor greenColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 1.5)];
        
        self.imgView.image = [UIImage imageNamed:@"1"];
        
        [self.contentView addSubview:self.imgView];

        self.lbl = [[UILabel alloc]init];
        
        self.lbl.frame = CGRectMake(0, CGRectGetMaxY(self.imgView.frame),frame.size.width, frame.size.height - CGRectGetHeight(self.imgView.frame));
        
        self.lbl.backgroundColor = [UIColor redColor];
        
        self.lbl.text = @"电影";
        
        self.lbl.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.lbl];
        
    }
    return self;
}
@end
