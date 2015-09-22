//
//  PhotoBrowserViewController.h
//  AlbumDemo
//
//  Created by aoyolo1 on 15/5/1.
//  Copyright (c) 2015年 aoyolo1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;
@interface PhotoBrowserViewController : UIViewController

@property (nonatomic, strong) NSArray *images;
@property (nonatomic) NSInteger selectIndex;

@property (nonatomic, strong) News *news;

@end
