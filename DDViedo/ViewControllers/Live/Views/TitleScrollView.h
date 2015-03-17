//
//  TitleScrollView.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/3.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.

typedef void (^TitleScrollViewBlock) (NSInteger index);
#import <UIKit/UIKit.h>

@interface TitleScrollView : UIView

@property (nonatomic, copy) TitleScrollViewBlock block;

@property (nonatomic, assign) NSInteger currentPage;//当前页码 kvo
-(id)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)arr block:(TitleScrollViewBlock)block;

@end
