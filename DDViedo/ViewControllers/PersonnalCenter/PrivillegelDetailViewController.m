//
//  PrivillegelDetailViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/9.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
  static  NSString * strID = @"ID";
#import "PrivillegelDetailViewController.h"
#import "PrivillegelItem.h"
@interface PrivillegelDetailViewController ()

@end

@implementation PrivillegelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"惠生活详情";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:strID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 3;
    }
    if (section == 1) {
        
        return 1;
    }
    if (section == 2) {
        return 2;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 100;
    }
    if (indexPath.row == 1 && indexPath.section == 0) {
        
        return 130;
    }
    if (indexPath.row == 2 && indexPath.section == 0) {
        
        return 44;
    }
    //地理位置
    if (indexPath.row == 0 && indexPath.section == 1) {
        
        return [self.item height2] + 10;
    }
    if (indexPath.row == 0 && indexPath.section == 2) {
        
        return 60;
    }
    if (indexPath.row ==1 && indexPath.section == 2) {
        
        return 100;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = nil;
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.imageView.image = [UIImage imageNamed:@"1.jpg"];
        cell.textLabel.text = @"好吃的";
        cell.detailTextLabel.text = @"蛋糕";
    }
    if (indexPath.row == 1 && indexPath.section == 0) {
        
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    }
    if (indexPath.row == 2 && indexPath.section == 0) {
        
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = @"18622227777";
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        UILabel * la = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kMainScreenWidth - 30, [self.item height2])];
        la.backgroundColor = [UIColor redColor];
        la.text = self.item.address;
        [cell addSubview:la];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = @"时";
    }
    if (indexPath.row == 1 && indexPath.section == 2) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = @"美闻披萨";
        
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



@end
