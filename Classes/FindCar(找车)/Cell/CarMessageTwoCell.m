//
//  CarMessageTwoCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "CarMessageTwoCell.h"
#import "Car.h"
@implementation CarMessageTwoCell

- (void)setCar:(Car *)car
{
    _car = car;
    self.nameLabel.text = car.name;
    self.fctpriceLabel.text = car.fctprice;
}

@end
