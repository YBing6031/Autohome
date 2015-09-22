//
//  ImageCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "ImageCell.h"
#import "ImageButton.h"
#import "Image.h"

@implementation ImageCell

- (void)setImage:(Image *)image
{
    _image = image;
    self.imageBtn.image = image;
}

@end
