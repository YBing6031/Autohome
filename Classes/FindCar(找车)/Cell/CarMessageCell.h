//
//  CarMessageCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CarMessageCellBlock)(NSInteger);
@class Car, ShowCarMsgController;
@interface CarMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *koubeiscoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealercountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealercountLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowpriceLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *sc2countLabel;
@property (weak, nonatomic) IBOutlet UILabel *sc2countLocationLabel;
@property (weak, nonatomic) IBOutlet UIButton *isSaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopSaleBtn;

@property (nonatomic, strong) Car *car;
@property (nonatomic, strong) CarMessageCellBlock block;

@property (nonatomic, strong) ShowCarMsgController *delegate;

- (void)setCar:(Car *)car delegate:(CarMessageCellBlock)block;

@end
