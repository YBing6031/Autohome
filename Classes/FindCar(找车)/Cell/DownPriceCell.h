//
//  DownPriceCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/14.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownPrice;
@interface DownPriceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *specpicImageView;
@property (weak, nonatomic) IBOutlet UILabel *seriesnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *downPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealerpriceLabel;


@property (nonatomic, strong) DownPrice *downPrice;
@end
