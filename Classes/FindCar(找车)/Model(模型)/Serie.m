//
//  Serie.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Serie.h"

@implementation Serie

+ (instancetype)serieWithID:(NSInteger)ID name:(NSString *)name price:(NSString *)price imgurl:(NSString *)imgurl
{
    Serie *serie = [[Serie alloc] init];
    serie.id = ID;
    serie.name = name;
    serie.price = price;
    serie.imgurl = imgurl;
    return serie;
}

@end
