//
//  Location.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/16.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject
@property (nonatomic, strong) CLLocationManager *locationMgr;
@property (nonatomic, strong) CLGeocoder *geocoder;//地理位置编码与反编码
+ (instancetype)locationWithDelegate:(id<CLLocationManagerDelegate>)delegate;

@end
