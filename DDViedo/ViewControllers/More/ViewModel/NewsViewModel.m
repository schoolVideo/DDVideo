//
//  NewsViewModel.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/11.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "NewsViewModel.h"
#import "NewsItem.h"
#import "AFNHttpTools.h"
@implementation NewsViewModel


-(NSMutableArray *)sendItemWithNums:(NSInteger)nums pageIndex:(NSInteger)pageIndex categoryID:(NSInteger)categoryID url:(NSString *)url
{
//    @"nums", @"10", @"pageIndex", @"1", @"categoryID", @"1", nil]
    
    NSString * newNum = [NSString stringWithFormat:@"%d", nums];
    
    NSString * newPage = [NSString stringWithFormat:@"%d", pageIndex];
    
    NSString * newCategoryID = [NSString stringWithFormat:@"%d", newCategoryID];
    
    NSDictionary * post = [NSDictionary dictionaryWithObjectsAndKeys:newNum, @"nums", newPage, @"pageIndex", categoryID, newCategoryID, nil];
    
    [AFNHttpTools requestWithUrl:url andPostDict:post successed:^(NSDictionary *dict) {
        
        NSArray * list = [[[dict objectForKey:@"json"] objectForKey:@"data"] objectForKey:@"list"];

        for (NSDictionary * d in list) {
            
            
        }
        
    } failed:^(NSError *err) {
        
    }];
    
    return nil;
}

@end
