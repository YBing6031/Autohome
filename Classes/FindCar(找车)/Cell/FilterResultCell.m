//
//  FilterResultCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/15.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "FilterResultCell.h"
#import "UIImageView+WebCache.h"
#import "SerieTwo.h"

@implementation FilterResultCell

- (void)setSerieTwo:(SerieTwo *)serieTwo
{
    _serieTwo = serieTwo;
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:serieTwo.img]];
    self.nameLabel.text = serieTwo.name;
    self.priceLabel.text = serieTwo.price;
    
    CGSize size = [serieTwo.level sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    self.levelConstraintW.constant = size.width;
    self.levelLabel.text = serieTwo.level;
    
    self.countLabel.layer.cornerRadius = self.countLabel.width/2;
    self.countLabel.text = [NSString stringWithFormat:@"%zi", serieTwo.count];
}

@end
