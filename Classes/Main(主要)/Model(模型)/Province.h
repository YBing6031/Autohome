//
//  Province.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/9.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *citys;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *firstletter;

@end
