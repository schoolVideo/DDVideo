//
//  MyReChargeViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/5.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
#define kMaxTag 100
#define kTextFieldTag 1000
#import "MyReChargeViewController.h"
#import "MyReChargeItem.h"
#import "MyRechargeFooterView.h"
#import "IQKeyBoardManager.h"
#import "UIViewTool.h"
@interface MyReChargeViewController ()<UITableViewDataSource, UITableViewDelegate , UITextFieldDelegate>
{
    NSMutableArray * dataArray;
}
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation MyReChargeViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [IQKeyBoardManager installKeyboardManager];
    [IQKeyBoardManager enableKeyboardManger];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [IQKeyBoardManager disableKeyboardManager];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    dataArray = [[NSMutableArray alloc]init];
    NSArray * name0 = @[];
    
    NSArray * name1 =  @[@"30元", @"50元", @"100元", @"200元",@"300元", @"500元", @"1000元", @"2000元"];
    
    
    NSArray * name2 = @[@"中国移动", @"中国联通", @"中国电信"];
    NSArray * name3 = @[];
    NSMutableArray * small0 = [[NSMutableArray alloc]init];
    NSMutableArray * small3 = [[NSMutableArray alloc]init];
    NSMutableArray * small1 = [[NSMutableArray alloc]init];
    for (NSString * str in name1) {
        
        MyReChargeItem * item = [[MyReChargeItem alloc]init];
        item.str = str;
        
        [small1 addObject:item];
    }
    
    NSMutableArray * small2 = [[NSMutableArray alloc]init];
    for (NSString * str in name2) {
        
        MyReChargeItem * item = [[MyReChargeItem alloc]init];
        item.str = str;
        
        [small2 addObject:item];
    }
    [dataArray addObject:small0];
    [dataArray addObject:small1];
    [dataArray addObject:small2];
    [dataArray addObject:small3];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(25, 15, kMainScreenWidth - 50, kMainScreenHeight - 44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray * mArr = [dataArray objectAtIndex:section];
    if (mArr.count!= 0) {
        
        MyReChargeItem * item = [[dataArray objectAtIndex:section] objectAtIndex:0];
        
        if (item.isOpen == NO) {
            return 0;
        }else{
            
            return  [[dataArray objectAtIndex:section] count];
        }
        
    }
    
    return [[dataArray objectAtIndex:section] count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    MyReChargeItem * item = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = item.str;
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"t3"]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyReChargeItem * item = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    UITextField * tf = (UITextField *)[self.view viewWithTag:indexPath.section + kTextFieldTag];
    
    tf.text = item.str;
    
     MyReChargeItem * item2 = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:0];
//    item2.isOpen = !item2.isOpen;
    
//    [self.tableView reloadData];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < 3) {
        UITextField * tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth - 50, 44)];
        tf.tag = kTextFieldTag + section;
        tf.borderStyle = UITextBorderStyleLine;
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        tf.background = [UIImage imageNamed:@"t1"];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        lbl.backgroundColor = [UIColor redColor];
        NSArray * arr = @[@"手机号码:", @"充值中心:", @"运营商:"];
        lbl.text = arr[section];
        tf.leftView = lbl;
  
        if (section != 0) {
            
            UIButton * coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            coverBtn.tag = kMaxTag + section;
            coverBtn.frame = CGRectMake(0, 0, kMainScreenWidth - 50, 44);
            [tf addSubview:coverBtn];
            
           [coverBtn addTarget:self action:@selector(tfClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        tf.delegate = self;
        if (section == 0) {
            tf.placeholder = @"请输入手机号码";
        }
        if (section == 1) {
            
            tf.placeholder = @"30元";
        }
        if (section == 2) {
            
            tf.placeholder = @"中国移动";
        }
        return tf;
    }
    else{
        UIButton * btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor redColor];
        [btn  setTitle:@"积分了解" forState:UIControlStateNormal];
        btn.tag = kMaxTag + section;
        btn.frame = CGRectMake(0, 0, kMainScreenWidth - 30, 44);
        [btn addTarget:self action:@selector(tfClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return btn;
    }
}
-(void)tfClick:(UIButton *)btn
{
    NSInteger index = btn.tag - kMaxTag;
    
    if ([[dataArray objectAtIndex:index] count] != 0) {
        
        MyReChargeItem * item = [[dataArray objectAtIndex:index] objectAtIndex:0];
        item.isOpen = !item.isOpen;
        
        [self.tableView reloadData];
        
    }else{
        
        
    }
    
    if (index == 3) {
        
        btn.selected = !btn.selected;
        
        if (btn.selected == YES) {
            
         self.tableView.tableFooterView = [MyRechargeFooterView instanceView];

            [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }else{
            
            self.tableView.tableFooterView = nil;
            
            [self.tableView scrollsToTop];
        }
    
    }
  
}
///递归调用
//+(void)resignView:(UIView *)aView
//{
//    for (UIView * view in aView.subviews) {
//        
//        if ([view isKindOfClass:[UITextField class]]) {
//            
//            UITextField * v = (UITextField *)view;
//            
//            [v resignFirstResponder];
//        }else{
//            
//            [self resignView:view];
//        }
//    }
//}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [[self class] resignView:self.view];
    [UIViewTool cancelKeyBoard:self.view];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [[self class] resignView:self.view];
    [UIViewTool cancelKeyBoard:self.view];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
