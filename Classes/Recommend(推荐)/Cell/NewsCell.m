//
//  NewsCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import "UIImageView+WebCache.h"
#import "Movie.h"
#import "Shuoke.h"
#import "Headlineinfo.h"
#import "Topic.h"
#import "ShowCarMsgNews.h"

@implementation NewsCell

- (void)setNews:(News *)news {
    _news = news;
    [self.smallpicImageView sd_setImageWithURL:[NSURL URLWithString:news.smallpic]];
    self.mediatype = news.mediatype;
    self.shuokeLabel.hidden = news.mediatype!=2;
    self.bobaozhongLabel.hidden = news.mediatype!=7;
    self.replycountLabel.hidden = !self.bobaozhongLabel.hidden;
    self.headlineLabel.hidden = YES;
    self.titleLabel.text = news.title;
    self.timeLabel.text = news.time;
    NSString *str = @"评论";
    switch (news.mediatype) {
        case 3:
            str = @"播放";
            break;
        case 5:
            str = @"回帖";
            break;
        default:
            break;
    }
    self.replycountLabel.text = [NSString stringWithFormat:@"%zi%@", news.replycount, str];
}

- (void)setHeadlineinfo:(Headlineinfo *)headlineinfo
{
    _headlineinfo = headlineinfo;
    self.mediatype = headlineinfo.mediatype;
    self.headlineLabel.hidden = NO;
    [self.smallpicImageView sd_setImageWithURL:[NSURL URLWithString:headlineinfo.smallpic]];
    self.titleLabel.text = headlineinfo.title;
    self.timeLabel.text = headlineinfo.time;
    self.replycountLabel.text = [NSString stringWithFormat:@"%zi评论", headlineinfo.replycount];
}

- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    self.mediatype = 3;
    self.shuokeLabel.hidden = YES;
    [self.smallpicImageView sd_setImageWithURL:[NSURL URLWithString:movie.smallimg]];
    self.titleLabel.text = movie.title;
    self.timeLabel.text = movie.time;
    self.replycountLabel.text = [NSString stringWithFormat:@"%zi播放", movie.playcount];
}


- (void)setShuoke:(Shuoke *)shuoke
{
    _shuoke = shuoke;
    self.mediatype = 2;
    self.shuokeLabel.hidden = YES;
    [self.smallpicImageView sd_setImageWithURL:[NSURL URLWithString:shuoke.smallpic]];
    self.titleLabel.text = shuoke.title;
    self.timeLabel.text = shuoke.time;
    self.replycountLabel.text = [NSString stringWithFormat:@"%zi评论", shuoke.replycount];
}

- (void)setTopic:(Topic *)topic
{
    _topic = topic;
    
    [self.smallpicImageView sd_setImageWithURL:[NSURL URLWithString:topic.smallpic]];
    self.titleLabel.text = topic.title;
    self.timeLabel.text = topic.lastreplydate;
    self.replycountLabel.text = [NSString stringWithFormat:@"%zi回", topic.replycounts];
}

- (void)setShowCarMsgNews:(ShowCarMsgNews *)showCarMsgNews
{
    _showCarMsgNews = showCarMsgNews;
    [self.smallpicImageView sd_setImageWithURL:[NSURL URLWithString:_showCarMsgNews.smallpic]];
    self.replycountLabel.hidden = !self.bobaozhongLabel.hidden;
    self.headlineLabel.hidden = YES;
    self.titleLabel.text = _showCarMsgNews.title;
    self.timeLabel.text = _showCarMsgNews.time;
    NSString *str = @"评论";
    self.replycountLabel.text = [NSString stringWithFormat:@"%zi%@", _showCarMsgNews.replycount, str];
}

@end
