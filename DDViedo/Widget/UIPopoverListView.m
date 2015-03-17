//
//  UIPopoverListView.m
//  UIPopoverListViewDemo
//
//  Created by su xinde on 13-3-13.
//  Copyright (c) 2013年 su xinde. All rights reserved.
//

#import "UIPopoverListView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+AddColor.h"
//#define FRAME_X_INSET 20.0f
//#define FRAME_Y_INSET 40.0f

@interface UIPopoverListView ()
@property (nonatomic, assign)CGFloat tempY;
@property (nonatomic, assign)CGFloat tempHeight;
- (void)fadeIn;
- (void)fadeOut;

@end

@implementation UIPopoverListView

@synthesize datasource = _datasource;
@synthesize delegate = _delegate;

@synthesize listView = _listView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        frame.origin.y += 64;
        self.frame = frame;
        self.tempY = frame.origin.y;
        self.tempHeight = frame.size.height;
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        
        _listView.dataSource = self;
        _listView.delegate = self;
        
        [self addSubview:_listView];
        
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        
        _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        [_overlayView addTarget:self
                         action:@selector(dismiss)
               forControlEvents:UIControlEventTouchUpInside];
        
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        
        
        CGRect frame = [[change objectForKey:@"new"] CGRectValue];
        _listView.frame = CGRectMake(0, 64, frame.size.width, frame.size.height);
        NSLog(@"%@", NSStringFromCGRect(frame));
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.datasource &&
       [self.datasource respondsToSelector:@selector(popoverListView:numberOfRowsInSection:)])
    {
        return [self.datasource popoverListView:self numberOfRowsInSection:section];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.datasource &&
       [self.datasource respondsToSelector:@selector(popoverListView:cellForIndexPath:)])
    {
        return [self.datasource popoverListView:self cellForIndexPath:indexPath];
    }
    return nil;
}

-(void) reloadData{
    
    [_listView  reloadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(popoverListView:heightForRowAtIndexPath:)])
    {
        return [self.delegate popoverListView:self heightForRowAtIndexPath:indexPath];
    }
    
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(popoverListView:didSelectIndexPath:)])
    {
        [self.delegate popoverListView:self didSelectIndexPath:indexPath];
    }

}


#pragma mark - animations

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1, 0.1);

    [UIView animateWithDuration:0.1 animations:^{

        self.transform = CGAffineTransformMakeTranslation(1, 1);
        CGRect frame = self.frame;
        frame.size.height = self.tempHeight;
        self.frame = frame;
    }];
    
}
- (void)fadeOut
{
//    [self.delegate onTouchEvent];
    [UIView animateWithDuration:.1 animations:^{
//        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
        self.transform = CGAffineTransformMakeTranslation(1, 0.1);
        CGRect frame = self.frame;
        frame.size.height = 0.1;
        self.frame = frame;
//        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
             [self removeFromSuperview];
            [_overlayView removeFromSuperview];
           
        }
    }];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
   
    [keywindow addSubview:self];
    
    [self fadeIn];
}


- (void)dismiss
{
    [self fadeOut];
}

@end
