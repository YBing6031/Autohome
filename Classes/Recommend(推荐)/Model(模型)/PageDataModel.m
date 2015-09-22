//
//  PageDataModel.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "PageDataModel.h"
#import "MJExtension.h"
#import "Focusimg.h"
#import "News.h"

@implementation PageDataModel

- (NSDictionary *)objectClassInArray;
{
    return @{@"focusimg":[Focusimg class],
             @"newslist":[News class]};
}

+ (instancetype)pageDataModelWithDictionary:(NSDictionary *)dict
{
    PageDataModel *model = [PageDataModel objectWithKeyValues:dict];
    return model;
}

@end
