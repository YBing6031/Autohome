//
//  PostCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "TopicCell.h"
#import "Topic.h"

@implementation TopicCell

- (void)setTopic:(Topic *)topic
{
    _topic = topic;
    self.titleLabel.text = topic.title;
    self.posttimeLabel.text = topic.posttime;
    self.bbsnameLabel.text = topic.bbsname;
    self.replynumLabel.text = [NSString stringWithFormat:@"%zi回", topic.replynum];
}

@end
