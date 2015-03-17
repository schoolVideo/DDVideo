//
//  AFNHttpTools.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/11.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
typedef void (^RequestSuccessed) (NSDictionary * dict);

typedef void (^RequestFailed) (NSError * err);

#import <Foundation/Foundation.h>

@interface AFNHttpTools : NSObject
///post请求方法1
+(void)requestWithUrl:(NSString *)url andPostDict:(NSDictionary *)postDict successed:(RequestSuccessed)successed failed:(RequestFailed)failed;
///post请求方法2
+(void)requestWithUrl:(NSString *)url successed:(RequestSuccessed)successed failed:(RequestFailed)failed andKeyVaulePairs:(NSString *)firstobj,...NS_REQUIRES_NIL_TERMINATION;

@end
