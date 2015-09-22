//
//  FastnewsCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "FastnewsCell.h"
#import "News.h"
#import "UIImageView+WebCache.h"

@implementation FastnewsCell

- (void)setNews:(News *)news
{
    _news = news;
    self.mediatype = news.mediatype;
    [self.smallpicImageView sd_setImageWithURL:[NSURL URLWithString:news.smallpic]];
    self.titleLabel.text = news.title;
    self.timeLabel.text = news.time;
    self.typeLabel.text = news.type;
}

@end
