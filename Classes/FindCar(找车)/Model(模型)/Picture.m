//
//  Picture.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Picture.h"
#import "CategoryMe.h"
#import "Color.h"
#import "Defaultpic.h"
#import "MJExtension.h"
#import "Spec.h"
#import "Image.h"

@implementation Picture

- (NSDictionary *)objectClassInArray
{
    return @{@"categorylist":[CategoryMe class],
             @"colorlist":[Color class],
             @"defaultpiclist":[Defaultpic class],
             @"speclist":[Spec class],
             @"piclist":[Image class]};
}

@end
