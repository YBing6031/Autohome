//
//  Manage.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Metalist, CLLocation;
@interface Manager : NSObject

+ (id)sharedManager;
@property (nonatomic, strong) Metalist *metalist;
@property (nonatomic, strong) CLLocation *location;
@end
