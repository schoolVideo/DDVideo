//
//  BaoView.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/4.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
@class HMSegmentedControl;
#import <UIKit/UIKit.h>

@interface BaoView : UIView

/**
 
 */
-(id)initWithFrame:(CGRect)frame title:(NSString *)title andAView:(UIView *)aView;

-(void) addSubview:(UIView *)view withTabName:(NSString *)name;
@end
