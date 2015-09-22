//
//  Discover.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/15.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Discover : NSObject

/**"createtime": "2015/3/27 17:24:56",*/
@property (nonatomic, copy) NSString *createtime;
/**"iconurl": "http://baojia0.autoimg.cn/bj/2015031116/-1724086095_1426061497611.png",*/
@property (nonatomic, copy) NSString *iconurl;
/**"id": 14,*/
@property (nonatomic, assign) NSInteger id;

/**"pvkey": "v400_sale",*/
@property (nonatomic, copy) NSString *pvkey;
/**"pvname": "降价-活动",*/
@property (nonatomic, copy) NSString *pvname;
/**"showbubble": 0,*/
@property (nonatomic, assign) NSInteger showbubble;

/**"title": "活动&团购",*/
@property (nonatomic, copy) NSString *title;
/**"type": 2,*/
@property (nonatomic, assign) NSInteger type;

/**"url": "http://car.m.autohome.com.cn"*/
@property (nonatomic, copy) NSString *url;


@end
