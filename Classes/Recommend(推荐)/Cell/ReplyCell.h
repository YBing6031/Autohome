//
//  ReplycountCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reply;
@interface ReplyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *vip;

@property (weak, nonatomic) IBOutlet UIImageView *namepicImageView;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceReplyConstraintH;
@property (weak, nonatomic) IBOutlet UILabel *sourceRepyLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSpace;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourcenameConstraintH;

@property (weak, nonatomic) IBOutlet UIView *sourceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceViewConstraintH;

@property (weak, nonatomic) IBOutlet UILabel *carnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *upcountbtn;

@property (nonatomic, strong) Reply *reply;
@property (nonatomic, strong) id delegate;

@end
