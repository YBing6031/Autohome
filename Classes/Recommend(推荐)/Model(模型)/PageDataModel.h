//
//  PageDataModel.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Headlineinfo;
@interface PageDataModel : NSObject

@property (nonatomic, strong) NSArray *focusimg;
@property (nonatomic, strong) NSMutableArray *newslist;
@property (nonatomic, strong) Headlineinfo *headlineinfo;

+ (instancetype)pageDataModelWithDictionary:(NSDictionary *)dict;

@end
