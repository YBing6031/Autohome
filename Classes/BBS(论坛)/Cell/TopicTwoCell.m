//
//  TopicTwoCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "TopicTwoCell.h"
#import "Topic.h"

@implementation TopicTwoCell

- (void)setTopic:(Topic *)topic
{
    _topic = topic;
    CGRect titleRect = [topic.title boundingRectWithSize:CGSizeMake(kScreenW-8-4, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.titleConstraintH.constant = titleRect.size.height;
    self.titleLabel.text = topic.title;
    
    NSString *lastStr = nil;
    if (self.type == 1) {//最新发布
        lastStr = [NSString stringWithFormat:@"发布:%@", topic.posttopicdate];
    } else {
        lastStr = [NSString stringWithFormat:@"回复:%@", topic.lastreplydate];
    }
    
    CGSize size = [lastStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    self.lastreplydateConstraintW.constant = size.width;
    self.lastreplydateLabel.text = lastStr;
    
    self.postusernameReplynumLabel.text = [NSString stringWithFormat:@"%@ %zi回", topic.postusername, topic.replycounts];
    
    self.ispicImageView.hidden = !topic.ispic;
    
    if (topic.topictype.length) {
        self.topictypeImageView.hidden = NO;
        if ([topic.topictype isEqualToString:@"顶"]) {
            self.topictypeImageView.image = [UIImage imageNamed:@"bg_top"];
        }
        else if ([topic.topictype isEqualToString:@"精"]) {
            self.topictypeImageView.image = [UIImage imageNamed:@"bg_marrow"];
        }
    }
    else {
        self.topictypeImageView.hidden = YES;
    }
}

@end
