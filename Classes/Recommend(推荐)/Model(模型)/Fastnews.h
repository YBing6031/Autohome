//
//  Fastnews.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fastnews : NSObject

/**"advancetime": "2015-06-05",*/
@property (nonatomic, copy) NSString *advancetime;
/**"bgimage": "http://app0.autoimg.cn/zx/newspic/Broadcast/2015/6/5/2015060510182259448.jpg",*/
@property (nonatomic, copy) NSString *bgimage;
/**"createtime": "2015-06-05",*/
@property (nonatomic, copy) NSString *createtime;
/**"id": 76,*/
@property (nonatomic, assign) NSInteger id;
/**"img": "http://app0.autoimg.cn/zx/newspic/Broadcast/2015/6/5/2015060510181860068.jpg",*/
@property (nonatomic, copy) NSString *img;
/**"lastid": "20150605100000000176",*/
@property (nonatomic, copy) NSString *lastid;
/**"publishtiptime": "1433469600",*/
@property (nonatomic, copy) NSString *publishtiptime;
/**"reviewcount": 383333,*/
@property (nonatomic, assign) NSInteger reviewcount;
/**"state": 1,*/
@property (nonatomic, assign) NSInteger state;
/**"title": "2015款大众辉腾试驾",*/
@property (nonatomic, copy) NSString *title;
/**"typeid": 3,*/
@property (nonatomic, assign) NSInteger typeid;
/**"typename": "试驾评测快报"*/
@property (nonatomic, copy) NSString *typename;



@end
