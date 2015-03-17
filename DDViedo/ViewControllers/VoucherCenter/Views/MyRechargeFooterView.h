//
//  MyRechargeFooterView.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/5.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRechargeFooterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UITextField *useIntegrate;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

+(instancetype)instanceView;
@end
