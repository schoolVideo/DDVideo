//
//  Cell_Personnal.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/3.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "Cell_Personnal.h"

@implementation Cell_Personnal

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
/*
 layoutSubviews在以下情况下会被调用：
 
 1、init初始化不会触发layoutSubviews
 2、addSubview会触发layoutSubviews
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 4、滚动一个UIScrollView会触发layoutSubviews
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */
-(void)createUI
{
//    self.imgView = [[UIImageView alloc]initWithImage:];
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, CGRectGetHeight(self.frame) / 2.0 - 15, 30, 30)];
    self.imgView.image = [UIImage imageNamed:@"5.jpg"];
    [self.contentView addSubview:self.imgView];
    
    self.lbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 15, CGRectGetMinY(self.imgView.frame), kMainScreenWidth - CGRectGetMaxX(self.imgView.frame) - 15, 30)];
    [self.contentView addSubview:self.lbl];
    self.lbl.text = @"测试";
}

-(void)layoutSubviews
{
    [super layoutSubviews];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
