//
//  FastnewsTwoCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "FastnewsTwoCell.h"
#import "Fastnews.h"
#import "UIImageView+WebCache.h"

@implementation FastnewsTwoCell

- (void)setFastnews:(Fastnews *)fastnews
{
    _fastnews = fastnews;
    self.typenameLabel.text = fastnews.typename;
    self.titleLabel.text = fastnews.title;
    self.reviewcountLabel.text = [NSString stringWithFormat:@"%zi位观众", fastnews.reviewcount];
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:fastnews.img]];
    self.createtimeLabel.text = fastnews.createtime;
    self.bobaozhongLabel.hidden = fastnews.state!=1;
    self.bobaoEndLabel.hidden = !self.bobaozhongLabel.hidden;
}

@end
