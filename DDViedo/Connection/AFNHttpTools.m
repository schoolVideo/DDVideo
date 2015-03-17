//
//  AFNHttpTools.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/11.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "AFNHttpTools.h"
#import "AFNetworking.h"
@implementation AFNHttpTools


+(NSDictionary *)asmmbleDic:(NSString *)firstObj, ...NS_REQUIRES_NIL_TERMINATION
{
    
    //盛放key的array
    NSMutableArray * keyArray = [NSMutableArray array];
    
    //盛放value的array
    NSMutableArray * valueArray = [NSMutableArray array];
    
    va_list arg_ptr;
    
    va_start(arg_ptr, firstObj);
    
    if (firstObj == nil) {
        
        return nil;
    }
    
    [keyArray addObject:firstObj];
    
    NSString * temp = nil;
    
    int i = 1;
    
    while ((temp = va_arg(arg_ptr, NSString *))) {//Bad_access
        
        //说明
        if (i % 2 == 1) {
            
            [valueArray addObject:temp];
            
        }else{
            
            [keyArray addObject:temp];
        }
        i++;
    }
    va_end(arg_ptr);
    
    if(i % 2 == 0)
    {
        NSLog(@"变长参数的个数是偶数");
        
    }else{
        
        NSLog(@"变长参数的个数是奇数");
        
        return  nil;
    }
    
    NSDictionary * dict = [[NSDictionary alloc]initWithObjects:valueArray forKeys:keyArray];
    
    return dict;
}

+(void)requestWithUrl:(NSString *)url andPostDict:(NSDictionary *)postDict successed:(RequestSuccessed)successed failed:(RequestFailed)failed
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString * newUrl = [URL_BASE stringByAppendingString:url];
    [manager POST:newUrl parameters:postDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"请求结果为:%@", responseObject);
        successed(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failed(error);
    }];
}

+(void)requestWithUrl:(NSString *)url successed:(RequestSuccessed)successed failed:(RequestFailed)failed andKeyVaulePairs:(NSObject *)firstobj,...NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray * keys = [[NSMutableArray alloc]init];
    
    NSMutableArray * values = [[NSMutableArray alloc]init];
    
    va_list arg_ptr;
    
    va_start(arg_ptr, firstobj);
    
    if(nil == firstobj)
    {
        return;
    }
    [keys addObject:firstobj];
    
    NSObject * temp = nil;
    
    NSInteger i  = 1;
    
    while((temp = va_arg(arg_ptr, NSObject *)))
    {
        if (i % 2 == 1)
        {
            [values addObject:temp];
        }else{
            [keys addObject:temp];
        }
        i++;
    }
    if(i % 2 == 1)
    {
        NSLog(@"变长参数的个数是奇数");
        NSLog(@"最后一个参数是%d", i);
        
        return;
    }
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    NSLog(@"%@", postDict);
    
   
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"]; 
    
    NSString * newUrl = [URL_BASE stringByAppendingString:url];

    NSLog(@"请求地址是%@", newUrl);
    
    [manager POST:newUrl parameters:postDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        successed(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failed(error);
    }];

}
@end
