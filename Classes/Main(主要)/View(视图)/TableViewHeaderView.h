//
//  TableViewHeaderView.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableViewHeaderView, TableViewHeaderViewButton;

typedef enum{
    TableViewHeaderViewButtonTypeAllBrand = 1,//全部品牌
    TableViewHeaderViewButtonTypeAllLevel = 2,//全部级别
    TableViewHeaderViewButtonTypeAllMovie = 3,//全部视频
    TableViewHeaderViewButtonTypeAllProvince = 4,//全部省份
    TableViewHeaderViewButtonTypeAllCarType = 5,//全部车型
    TableViewHeaderViewButtonTypeAllColor = 6,//全部颜色
    TableViewHeaderViewButtonTypeAllType = 7,//全部类型
    TableViewHeaderViewButtonTypeLocationSort = 8//按地点排序
}TableViewHeaderViewButtonType;

typedef void(^TableViewHeaderViewBlock)(TableViewHeaderView*, TableViewHeaderViewButtonType);

typedef void(^TableViewHeaderViewBlock1)(TableViewHeaderView*, TableViewHeaderViewButton*);

@interface TableViewHeaderView : UIScrollView

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, copy) TableViewHeaderViewBlock block;
@property (nonatomic, copy) TableViewHeaderViewBlock1 block1;

- (instancetype)initWithFindTypes:(NSArray *)findTypes types:(NSArray *)types frame:(CGRect)frame;

+ (instancetype)tableViewHeaderViewWithFindTypes:(NSArray *)findTypes types:(NSArray *)types frame:(CGRect)frame;

- (instancetype)initWithheadViewContents:(NSArray *)headViewContents frame:(CGRect)frame;
+ (instancetype)tableViewHeaderViewWithheadViewContents:(NSArray *)headViewContents frame:(CGRect)frame;

@property (nonatomic, assign) NSInteger selectedButtonIndex;


@end
