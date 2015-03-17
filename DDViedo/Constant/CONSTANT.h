//
//  CONSTANT.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#ifndef DDViedo_CONSTANT_h
#define DDViedo_CONSTANT_h

#define dTips_connectionError @"网络连接错误，请稍候重试~"
#define dTips_requestError @"请求错误"
#define dTips_timeOut @"请求超时"
#define dTips_stateFail @"操作失败，请稍候重试~"
#define dTips_noData @"数据为空~"
#define dTips_noMoreData @"没有更多数据了"
#define dTips_parseError @"解析错误"
#define dTips_uploadError @"头像上传失败"
#define dTips_uploadSuccess @"头像上传成功"
#define dTip_loading @"正在加载..."
#define dTips_changeSuccess @"修改成功"
#define dTips_changeFailed  @"修改失败"
#define dTips_quitSuccess   @"注销成功"

#define   kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define   kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define   kRatio [UIScreen mainScreen].bounds.size.width / 320.0

#define URL_TEST_MOVIE @"http://tv.sohu.com/20131202/n391143291.shtml?txid=b88fafa04634e028b94b84d63b23b53f"

#define URL_BASE @"http://119.254.108.212/video/clientapi.php/"

#define URL_NESLIST @"coupons/getNewsList" //新闻资讯
#define URL_PRIVILEAGE @"coupons/privilegeList"//惠生活
#define URL_PRIVILEAGE_CATEGORY @"coupons/categoryList"//惠生活分类
/*
 typeof(int *) a,b;
 等价于：
 int *a,*b;
 */

#define WEAK_SELF(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define kNotNull(obj)  [obj isEqual:[NSNull null]]
#import "SVProgressHUD.h"
#endif
