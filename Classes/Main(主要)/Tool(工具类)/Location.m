//
//  Location.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/16.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)initWithDelegate:(id<CLLocationManagerDelegate>)delegate
{
    self = [super init];
    if (self) {
        _geocoder = [[CLGeocoder alloc] init];
        
        _locationMgr = [[CLLocationManager alloc] init];
        //定位精度 精度越高 定位所需时间越长
        _locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
        //重新定位所需移动的最小距离  kCLDistanceFilterNone表示任意的距离移动都会导致重新定位
        _locationMgr.distanceFilter = kCLDistanceFilterNone;
        _locationMgr.delegate = delegate;
        //开始更新地理位置
        if ([CLLocationManager locationServicesEnabled]) {
            //请求用户授权
            [_locationMgr requestAlwaysAuthorization];
            //开始定位
            [_locationMgr startUpdatingLocation];
        } else {
            NSLog(@"location service not enabled!");
        }
    }
    return self;
}

+ (instancetype)locationWithDelegate:(id<CLLocationManagerDelegate>)delegate
{
    return [[[self class] alloc] initWithDelegate:delegate];
}


@end
