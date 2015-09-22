//
//  SpecTwoCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Spec;
@interface SpecTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *specnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UIView *gradeView;
@property (weak, nonatomic) IBOutlet UILabel *peoplenumLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gradeViewConstraintW;

@property (nonatomic, strong) Spec *spec;

@end
