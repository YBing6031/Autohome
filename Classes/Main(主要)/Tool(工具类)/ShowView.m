//
//  ShowView.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "ShowView.h"

@implementation ShowView

- (void)addGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGFloat offsetX = [pan locationInView:pan.view.superview].x;
    
    static CGFloat startX;
    static CGFloat startOriginX;
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        startX = offsetX;
        startOriginX = self.x;
    }
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
        if (self.x < kScreenW-self.width+self.width/2){
            self.x = kScreenW-self.width;
        }
        else {
            self.x = kScreenW;
            [self.bgView removeFromSuperview];
        }
    }
    else
    {
        CGFloat x = offsetX + startOriginX - startX;
        if (x<kScreenW-self.width) {
            return;
        }
        self.x = x;
    }
}

- (instancetype)initWithTitles:(NSArray *)navigationBarTitles frame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSource
{
    self = [super initWithFrame:CGRectMake(kScreenW, frame.origin.y, frame.size.width, frame.size.height)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addGesture];
        if (navigationBarTitles) {
            self.navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 34)];
            label.text = navigationBarTitles[0];
            label.center = CGPointMake(self.navigationBar.width/2, self.navigationBar.height/2);
            [self.navigationBar addSubview:label];
            
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            closeBtn.frame = CGRectMake(self.width-60, 5, 60, 34);
            [closeBtn setTitle:navigationBarTitles[1] forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationBar addSubview:closeBtn];
            [self addSubview:self.navigationBar];
        }
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationBar.height, self.width, self.height-self.navigationBar.height) style:UITableViewStylePlain];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        self.tableView.delegate = delegate;
        self.tableView.dataSource = dataSource;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44;
        [self addSubview:self.tableView];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenW, kScreenH-20)];
        bgView.alpha = 0.5;
        bgView.backgroundColor = [UIColor grayColor];
        [window addSubview:bgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [bgView addGestureRecognizer:tap];
        self.bgView = bgView;
    }
    return self;
}

- (instancetype)initWithSegmentTitles:(NSArray *)segmentTitles frame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSource
{
    self = [super initWithFrame:CGRectMake(kScreenW, frame.origin.y, frame.size.width, frame.size.height)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addGesture];
        
        if (segmentTitles) {
            self.navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
            UISegmentedControl *segmentCtl = [[UISegmentedControl alloc] initWithItems:segmentTitles];
            segmentCtl.frame = CGRectMake(8, 8, self.width-8*2, 26);
            segmentCtl.selectedSegmentIndex = 0;
            [segmentCtl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
            [self.navigationBar addSubview:segmentCtl];
            [self addSubview:self.navigationBar];
        }
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationBar.height, self.width, self.height-self.navigationBar.height) style:UITableViewStylePlain];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"HotserieCell" bundle:nil] forCellReuseIdentifier:@"HotserieCell"];
        self.tableView.delegate = delegate;
        self.tableView.dataSource = dataSource;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44;
        [self addSubview:self.tableView];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenW, kScreenH-20)];
        bgView.alpha = 0.5;
        bgView.backgroundColor = [UIColor grayColor];
        [window addSubview:bgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [bgView addGestureRecognizer:tap];
        self.bgView = bgView;
    }
    return self;
}


- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window insertSubview:self aboveSubview:self.bgView];
    [UIView animateWithDuration:0.5 animations:^{
        self.x -= self.width;
    }];
}

- (void)valueChanged:(UISegmentedControl *)segmenCtl
{
    if (self.block) {
        self.block(self, segmenCtl);
    }
}

- (void)close
{
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)closeWithAnimated:(BOOL)animated
{
    if (animated) {
        [self close:nil];
    }
    else
    {
        [self close];
    }
}

+ (void)showWithTitles:(NSArray *)navigationBarTitles frame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSource
{
    ShowView *showView = [[ShowView alloc] initWithTitles:navigationBarTitles frame:frame delegate:delegate dataSource:dataSource];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    
    
    [window insertSubview:showView aboveSubview:showView.bgView];
    [UIView animateWithDuration:0.5 animations:^{
        showView.x -= showView.width;
    }];
}

- (void)close:(UIButton *)button
{
    [UIView animateWithDuration:0.5 animations:^{
        self.x += self.width;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.5 animations:^{
        self.x += self.width;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
