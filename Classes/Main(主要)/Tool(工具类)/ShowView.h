//
//  ShowView.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ShowViewBlock)(id, id);
@interface ShowView : UIView

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *navigationBar;
@property (nonatomic, assign) id<UITableViewDelegate> delegate;
@property (nonatomic, assign) id<UITableViewDataSource> dataSource;
@property (nonatomic, copy) ShowViewBlock block;

- (instancetype)initWithTitles:(NSArray *)navigationBarTitles frame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSource;

- (instancetype)initWithSegmentTitles:(NSArray *)segmentTitles frame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSource;

+ (void)showWithTitles:(NSArray *)navigationBarTitles frame:(CGRect)frame delegate:(id)delegate dataSource:(id)dataSource;

- (void)show;

- (void)close;
- (void)closeWithAnimated:(BOOL)animated;

@end
