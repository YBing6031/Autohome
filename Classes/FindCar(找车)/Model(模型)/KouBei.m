//
//  KouBei.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "KouBei.h"
#import "MJExtension.h"
#import "Engine.h"

@implementation KouBei

- (NSDictionary *)objectClassInArray
{
    return @{@"selllist":[Engine class],
             @"stoplist":[Engine class]};
}

@end
