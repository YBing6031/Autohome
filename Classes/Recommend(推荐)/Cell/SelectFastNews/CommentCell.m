//
//  CommentCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "CommentCell.h"
#import "Comment.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UserMessageController.h"

@implementation CommentCell

- (IBAction)showUserMessage:(UIButton *)sender {
    
    UserMessageController *userMessageCtl = [[UserMessageController alloc] init];
    userMessageCtl.nameid = self.comment.userid;
    [self.delegate.navigationController pushViewController:userMessageCtl animated:YES];
}


- (void)setComment:(Comment *)comment
{
    _comment = comment;
    if (comment.headimg.length) {
        [self.headimgBtn sd_setImageWithURL:[NSURL URLWithString:comment.headimg] forState:UIControlStateNormal];
    }
    [self.usernameBtn setTitle:comment.username forState:UIControlStateNormal];
    //计算content的高度
    CGRect contentRect = [comment.content boundingRectWithSize:CGSizeMake(kScreenW-30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    self.contentConstraintH.constant = contentRect.size.height;
    
    self.contentLabel.text = comment.content;
    
    
}

@end
