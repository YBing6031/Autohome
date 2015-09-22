//
//  FastnewsTwoCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
@class Fastnews;
@interface FastnewsTwoCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *typenameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bobaozhongLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewcountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgImageView;
@property (weak, nonatomic) IBOutlet UILabel *createtimeLabel;

@property (nonatomic, strong) Fastnews *fastnews;
@property (weak, nonatomic) IBOutlet UILabel *bobaoEndLabel;

@end
