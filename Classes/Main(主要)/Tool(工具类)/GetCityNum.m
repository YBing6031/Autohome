//
//  GetCityNum.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "GetCityNum.h"
#import "Province.h"
#import "City.h"
#import "MJExtension.h"

@interface GetCityNum()

@property (strong, nonatomic) NSMutableDictionary *provinceDict;

@end

@implementation GetCityNum

+ (NSDictionary *)getCityNum
{
    //获取城市编码............................
        NSMutableDictionary *provincemDict = [NSMutableDictionary dictionary];
        
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AHCache" ofType:@"plist"]];
        NSString *jsonStr = dict[@"allcity"];
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *provinces = dataDict[@"result"][@"provinces"];
        for (NSDictionary *provinceDict in provinces) {
            Province *province = [Province objectWithKeyValues:provinceDict];
            if (provincemDict[province.firstletter] == nil) {
                [provincemDict setObject:[NSMutableArray array] forKey:province.firstletter];
            }
            [provincemDict[province.firstletter] addObject:province];
        }
        NSArray *firstletterArr = [provincemDict allKeys];
        firstletterArr = [firstletterArr sortedArrayUsingSelector:@selector(compare:)];
    return @{@"provinceDict":provincemDict,
             @"firstletterArr":firstletterArr};
}

@end
