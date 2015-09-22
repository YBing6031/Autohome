//
//  HotserieCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "HotserieCell.h"
#import "UIImageView+WebCache.h"
#import "Hotserie.h"
#import "Serie.h"

@implementation HotserieCell

- (void)setHotserie:(Hotserie *)hotserie
{
    _hotserie = hotserie;
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:hotserie.img]];
    self.seriesnameLabel.text = hotserie.seriesname;
    self.priceLabel.text = hotserie.price;
}

- (void)setSerie:(Serie *)serie
{
    _serie = serie;
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:serie.imgurl]];
    self.seriesnameLabel.text = serie.name;
    self.priceLabel.text = serie.price;
}

@end
