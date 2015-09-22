//
//  Car.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Car.h"
#import "MJExtension.h"
#import "Engine.h"
#import "Param.h"

@implementation Car

- (NSDictionary *)objectClassInArray
{
    return @{@"enginelist":[Engine class],
             @"paramlist":[Param class],
             @"spectype":[Param class]};
}

@end
