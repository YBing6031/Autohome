//
//  HeadViewContent.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadViewContent : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *value;

+ (instancetype)headViewContentWithDictionary:(NSDictionary *)dict;

+ (instancetype)headViewContentWithName:(NSString *)name;

@end
