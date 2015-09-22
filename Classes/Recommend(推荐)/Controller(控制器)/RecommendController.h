//
//  RecommendController.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeadScrollView, TableScrollView;
@interface RecommendController : UIViewController
@property (weak, nonatomic) IBOutlet HeadScrollView *navScrollView;
@property (weak, nonatomic) IBOutlet TableScrollView *tableScrollView;
@end
