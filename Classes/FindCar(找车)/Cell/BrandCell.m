//
//  BrandCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "BrandCell.h"
#import "Brand.h"
#import "UIImageView+WebCache.h"

@implementation BrandCell

- (void)setBrand:(Brand *)brand
{
    _brand = brand;
    [self.imgurlImageView sd_setImageWithURL:[NSURL URLWithString:brand.imgurl]];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.imgurlImageView.width, 0)];
//    view.backgroundColor = [UIColor redColor];
//    [self.imgurlImageView addSubview:view];
//    [self.imgurlImageView sd_setImageWithURL:[NSURL URLWithString:brand.imgurl] placeholderImage:nil options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        view.height = self.imgurlImageView.height * receivedSize*1.0/expectedSize;
//        [view removeFromSuperview];
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
    self.nameLabel.text = brand.name;
}

- (void)setCustomBrand:(Brand *)customBrand
{
    _customBrand = customBrand;
    self.imgurlImageView.image = [UIImage imageNamed:customBrand.imgurl];
    self.nameLabel.text = customBrand.name;
}



@end
