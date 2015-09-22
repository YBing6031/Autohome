//
//  DefaultpicCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "DefaultpicCell.h"
#import "Defaultpic.h"
#import "ImageButton.h"
#import "SeeAllImageController.h"

@implementation DefaultpicCell

- (void)setDefaultpic:(Defaultpic *)defaultpic
{
    _defaultpic = defaultpic;
    CGSize size = [defaultpic.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.nameConstraintW.constant = size.width;
    self.nameLabel.text = defaultpic.name;
    self.totalLabel.text = [NSString stringWithFormat:@"%zi张", defaultpic.total];
    for (int i = 0; i < defaultpic.list.count; i++)
    {
        ImageButton *btn = (ImageButton *)[self.contentView viewWithTag:i+1];
        
        btn.image = defaultpic.list[i];
    }
    
}

- (IBAction)seeAllImageClick:(UIButton *)sender {
    
    SeeAllImageController *seeVC = [[SeeAllImageController alloc] init];
    seeVC.allImageURL = self.allImageURL;
    seeVC.navigationItem.title = self.defaultpic.name;
    [self.delegate.navigationController pushViewController:seeVC animated:YES];
    
}

@end
