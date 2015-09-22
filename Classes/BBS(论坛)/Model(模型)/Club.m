//
//  Club.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Club.h"
#import "MJExtension.h"
#import "Topic.h"

@implementation Club

- (NSDictionary *)objectClassInArray
{
    return @{@"list":[Topic class]};
}

@end
