//
//  Specitemgroup.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/15.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Specitemgroup.h"
#import "MJExtension.h"
#import "Spec.h"

@implementation Specitemgroup

- (NSDictionary *)objectClassInArray
{
    return @{@"specitems":[Spec class]};
}

@end
