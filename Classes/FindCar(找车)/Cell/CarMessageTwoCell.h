//
//  CarMessageTwoCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car;
@interface CarMessageTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fctpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) Car *car;
@end
