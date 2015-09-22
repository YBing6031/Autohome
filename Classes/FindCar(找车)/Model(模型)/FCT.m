//
//  FCT.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "FCT.h"
#import "MJExtension.h"
#import "Serie.h"

@implementation FCT

- (NSDictionary *)objectClassInArray
{
    return @{@"serieslist":[Serie class]};
}

@end
