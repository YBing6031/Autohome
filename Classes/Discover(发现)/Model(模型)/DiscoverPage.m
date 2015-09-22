//
//  DiscoverPage.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/15.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "DiscoverPage.h"
#import "MJExtension.h"
#import "DiscoverGroup.h"

@implementation DiscoverPage

- (NSDictionary *)objectClassInArray
{
    return @{@"list":[DiscoverGroup class]};
}

@end
