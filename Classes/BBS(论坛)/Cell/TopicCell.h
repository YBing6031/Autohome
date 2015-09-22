//
//  PostCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Topic;
@interface TopicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *posttimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bbsnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *replynumLabel;

@property (nonatomic, strong) Topic *topic;

@end
