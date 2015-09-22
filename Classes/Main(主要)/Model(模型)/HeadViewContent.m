//
//  HeadViewContent.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "HeadViewContent.h"

@implementation HeadViewContent

+ (instancetype)headViewContentWithDictionary:(NSDictionary *)dict
{
    HeadViewContent *head = [[HeadViewContent alloc] init];
    [head setValuesForKeysWithDictionary:dict];
    return head;
}

+ (instancetype)headViewContentWithName:(NSString *)name
{
    HeadViewContent *head = [[HeadViewContent alloc] init];
    head.name = name;
    return head;
}

@end
