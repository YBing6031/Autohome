//
//  Car.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

/**"2sccount": 43,二手车*/
@property (nonatomic, assign) NSInteger sc2count;

/**"alibicount": 0,*/
@property (nonatomic, assign) NSInteger alibicount;

/**"brandid": 3,*/
@property (nonatomic, assign) NSInteger brandid;

/**"carmallurl": "http://mall.autohome.com.cn/list/0-110100-3-111-0-0-0-0-0-1.html#pvareaid=103236",*/
@property (nonatomic, copy) NSString *carmallurl;
/**"clubid": 111,*/
@property (nonatomic, assign) NSInteger clubid;

/**"dealercount": 23,*/
@property (nonatomic, assign) NSInteger dealercount;

/**"enginelist":[]*/
@property (nonatomic, strong) NSArray *enginelist;

/**"fctprice": "6.98-11.28万",*/
@property (nonatomic, copy) NSString *fctprice;
/**"hascarmall": 1,*/
@property (nonatomic, assign) NSInteger hascarmall;

/**"koubeiscore": "4.37",*/
@property (nonatomic, copy) NSString *koubeiscore;
/**"levelname": "小型车",*/
@property (nonatomic, copy) NSString *levelname;
/**"logo": "http://car0.autoimg.cn/upload/2014/5/8/w_201405080323585164971.jpg",*/
@property (nonatomic, copy) NSString *logo;
/**"lowprice": "4.58",*/
@property (nonatomic, copy) NSString *lowprice;
/**"name": "威驰",*/
@property (nonatomic, copy) NSString *name;
/**"paramlist":[]*/
@property (nonatomic, strong) NSArray *paramlist;
/**"piccount": 4333,*/
@property (nonatomic, assign) NSInteger piccount;

/**"spectype":[]*/
@property (nonatomic, strong) NSArray *spectype;
/**"stopsellcarnum": 0*/
@property (nonatomic, assign) NSInteger stopsellcarnum;




@end
