//
//  BrandCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Brand, Discover;
@interface BrandCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgurlImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) Brand *brand;
@property (nonatomic, strong) Brand *customBrand;
@end
