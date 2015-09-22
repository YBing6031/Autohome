//
//  DefaultpicCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Defaultpic;
@interface DefaultpicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintW;

@property (nonatomic, strong) Defaultpic *defaultpic;

@property (nonatomic, strong) UIViewController *delegate;
@property (nonatomic, copy) NSString *allImageURL;

@end
