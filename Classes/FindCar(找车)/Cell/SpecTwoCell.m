//
//  SpecTwoCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "SpecTwoCell.h"
#import "Spec.h"

@implementation SpecTwoCell

- (void)setSpec:(Spec *)spec
{
    _spec = spec;
    self.specnameLabel.text = spec.specname;
    self.gradeLabel.text = [NSString stringWithFormat:@"%@分", spec.grade];
    self.peoplenumLabel.text = [NSString stringWithFormat:@"%zi人参与评分", spec.peoplenum];
    self.gradeViewConstraintW.constant = 15*[spec.grade floatValue];
}

@end
