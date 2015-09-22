//
//  Brand.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Brand.h"

@implementation Brand

+ (instancetype)brandWithName:(NSString *)name imgurl:(NSString *)imgurl
{
    Brand *brand = [[Brand alloc] init];
    brand.name = name;
    brand.imgurl = imgurl;
    return brand;
}

@end
