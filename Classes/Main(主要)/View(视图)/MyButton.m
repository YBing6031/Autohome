//
//  MyButton.m
//  MeiTuan_Net_Test
//
//  Created by aoyolo1 on 15/5/28.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    //布置图片
    self.imageView.width = 16;
    self.imageView.height = self.height;
    self.imageView.x = self.width - self.imageView.width - 10;
    self.imageView.y = 0;
    
    //布置文字
    self.titleLabel.x = 0;
    self.titleLabel.y = 0;
    self.titleLabel.width = self.width - self.imageView.width;
    self.titleLabel.height = self.height;
}

@end
