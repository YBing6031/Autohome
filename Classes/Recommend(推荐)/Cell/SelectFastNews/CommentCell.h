//
//  CommentCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headimgBtn;
@property (weak, nonatomic) IBOutlet UIButton *usernameBtn;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConstraintH;

@property (nonatomic, strong)UIViewController *delegate;
@property (nonatomic, strong) Comment *comment;

@end
