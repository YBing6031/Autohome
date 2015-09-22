//
//  ShowCarMsgController.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Serie, Hotserie;
#define AddColletNotificationName @"AddColletNotificationName"
#define CacelColletNotificationName @"CacelColletNotificationName"
@interface ShowCarMsgController : UIViewController

@property (nonatomic, assign) NSInteger seriesid;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *imgurl;

@property (nonatomic, strong) Serie *serie;
@property (nonatomic, strong) Hotserie *hotserie;
@end
