//
//  ImageButton.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "ImageButton.h"
#import "UIButton+WebCache.h"
#import "Image.h"

@implementation ImageButton

- (void)setImage:(Image *)image
{
    _image = image;
    self.id = image.id;
    self.isuserup = image.isuserup;
    self.membername = image.membername;
    self.smallpic = image.smallpic;
    self.specid = image.specid;
    self.specname = image.specname;
    self.typeid = image.typeid;
}

- (void)setSmallpic:(NSString *)smallpic
{
    _smallpic = [smallpic copy];
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:smallpic] forState:UIControlStateNormal];
}

@end
