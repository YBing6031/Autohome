//
//  Engine.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Engine.h"
#import "MJExtension.h"
#import "Spec.h"

@implementation Engine

- (NSDictionary *)objectClassInArray
{
    return @{@"speclist":[Spec class],
             @"specs":[Spec class]};
}

@end
