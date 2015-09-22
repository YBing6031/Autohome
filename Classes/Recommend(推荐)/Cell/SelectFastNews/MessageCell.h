//
//  MessageCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Message;
@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *authornameBtn;
@property (weak, nonatomic) IBOutlet UIButton *headimgBtn;

@property (weak, nonatomic) IBOutlet UILabel *publishtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConstraintH;
@property (weak, nonatomic) IBOutlet UIView *attachmentsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attachmentsContraintH;
@property (weak, nonatomic) IBOutlet UIButton *upcountButton;
@property (weak, nonatomic) IBOutlet UIButton *replycountButton;


@property (nonatomic, strong) UIViewController *delegate;
@property (nonatomic, strong) Message *message;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end
