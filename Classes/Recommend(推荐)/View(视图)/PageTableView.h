//
//  PageTableView.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableViewHeaderView;
@interface PageTableView : UITableView
/**是否刷新过*/
@property (nonatomic, assign) BOOL isRefresh;
/**页码*/
@property (nonatomic, assign) NSInteger page;


@property (nonatomic, strong) TableViewHeaderView *headerView;

+ (instancetype)pageTableView:(CGRect)rect style:(UITableViewStyle)style tag:(NSInteger)tag delegate:(id)delegate dataSource:(id)dataSource cellNib:(NSString *)cellNib rowHeight:(CGFloat)rowHeight;

+ (instancetype)pageTableView:(CGRect)rect delegate:(id)delegate tag:(NSInteger)tag;

+ (instancetype)pageTableView:(CGRect)rect delegate:(id)delegate tag:(NSInteger)tag registerNibNames:(NSArray *)registerNibNames style:(UITableViewStyle)style;

@end
