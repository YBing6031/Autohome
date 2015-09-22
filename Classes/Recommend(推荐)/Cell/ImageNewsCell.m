//
//  ImageNewsCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/4.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "ImageNewsCell.h"
#import "News.h"
#import "UIImageView+WebCache.h"

@implementation ImageNewsCell

- (void)setNews:(News *)news {
    _news = news;
    self.mediatype = news.mediatype;
    self.titleLabel.text = news.title;
    self.timeLabel.text = news.time;
    self.replycountLabel.text = [NSString stringWithFormat:@"%zi图片", news.replycount];
    NSRange range = [news.indexdetail rangeOfString:@"http://"];
    NSString *imageStr = [news.indexdetail substringFromIndex:range.location];
    NSArray *images = [imageStr componentsSeparatedByString:@","];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:images[0]]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:images[2]]];
    [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:images[1]]];
}

@end
