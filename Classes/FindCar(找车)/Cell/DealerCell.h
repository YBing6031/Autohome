//
//  DealerCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dealer;
@interface DealerCell : UITableViewCell<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *shortnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderrangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationConsttraintW;

@property (nonatomic, strong) Dealer *dealer;

@end
