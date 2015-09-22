//
//  NewsCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
@class News, Movie, Shuoke, Headlineinfo, Topic, ShowCarMsgNews;

@interface NewsCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *bobaozhongLabel;
@property (weak, nonatomic) IBOutlet UILabel *shuokeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *smallpicImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *replycountLabel;

@property (nonatomic, strong) News *news;
@property (nonatomic, strong) Movie *movie;
@property (nonatomic, strong) Shuoke *shuoke;
@property (nonatomic, strong) Headlineinfo *headlineinfo;
@property (nonatomic, strong) Topic *topic;

@property (nonatomic, strong) ShowCarMsgNews *showCarMsgNews;

@end
