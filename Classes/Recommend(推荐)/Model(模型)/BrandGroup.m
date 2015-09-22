//
//  BrandGroup.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "BrandGroup.h"
#import "MJExtension.h"
#import "Brand.h"

@implementation BrandGroup

- (NSDictionary *)objectClassInArray {
    return @{@"list":[Brand class]};
}

@end
