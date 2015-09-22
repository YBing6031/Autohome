//
//  Topiclist.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Topiclist.h"
#import "Topic.h"
#import "MJExtension.h"

@implementation Topiclist

- (NSDictionary *)objectClassInArray
{
    return @{@"list":[Topic class]};
}

@end
