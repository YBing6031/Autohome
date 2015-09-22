//
//  CarMessageCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "CarMessageCell.h"
#import "Car.h"
#import "Net.h"
#import "ShowCarMsgController.h"


@implementation CarMessageCell

- (void)setCar:(Car *)car
{
    _car = car;
    self.koubeiscoreLabel.text = [NSString stringWithFormat:@"%@ 分", car.koubeiscore];
    self.dealercountLabel.text = [NSString stringWithFormat:@"%zi 家", car.dealercount];
    self.lowpriceLabel.text = [NSString stringWithFormat:@"%@ 万起", car.lowprice];
    self.sc2countLabel.text = [NSString stringWithFormat:@"%zi 辆", car.sc2count];
    
    [self addbgViewWithframe:CGRectMake(0, 33, kScreenW, 1)];
    [self addbgViewWithframe:CGRectMake(0, 37+80, kScreenW, 1)];
    [self addbgViewWithframe:CGRectMake(0, 37+80*2, kScreenW, 1)];
    [self addbgViewWithframe:CGRectMake(kScreenW/2, 33, 1, 80*2+4)];
    
    
    for (int i = 0; i < 4; i++)
    {
        UIView *view = [self.contentView viewWithTag:i+1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:tap];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    ShowCarMsgController *vc = self.delegate;
    UIScrollView *scorllView = [vc valueForKey:@"tableScrollView"];
    if (tag == 1) {
        [scorllView setContentOffset:CGPointMake(kScreenW*4, 0) animated:YES];
    } else if (tag == 2) {
        [scorllView setContentOffset:CGPointMake(kScreenW*2, 0) animated:YES];
    }
}

- (void)addbgViewWithframe:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = RGB(250, 250, 250);
    [self addSubview:view];
}

- (void)setCar:(Car *)car delegate:(CarMessageCellBlock)block
{
    self.car = car;
    self.block = block;
}

- (IBAction)isSaleClick:(UIButton *)sender {
    sender.selected = YES;
    self.stopSaleBtn.selected = NO;
    if (self.block) {
        self.block(sender.tag-1);
    }
    
}
- (IBAction)stopSaleClick:(UIButton *)sender {
    
    sender.selected = YES;
    self.isSaleBtn.selected = NO;
    
    if (self.block) {
        self.block(sender.tag-1);
    }
}

@end
