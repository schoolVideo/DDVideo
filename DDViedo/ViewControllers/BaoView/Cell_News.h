//
//  Cell_News.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/5.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAttributedTextContentView.h"
#import "DTAttributedTextCell.h"
@interface Cell_News : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *gidImg;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet DTAttributedTextContentView *detailLbl;
@end
