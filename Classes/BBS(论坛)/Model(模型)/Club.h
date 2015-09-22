//
//  Club.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Club : NSObject

/**"clubid": 145,*/
@property (nonatomic, assign) NSInteger clubid;

/**"list":[]*/
@property (nonatomic, strong) NSMutableArray *list;
/**"pagecount": 6350,*/
@property (nonatomic, assign) NSInteger pagecount;

/**"pageindex": 1,*/
@property (nonatomic, assign) NSInteger pageindex;

/**"rowcount": 317468*/
@property (nonatomic, assign) NSInteger rowcount;


@end
