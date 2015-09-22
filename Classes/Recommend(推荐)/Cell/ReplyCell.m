//
//  ReplycountCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "ReplyCell.h"
#import "UIImageView+WebCache.h"
#import "Reply.h"
#import "UserMessageController.h"

@implementation ReplyCell

- (void)setReply:(Reply *)reply
{
    _reply = reply;
    if (reply.namepic.length) {
        [self.namepicImageView sd_setImageWithURL:[NSURL URLWithString:reply.namepic]];
    }
    
    //移除之前的手势
    for (UITapGestureRecognizer *tap in self.namepicImageView.gestureRecognizers) {
        [self.namepicImageView removeGestureRecognizer:tap];
    }
    
    //给头像添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.namepicImageView addGestureRecognizer:tap];
    
    self.vip.hidden = !reply.iscarowner;
    
    //计算那么的长度
    CGSize nameSize = [reply.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.nameConstraintW.constant = nameSize.width;
    [self.nameBtn setTitle:reply.name forState:UIControlStateNormal];
    self.carnameLabel.text = reply.carname;
    self.floorLabel.text = [NSString stringWithFormat:@"%zi楼", reply.floor];
    //计算content的高度
    CGRect contentRect = [reply.content boundingRectWithSize:CGSizeMake(kScreenW-64, NSIntegerMax) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    self.contentConstraintH.constant = contentRect.size.height;
    self.contentLabel.text = reply.content;
    
    self.timeLabel.text = reply.time;
    [self.upcountbtn setTitle:[NSString stringWithFormat:@"%zi", reply.upcount] forState:UIControlStateNormal];
    
    //设置sourceView
    [self setSourceView];
}

- (void)setSourceView
{

    UILabel *sourcenameLabel = (UILabel *)[self.sourceView viewWithTag:1];
    sourcenameLabel.text = self.reply.sourcename;
    
    //计算sourcecontent的高度
    CGRect sourcecontentRect = [self.reply.sourcecontent boundingRectWithSize:CGSizeMake(kScreenW-64-22, NSIntegerMax) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.sourceViewConstraintH.constant = sourcecontentRect.size.height + 36;
    self.sourceRepyLabel.text = @"原评论";
    self.sourcenameConstraintH.constant = 21;
    self.sourceReplyConstraintH.constant = 21;
    self.constraintSpace.constant = 0;
    if (self.reply.sourcenameid == 0) {
        self.sourceRepyLabel.text = @"";
        self.sourceViewConstraintH.constant = CGFLOAT_MIN;
        self.sourcenameConstraintH.constant = 0;
        self.sourceReplyConstraintH.constant = 0;
        self.constraintSpace.constant = 0;
    }
    UILabel *sourcecontentLabel = (UILabel *)[self.sourceView viewWithTag:2];
    sourcecontentLabel.text = self.reply.sourcecontent;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [self click];
}

- (IBAction)usernameClick:(UIButton *)sender {
    [self click];
}

- (void)click
{
    UIViewController *vc = (UIViewController *)self.delegate;
    UserMessageController *userMessageCtl = [[UserMessageController alloc] init];
    userMessageCtl.hidesBottomBarWhenPushed = YES;
    userMessageCtl.nameid = self.reply.nameid;
    [vc.navigationController pushViewController:userMessageCtl animated:YES];
}

@end
