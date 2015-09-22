//
//  HeaderCarMsgView.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "HeaderCarMsgView.h"

@implementation HeaderCarMsgView
{
    UIButton *_currentBtn;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex+1;
    _currentBtn.selected = NO;
    [self.buttons[currentIndex+1] setSelected:YES];
    _currentBtn = self.buttons[currentIndex+1];
    
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    NSInteger count = titles.count;
    CGFloat w = kScreenW/4;
    CGFloat h = 35;
    for (int i = 0; i < count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        if (i == 0) {
            [btn setImage:[UIImage imageNamed:@"bar_btn_icon_returntext"] forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
        }
        if (i == 1) {
            btn.selected = YES;
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i%4 * w, i/4 * 35, w, h);
        
        if (self.buttons == nil) {
            self.buttons = [NSMutableArray array];
        }
        [self.buttons addObject:btn];
        
        [self addSubview:btn];
    }
    _currentBtn = self.buttons[1];
    for (int i = 0; i < 3; i++)
    {
        [self addbgViewWithframe:CGRectMake(w+i*w, 0, 1, h*2)];
    }
    
    [self addbgViewWithframe:CGRectMake(0, h, kScreenW, 1)];
    [self addbgViewWithframe:CGRectMake(0, h*2, kScreenW, 1)];
}

- (void)addbgViewWithframe:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = RGB(250, 250, 250);
    [self addSubview:view];
}

- (void)onClick:(UIButton *)btn
{
    if (self.block) {
        self.block(self, btn.tag-1);
    }
}

@end
