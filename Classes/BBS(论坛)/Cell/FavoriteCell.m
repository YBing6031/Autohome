//
//  FavoriteCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

- (void)setIco:(NSString *)ico title:(NSString *)title subTitle:(NSString *)subTitle
{
    self.ico.image = [UIImage imageNamed:ico];
    self.title.text = title;
    self.subTitile.text = subTitle;
}

@end
