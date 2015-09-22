//
//  PhotoView.h
//  AlbumDemo
//
//  Created by aoyolo1 on 15/5/1.
//  Copyright (c) 2015年 aoyolo1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;
@interface PhotoView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) Photo *photo;

@end
