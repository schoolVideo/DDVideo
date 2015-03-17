//
//  PrivillegelItem.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/16.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrivillegelItem : NSObject

@property (nonatomic, strong) NSString * contentID;

@property (nonatomic, strong) NSString * imgUrl;

@property (nonatomic, strong) NSString * shopName;

@property (nonatomic, strong) NSString * titleName;

@property (nonatomic, strong) NSString * content;

@property (nonatomic, strong) NSString * tureMoney;

@property (nonatomic, strong) NSString * marketMoney;

@property (nonatomic, strong) NSString * browseCount;

@property (nonatomic, strong) NSString * endDate;

@property (nonatomic, strong) NSString * address;

@property (nonatomic, strong) NSString * phoneNum;

@property (nonatomic, strong) NSString * categoryName;

-(CGFloat)height1;

-(CGFloat)height2;

-(CGFloat)height5;
@end
