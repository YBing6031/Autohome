//
//  HeaderView.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/4.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "HeaderView.h"
#import "UIButton+WebCache.h"
#import "Focusimg.h"
@implementation HeaderView
{
    NSTimer *_timer;
    NSInteger _count;
}

- (void)setFocusimgs:(NSArray *)focusimgs
{
    _focusimgs = focusimgs;
    NSInteger count = focusimgs.count;
    _count = count;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    for (int i = 0; i < count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*kScreenW, 0, kScreenW, self.height);
        button.tag = i + 1;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [button sd_setImageWithURL:[NSURL URLWithString:[focusimgs[i] imgurl]] forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        button.imageView.clipsToBounds = YES;
        [scrollView addSubview:button];
    }
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(count * kScreenW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    UIPageControl *pageCtl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height-35, 150, 35)];
    pageCtl.center = CGPointMake(self.width/2, self.height-pageCtl.height/2);
    pageCtl.pageIndicatorTintColor = [UIColor blueColor];
    pageCtl.currentPageIndicatorTintColor = [UIColor redColor];
    pageCtl.numberOfPages = count;
    [pageCtl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    self.pageCtl = pageCtl;
    [self addSubview:pageCtl];
}

- (void)valueChanged:(UIPageControl *)pageCtl
{
    NSInteger page = pageCtl.currentPage;
    [self.scrollView setContentOffset:CGPointMake(page*kScreenW, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/kScreenW;
    self.pageCtl.currentPage = page;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)timerAction
{
    NSInteger page = self.pageCtl.currentPage;
    page++;
    if (page == _count) {
        page = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(kScreenW*page, 0) animated:YES];
    self.pageCtl.currentPage = page;
}

+ (instancetype)headerViewWithFocusimgs:(NSArray *)focusimgs frame:(CGRect)frame
{
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:frame];
    headerView.focusimgs = focusimgs;
    
    return headerView;
}

- (void)onClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(headerView:onClickIndex:)]) {
        [self.delegate headerView:self onClickIndex:button.tag];
    }
}

@end
