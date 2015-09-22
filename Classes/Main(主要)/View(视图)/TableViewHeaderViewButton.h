//
//  TableViewHeaderViewButton.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewHeaderView.h"
@class Level, HeadViewContent;
@interface TableViewHeaderViewButton : UIButton

@property (nonatomic, assign) TableViewHeaderViewButtonType type;

@property (nonatomic, strong) Level *level;



@property (nonatomic, strong) HeadViewContent *headViewContent;

@property (nonatomic, assign) NSInteger value;

@end
