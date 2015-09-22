//
//  DealerMapController.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/17.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLocation, Dealer;
@interface DealerMapController : UIViewController

@property (nonatomic, strong) Dealer *dealer;

@property (nonatomic, copy) CLLocation *location;

@end
