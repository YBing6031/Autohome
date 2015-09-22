//
//  Hotsaleserie.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Hotsaleserie.h"
#import "MJExtension.h"
#import "Hotserie.h"

@implementation Hotsaleserie

- (NSDictionary *)objectClassInArray
{
    return @{@"hotseries":[Hotserie class]};
}

@end
