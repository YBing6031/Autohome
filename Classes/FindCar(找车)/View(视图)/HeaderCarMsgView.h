//
//  HeaderCarMsgView.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeaderCarMsgView;
typedef void(^HeaderCarMsgViewBlock)(HeaderCarMsgView *, NSInteger);
@interface HeaderCarMsgView : UIView

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) HeaderCarMsgViewBlock block;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, assign) NSInteger currentIndex;

@end
