//
//  HotserieCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hotserie, Serie;
@interface HotserieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgImageView;
@property (weak, nonatomic) IBOutlet UILabel *seriesnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) Hotserie *hotserie;
@property (nonatomic, strong) Serie *serie;
@end
