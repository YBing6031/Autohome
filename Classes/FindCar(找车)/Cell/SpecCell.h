//
//  EngineCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Spec;
@interface SpecCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *minpriceConstraintW;
@property (weak, nonatomic) IBOutlet UILabel *minpriceLabel;

@property (nonatomic, strong) Spec *spec;

@end
