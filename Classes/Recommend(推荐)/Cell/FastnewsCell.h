//
//  FastnewsCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
@class News;
@interface FastnewsCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *smallpicImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bobaozhongLabel;

@property (nonatomic, strong) News *news;

@end
