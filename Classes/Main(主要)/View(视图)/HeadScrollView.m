//
//  HeadScrollView.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "HeadScrollView.h"
#import "HeadViewContent.h"


@implementation HeadScrollView
{
    UIButton *_currentSelectButton;
    NSMutableArray *_buttonArr;
    CGFloat _countW;
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = RGB(250, 250, 250);
        self.bounces = NO;
    }
    return self;
}

- (void)setHeadViewcontents:(NSArray *)headViewcontents
{
    _headViewcontents = headViewcontents;
    int count = 0;
    for (HeadViewContent *headContent in headViewcontents) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button.backgroundColor = RGB(arc4random()%256, arc4random()%256, arc4random()%256);
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTintColor:[UIColor clearColor]];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [button setTitle:headContent.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        if (count == 0) {
            button.selected = YES;
            _currentSelectButton = button;
        }
        button.tag = ++count;
        if (_buttonArr == nil) {
            _buttonArr = [NSMutableArray arrayWithCapacity:0];
        }
        [_buttonArr addObject:button];
        [self addSubview:button];
    }
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor blueColor];
    _bottomView = bottomView;
    [self addSubview:bottomView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = _buttonArr.count;
    CGFloat countW = 0;
    for (int i = 0; i < count; i++)
    {
        HeadViewContent *headContent = _headViewcontents[i];
        CGSize size = [headContent.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        
        [_buttonArr[i] setFrame:CGRectMake(countW, 0, size.width+20, 34)];
        
        countW += size.width+20;
    }
    _countW = countW;
    self.contentSize = CGSizeMake(countW, 0);
    _bottomView.frame = CGRectMake(_currentSelectButton.x+2, 33, _currentSelectButton.width-4, 2);
}

- (void)changeBottomViewFrame
{
    [UIView animateWithDuration:0.1 animations:^{
        self.bottomView.x = _currentSelectButton.x+2;
        self.bottomView.width = _currentSelectButton.width-4;
    }];
}

- (void)onClick:(UIButton *)button
{
    //记录是按钮点击
    self.isBtnClicked = YES;
    
    _currentSelectButton.selected = NO;
    _currentSelectButton = button;
    _currentSelectButton.selected = YES;
    
    [self changeBottomViewFrame];
    
    CGFloat offsetX = button.x - kScreenW/2 + button.width/2;
    
    if (offsetX>0&&offsetX<_countW-kScreenW) {
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    else if (offsetX<0&&self.contentOffset.x>0)
    {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (offsetX>_countW-kScreenW&&self.contentOffset.x<_countW- kScreenW)
    {
        [self setContentOffset:CGPointMake(_countW-kScreenW, 0) animated:YES];
    }
    
    if ([self.headScrollViewDelegate respondsToSelector:@selector(headScrollView:onClickIndex:)]) {
        [self.headScrollViewDelegate headScrollView:self onClickIndex:button.tag];
    }
}

- (void)setCurrentSelectIndex:(NSInteger )currentSelectIndex
{
    _currentSelectIndex = currentSelectIndex;
    _currentSelectButton.selected = NO;
    _currentSelectButton = _buttonArr[currentSelectIndex];
    _currentSelectButton.selected = YES;
    
    
    UIButton *button = _currentSelectButton;
   
    [self changeBottomViewFrame];
    
    CGFloat offsetX = button.x - kScreenW/2 + button.width/2;
    
    if (offsetX>0&&offsetX<_countW-kScreenW) {
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    else if (offsetX<0&&self.contentOffset.x>0)
    {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (offsetX>_countW-kScreenW&&self.contentOffset.x<_countW- kScreenW)
    {
        [self setContentOffset:CGPointMake(_countW-kScreenW, 0) animated:YES];
    }
    
    if ([self.headScrollViewDelegate respondsToSelector:@selector(headScrollView:onClickIndex:)]) {
        [self.headScrollViewDelegate headScrollView:self onClickIndex:button.tag];
    }
}

@end
