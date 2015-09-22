//
//  Topiclist.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topiclist : NSObject

/**"list":*/
@property (nonatomic, strong) NSMutableArray *list;
/**"pagecount": 1,*/
@property (nonatomic, assign) NSInteger pagecount;

/**"pageindex": 1,*/
@property (nonatomic, assign) NSInteger pageindex;

/**"rowcount": 7*/
@property (nonatomic, assign) NSInteger rowcount;

/**"clubid": 200009,*/
@property (nonatomic, assign) NSInteger clubid;


@end
