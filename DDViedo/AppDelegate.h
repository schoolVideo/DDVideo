//
//  AppDelegate.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
///  返回app代理
+(instancetype)shareInstance;

@end

