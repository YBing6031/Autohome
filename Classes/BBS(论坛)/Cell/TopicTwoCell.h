//
//  TopicTwoCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Topic;
@interface TopicTwoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleConstraintH;
@property (weak, nonatomic) IBOutlet UILabel *lastreplydateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastreplydateConstraintW;
@property (weak, nonatomic) IBOutlet UILabel *postusernameReplynumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topictypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ispicImageView;
@property (nonatomic, strong) Topic *topic;

@property (nonatomic, assign) NSInteger type;//记录为最新发布 最后回复 精华帖的类型



@end
