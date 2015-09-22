//
//  DiscoverGroup.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/15.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "DiscoverGroup.h"
#import "MJExtension.h"
#import "Discover.h"

@implementation DiscoverGroup

- (NSDictionary *)objectClassInArray
{
    return @{@"list":[Discover class]};
}

@end
