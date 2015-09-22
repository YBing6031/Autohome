//
//  MessageCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "MessageCell.h"
#import "Message.h"
#import "Attachment.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UserMessageController.h"

@implementation MessageCell
- (IBAction)showUserMessage:(UIButton *)sender {
    UserMessageController *userMessageCtl = [[UserMessageController alloc] init];
    userMessageCtl.nameid = self.message.memberid;
    [self.delegate.navigationController pushViewController:userMessageCtl animated:YES];
}

- (void)setMessage:(Message *)message
{
    _message = message;
    [self.authornameBtn setTitle:message.authorname forState:UIControlStateNormal];
    if (message.headimg.length) {
        [self.headimgBtn sd_setImageWithURL:[NSURL URLWithString:message.headimg] forState:UIControlStateNormal];
    }
    self.publishtimeLabel.text = message.publishtime;
    
    //计算content的高度
    CGRect contentRect = [message.content boundingRectWithSize:CGSizeMake(kScreenW-30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.contentConstraintH.constant = contentRect.size.height;
    self.contentLabel.text = message.content;
    
    [self.upcountButton setTitle:[NSString stringWithFormat:@"%zi", message.upcount] forState:UIControlStateNormal];
    [self.replycountButton setTitle:[NSString stringWithFormat:@"%zi", message.replycount] forState:UIControlStateNormal];
    //显示图片
    [self showImage];
    
    //设置边框
    [self setBorder];
}

- (void)setBorder
{
    self.upcountButton.layer.borderColor = RGB(220, 220, 220).CGColor;
    self.upcountButton.layer.borderWidth = 1;
    self.replycountButton.layer.borderWidth = 1;
    self.replycountButton.layer.borderColor = RGB(220, 220, 220).CGColor;
    self.shareButton.layer.borderWidth = 1;
    self.shareButton.layer.borderColor = RGB(220, 220, 220).CGColor;
}

- (void)showImage
{
    [self.attachmentsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray *attachments = self.message.attachments;
    int count = (int)attachments.count;
    int sumH = 0;
    for (int i = 0; i < count; i++)
    {
        Attachment *attachment = attachments[i];
        CGFloat imageH = self.attachmentsView.width*attachment.height/attachment.width;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, sumH, kScreenW-30, imageH)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:attachment.picurl]];
        sumH += imageH+5;
        [self.attachmentsView addSubview:imageView];
    }
    self.attachmentsContraintH.constant = sumH;
}

@end
