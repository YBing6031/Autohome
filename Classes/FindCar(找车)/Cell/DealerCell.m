//
//  DealerCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "DealerCell.h"
#import "Dealer.h"
#import "Manager.h"
#import <CoreLocation/CoreLocation.h>

@implementation DealerCell

- (void)setDealer:(Dealer *)dealer
{
    _dealer = dealer;
    self.shortnameLabel.text = dealer.shortname;
    self.addressLabel.text = dealer.address;
    self.orderrangeLabel.text = dealer.orderrange;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[dealer.lat doubleValue] longitude:[dealer.lon doubleValue]];
    Manager *manager = [Manager sharedManager];
    CLLocation *location1 = manager.location;
    CLLocationDistance distance = [location distanceFromLocation:location1];
    NSString *str = [NSString stringWithFormat:@"距离%.0fkm", distance/1000];
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    self.locationConsttraintW.constant = size.width;
    self.locationLabel.text = str;
}
- (IBAction)callClick:(UIButton *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.dealer.phone, nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.contentView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSString *phoneStr = [NSString stringWithFormat:@"tel://%@", self.dealer.phone];
        NSURL *url = [NSURL URLWithString:phoneStr];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
