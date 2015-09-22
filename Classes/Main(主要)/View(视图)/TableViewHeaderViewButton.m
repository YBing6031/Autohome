//
//  TableViewHeaderViewButton.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "TableViewHeaderViewButton.h"
#import "Level.h"
#import "HeadViewContent.h"

@implementation TableViewHeaderViewButton

- (void)setLevel:(Level *)level
{
    _level = level;
    [self setTitle:level.levelname forState:UIControlStateNormal];
}

- (void)setHeadViewContent:(HeadViewContent *)headViewContent
{
    _headViewContent = headViewContent;
    [self setTitle:headViewContent.name forState:UIControlStateNormal];
}

@end
