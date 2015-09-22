//
//  Province.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/9.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Province.h"
#import "MJExtension.h"
#import "City.h"

@implementation Province

- (NSDictionary *)objectClassInArray
{
    return @{@"citys":[City class]};
}

@end
