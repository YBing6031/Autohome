//
//  DownPriceCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/14.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "DownPriceCell.h"
#import "Dealer.h"
#import "DownPrice.h"
#import "UIImageView+WebCache.h"

@implementation DownPriceCell

- (void)setDownPrice:(DownPrice *)downPrice
{
    _downPrice = downPrice;
    [self.specpicImageView sd_setImageWithURL:[NSURL URLWithString:downPrice.specpic]];
    self.seriesnameLabel.text = [NSString stringWithFormat:@"%@ %@", downPrice.seriesname, downPrice.specname];
    
    CGFloat downprice = [downPrice.fctprice floatValue] - [downPrice.dealerprice floatValue];
    self.downPriceLabel.text = [NSString stringWithFormat:@"降%.2f万", downprice];
    self.dealerpriceLabel.text = downPrice.dealerprice;
}

@end
