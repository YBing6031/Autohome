//
//  Information.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject

/**"isloadmore": true,*/
@property (nonatomic, assign) BOOL isloadmore;
/**"list":[]*/
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger rowcount;


@end
