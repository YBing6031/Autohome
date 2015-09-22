//
//  DiscoverCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/15.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "DiscoverCell.h"
#import "Discover.h"
#import "UIImageView+WebCache.h"

@implementation DiscoverCell

- (void)setDiscover:(Discover *)discover
{
    _discover = discover;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:discover.iconurl]];
    self.titleLabel.text = discover.title;
}

- (void)setDict:(NSDictionary *)dict
{
    self.iconImageView.image = [UIImage imageNamed:dict[@"icon"]];
    self.titleLabel.text = dict[@"title"];
}

@end
