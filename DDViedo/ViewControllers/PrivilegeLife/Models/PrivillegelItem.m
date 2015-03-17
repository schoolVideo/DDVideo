//
//  PrivillegelItem.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/16.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "PrivillegelItem.h"

@implementation PrivillegelItem

-(CGFloat)height1
{
   CGRect frame = [self.categoryName boundingRectWithSize:CGSizeMake(kMainScreenWidth - 100, 100000) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    return frame.size.height;
}

-(CGFloat)height2
{
    CGRect frame = [self.address boundingRectWithSize:CGSizeMake(kMainScreenWidth - 30, 100000) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    return frame.size.height;
}
-(CGFloat)height5
{
    CGRect frame = [self.content boundingRectWithSize:CGSizeMake(kMainScreenWidth - 20, 100000) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    return frame.size.height;
}
@end
