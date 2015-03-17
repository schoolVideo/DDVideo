//
//  CurrentActViewController.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/11.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "CurrentActViewController.h"
#import "ASIHTTPRequest.h"
#import "NewsItem.h"
#import "RTLabel.h"
#import "AFNHttpTools.h"
#import "DTCoreText.h"
@interface CurrentActViewController ()<ASIHTTPRequestDelegate,UITableViewDataSource, UITableViewDelegate>
{
//    DTAttributedLabel * lbl;
    DTAttributedTextView * view;
}
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) DTAttributedTextCell * cell;

@end

@implementation CurrentActViewController

@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DTAttributedTextCell * cell = [[DTAttributedTextCell alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    
    NSLog(@"%@", self.content);
    
    [cell setHTMLString:self.content];
    [self.view addSubview:cell];
    NSLog(@"%@", NSStringFromCGRect(cell.frame));

}

-(void)createRTLabel
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    RTLabel * rtLbl = [[RTLabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 200)];
    //    rtLbl.backgroundColor = [UIColor redColor];
    //    [rtLbl setText:@"<span>每年的正月都会出去走走，看看其他地方的年味，今年和大舅哥一家约好两车八人自驾平遥，一路走走停停寻找那缺失的年味。平遥很早就说要去的一个地方，但总总原因一直没去成，今年说了很多个地方，最后决定去平遥。</span><div><span><br /></span></div><div><span>初四早上七点多起来收拾完毕就开始要准备出发了，不过因为大舅哥一家也要去，等吧，一等就到九点多了还没开始走，呵呵，没办法，加满油到跳枪，大概二百三十元左右，小里程表清零，找大嘴拿了两个手台想的路上用，最后才知道最没用的就是这两个手台，帕萨特和炫丽，不是一个档次，一路上两车相距太远呼不着啊</span></div><div><div><table><tbody><tr><th><div>"];
    //
    //    [self.view addSubview:rtLbl];
    RTLabel * rtLabel = [[RTLabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    //    CGSize optimumSize = [self.rtLabel optimumSize];
    //    CGRect frame = [self.rtLabel frame];
    //    frame.size.height = (int)optimumSize.height+20; // +5 to fix height issue, this should be automatically fixed in iOS5
    //
    //    [self.rtLabel setFrame:frame];
    //    self.content =@"<span>每年的正月都会出去走走，看看其他地方的年味，今年和大舅哥一家约好两车八人自驾平遥，一路走走停停寻找那缺失的年味。平遥很早就说要去的一个地方，但总总原因一直没去成，今年说了很多个地方，最后决定去平遥。</span><div><span><br /></span></div><div><span>初四早上七点多起来收拾完毕就开始要准备出发了，不过因为大舅哥一家也要去，等吧，一等就到九点多了还没开始走，呵呵，没办法，加满油到跳枪，大概二百三十元左右，小里程表清零，找大嘴拿了两个手台想的路上用，最后才知道最没用的就是这两个手台，帕萨特和炫丽，不是一个档次，一路上两车相距太远呼不着啊</span></div><div><div><table><tbody><tr><th><div>";
    
    [rtLabel setText:self.content];
    
    CGSize size = [rtLabel optimumSize];
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    rtLabel.frame = frame;
    rtLabel.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:rtLabel];
    
    UIScrollView * sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, kMainScreenHeight - 44)];
    
    sv.contentSize = size;
    
    [sv addSubview:rtLabel];
    
    [self.view addSubview:sv];
}
#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    NewsItem * item = [dataArray objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = item.content;
//    
//    cell.textLabel.numberOfLines = 0;
    
    RTLabel * rtLbl = [[RTLabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 200)];
    rtLbl.backgroundColor = [UIColor redColor];
    [cell addSubview:rtLbl];
    [rtLbl setText:@"<span>每年的正月都会出去走走，看看其他地方的年味，今年和大舅哥一家约好两车八人自驾平遥，一路走走停停寻找那缺失的年味。平遥很早就说要去的一个地方，但总总原因一直没去成，今年说了很多个地方，最后决定去平遥。</span><div><span><br /></span></div><div><span>初四早上七点多起来收拾完毕就开始要准备出发了，不过因为大舅哥一家也要去，等吧，一等就到九点多了还没开始走，呵呵，没办法，加满油到跳枪，大概二百三十元左右，小里程表清零，找大嘴拿了两个手台想的路上用，最后才知道最没用的就是这两个手台，帕萨特和炫丽，不是一个档次，一路上两车相距太远呼不着啊</span></div><div><div><table><tbody><tr><th><div>"];
 
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
   NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
    
    NSArray * list = [[[dict objectForKey:@"json"] objectForKey:@"data"] objectForKey:@"list"];
    
    
    NSLog(@"%@", list);
    
    for (NSDictionary * d in list) {
        
        NewsItem * item = [[NewsItem alloc]init];
        
        item.content = [d objectForKey:@"content"];
        
        [dataArray addObject:item];
    }
    
    NewsItem * item = [dataArray lastObject];
    
    NSLog(@"%@", item.content);
    
    [self.cell setHTMLString:@"<span>每年的正月都会出去走走，看看其他地方的年味，今年和大舅哥一家约好两车八人自驾平遥，一路走走停停寻找那缺失的年味。平遥很早就说要去的一个地方，但总总原因一直没去成，今年说了很多个地方，最后决定去平遥。</span><div><span><br /></span></div><div><span>初四早上七点多起来收拾完毕就开始要准备出发了，不过因为大舅哥一家也要去，等吧，一等就到九点多了还没开始走，呵呵，没办法，加满油到跳枪，大概二百三十元左右，小里程表清零，找大嘴拿了两个手台想的路上用，最后才知道最没用的就是这两个手台，帕萨特和炫丽，不是一个档次，一路上两车相距太远呼不着啊</span></div><div><div><table><tbody><tr><th><div>"];
    
}

@end
