//
//  PhotoView.m
//  AlbumDemo
//
//  Created by aoyolo1 on 15/5/1.
//  Copyright (c) 2015年 aoyolo1. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"

@implementation PhotoView
{
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.clipsToBounds = YES;
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
        [self setMinimumZoomScale:1.0];
        [self setMaximumZoomScale:3.0];
        [self setZoomScale:1 animated:NO];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = _image;
}

- (void)setPhoto:(Photo *)photo
{
    _photo = photo;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:photo.imgurl]];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [self setZoomScale:scale animated:NO];
}

@end
