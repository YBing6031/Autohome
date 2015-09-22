//
//  SerieTwo.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/15.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SerieTwo : NSObject

/**"brandid": 38,*/
@property (nonatomic, assign) NSInteger brandid;

/**"brandname": "别克",*/
@property (nonatomic, copy) NSString *brandname;
/**"count": 8,*/
@property (nonatomic, assign) NSInteger count;

/**"id": 3554,*/
@property (nonatomic, assign) NSInteger id;

/**"img": "http://car0.autoimg.cn/upload/2014/9/10/s_20140910144854416371011.jpg",*/
@property (nonatomic, copy) NSString *img;
/**"level": "中型SUV",*/
@property (nonatomic, copy) NSString *level;
/**"name": "通用别克-昂科威",*/
@property (nonatomic, copy) NSString *name;
/**"price": "21.99-34.99万",*/
@property (nonatomic, copy) NSString *price;
/**"seriesname": "昂科威",*/
@property (nonatomic, copy) NSString *seriesname;
/**"specitemgroups":[]*/
@property (nonatomic, strong) NSMutableArray *specitemgroups;
@end
