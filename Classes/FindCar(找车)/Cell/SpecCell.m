//
//  EngineCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "SpecCell.h"
#import "Spec.h"

@implementation SpecCell

- (void)setSpec:(Spec *)spec
{
    _spec = spec;
    self.nameLabel.text = spec.name;
    
    CGSize priceSize = [spec.minprice sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    self.minpriceConstraintW.constant = priceSize.width;
    self.priceLabel.text = spec.price;
    self.minpriceLabel.text = spec.minprice;
    

    
}



- (IBAction)buyCarComputationClick:(UIButton *)sender {
}
- (IBAction)addComparisonClick:(UIButton *)sender {
}
- (IBAction)askMinpriceClick:(UIButton *)sender {
}

@end
