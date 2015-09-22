//
//  CycleScrollView.m
//  AlbumDemo
//
//  Created by aoyolo1 on 15/5/1.
//  Copyright (c) 2015年 aoyolo1. All rights reserved.
//

#import "CycleScrollView.h"
#import "PhotoView.h"
#import "Photo.h"
#import "UIImageView+WebCache.h"

@interface CycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) PhotoView *preImageView;
@property (nonatomic, strong) PhotoView *currentImageView;
@property (nonatomic, strong) PhotoView *nextImageView;
@property (nonatomic, copy) IndexChange indexBlock;

@end

@implementation CycleScrollView

- (void)_initImageViews
{
    self.preImageView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.currentImageView = [[PhotoView alloc] initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    self.nextImageView = [[PhotoView alloc] initWithFrame:CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:_preImageView];
    [self addSubview:_currentImageView];
    [self addSubview:_nextImageView];
}

- (NSInteger)beyondBoundWithIndex:(NSInteger)index {
    if (index < 0)
    {
        index = self.images.count - 1;
    }
    else if (index > self.images.count - 1)
    {
        index = 0;
    }
    return index;
}

- (void)configImages
{
    NSInteger preIndex = [self beyondBoundWithIndex:_currentIndex - 1];
    NSInteger nextIndex = [self beyondBoundWithIndex:_currentIndex + 1];
    self.preImageView.photo = self.images[preIndex];
    self.currentImageView.photo = self.images[_currentIndex];
    self.nextImageView.photo = self.images[nextIndex];
    
    self.currentImageView.zoomScale = 1.0;
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
}

- (instancetype)initWithFrame:(CGRect)frame andImages:(NSArray *)images andCurrentIndex:(NSInteger)index andIndexChange:(IndexChange)block
{
    if (self = [super initWithFrame:frame])
    {
        self.images = images;
        self.currentIndex = index;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        [self _initImageViews];
        self.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        [self configImages];
        self.indexBlock = block;
    }
    return self;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self configImages];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset < self.bounds.size.width)
    {
        self.currentIndex = [self beyondBoundWithIndex:_currentIndex - 1];
        [self configImages];
    }
    else if (xOffset > self.bounds.size.width)
    {
        self.currentIndex = [self beyondBoundWithIndex:_currentIndex + 1];
        [self configImages];
    }
    if (_indexBlock)
    {
        self.indexBlock(_currentIndex);
    }
}

@end
