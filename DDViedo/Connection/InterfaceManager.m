//
//  InterfaceManager.m
//  SB03
//
//  Created by 赵 冰冰 on 15/2/9.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "InterfaceManager.h"

//static InterfaceManager * manager = nil;

@implementation InterfaceManager

//+(id)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        manager = [super allocWithZone:zone];
//        
//    });
//    
//    return manager;
//}
//
//+(instancetype)shareInstance
//{
//    if (manager == nil) {
//        
//        manager = [[InterfaceManager alloc]init];
//    }
//    
//    return manager;
//}

///字体
+(NSArray *)familyFontArray
{
    return [UIFont familyNames];
}

///左菜单
+(NSArray *)leftVCDataArr
{
    NSArray * arr = @[@"    首页", @"    校园TV", @"    咨询", @"    点击通话", @"    VOIP", @"    充值中心", @"    当前活动", @"     惠生活",@"    首页", @"    校园TV", @"    咨询", @"    点击通话", @"    VOIP", @"    充值中心", @"    当前活动", @"     惠生活",@"    首页", @"    校园TV", @"    咨询", @"    点击通话", @"    VOIP", @"    充值中心", @"    当前活动", @"     惠生活",@"    首页", @"    校园TV", @"    咨询", @"    点击通话", @"    VOIP", @"    充值中心", @"    当前活动", @"     惠生活",@"    首页", @"    校园TV", @"    咨询", @"    点击通话", @"    VOIP", @"    充值中心", @"    当前活动", @"     惠生活",@"    首页", @"    校园TV", @"    咨询", @"    点击通话", @"    VOIP", @"    充值中心", @"    当前活动", @"     惠生活",@"    首页", @"    校园TV", @"    咨询", @"    点击通话", @"    VOIP", @"    充值中心", @"    当前活动", @"     惠生活"];

    return arr;
    
}

///右菜单
+(NSArray *)rightVCDataArr
{
    NSArray * arr = @[@"我的资料", @"安全中心", @"我的收藏", @"我要充值", @"我的积分"];
    
    return arr;
}
+(NSArray *)num_1_1_1
{
    NSArray * arr = @[@"我的资料", @"安全中心", @"我的收藏", @"我要充值", @"我的积分"];
    
    return arr;
}
+(NSArray *)personVCData
{
    NSArray * arr1 = @[@"我的资料", @"安全中心"];
    NSArray * arr2 = @[@"我的收藏", @"我要充值", @"软件更新"];
    NSArray * arr3 = @[arr1, arr2];
    return arr3;
}
+(NSArray *)liveVCData
{
    NSArray * arr = @[@"东方卫视", @"深圳卫视", @"广东卫视",@"旅游卫视", @"东方卫视", @"深圳卫视", @"广东卫视",@"旅游卫视"];
    return arr;
}
@end
