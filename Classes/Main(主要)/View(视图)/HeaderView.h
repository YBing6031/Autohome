//
//  HeaderView.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/4.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeaderView;
@protocol HeaderViewDelegate <NSObject>
@optional
- (void)headerView:(HeaderView *)headerView onClickIndex:(NSInteger)index;
@end

@interface HeaderView : UIView<UIScrollViewDelegate>


@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageCtl;

@property (nonatomic, strong) NSArray *focusimgs;

@property (nonatomic, weak) id<HeaderViewDelegate> delegate;
+ (instancetype)headerViewWithFocusimgs:(NSArray *)focusimgs frame:(CGRect)frame;

@end
