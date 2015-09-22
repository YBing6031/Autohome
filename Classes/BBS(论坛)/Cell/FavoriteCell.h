//
//  FavoriteCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ico;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitile;

- (void)setIco:(NSString *)ico title:(NSString *)title subTitle:(NSString *)subTitle;

@end
