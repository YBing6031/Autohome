//
//  SelectNewsController.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News, Movie, Shuoke;
@interface SelectNewsController : UIViewController

@property (nonatomic, strong) News *news;
@property (nonatomic, strong) Movie *movie;
@property (nonatomic, strong) Shuoke *shuoke;

@end
