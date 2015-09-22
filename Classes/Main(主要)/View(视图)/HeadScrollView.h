//
//  HeadScrollView.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeadScrollView;
@protocol HeadScrollViewDelegate <NSObject>
@optional
- (void)headScrollView:(HeadScrollView *)headScrollView onClickIndex:(NSInteger)index;

@end

@interface HeadScrollView : UIScrollView

@property (nonatomic, weak) id<HeadScrollViewDelegate> headScrollViewDelegate;

/**里面放的是HeadScrollView要显示的组*/
@property (nonatomic, strong) NSArray *headViewcontents;

@property (nonatomic, assign) NSInteger currentSelectIndex;


@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, assign) BOOL isBtnClicked;


@end
