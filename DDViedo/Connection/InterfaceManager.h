//
//  InterfaceManager.h
//  SB03
//
//  Created by 赵 冰冰 on 15/2/9.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface InterfaceManager : NSObject

///单例调用方法
//+(instancetype)shareInstance;

///最常用的假数据
+(NSArray *)familyFontArray;

///左边菜单列表数据
+(NSArray *)leftVCDataArr;

///右菜单
+(NSArray *)rightVCDataArr;

+(NSArray *)num_1_1_1;

+(NSArray *)personVCData;

+(NSArray *)liveVCData;
@end
