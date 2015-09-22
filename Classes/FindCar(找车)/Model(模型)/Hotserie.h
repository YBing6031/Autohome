//
//  Hotserie.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotserie : NSObject

/**"img": "http://car0.autoimg.cn/upload/2014/8/6/s_20140806072335496497111.jpg",*/
@property (nonatomic, copy) NSString *img;
/**"ordercount": 55877,*/
@property (nonatomic, assign) NSInteger ordercount;

/**"price": "7.59-15.89万",*/
@property (nonatomic, copy) NSString *price;
/**"seriesid": 145,*/
@property (nonatomic, assign) NSInteger seriesid;

/**"seriesname": "POLO"*/
@property (nonatomic, copy) NSString *seriesname;


@end
