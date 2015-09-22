//
//  CycleScrollView.h
//  AlbumDemo
//
//  Created by aoyolo1 on 15/5/1.
//  Copyright (c) 2015年 aoyolo1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IndexChange)(NSInteger index);
@interface CycleScrollView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame andImages:(NSArray *)images andCurrentIndex:(NSInteger)index andIndexChange:(IndexChange)block;


@property (nonatomic, strong) NSArray *images;

@property (nonatomic) NSInteger currentIndex;

@end
