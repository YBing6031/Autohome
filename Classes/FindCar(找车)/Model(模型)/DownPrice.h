//
//  DownPrice.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/16.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dealer;
@interface DownPrice : NSObject

/**"articleid": 30217868,*/
@property (nonatomic, assign) NSInteger articleid;

/**"articletype": 0,*/
@property (nonatomic, assign) NSInteger articletype;

/**"assellphone": null,*/
@property (nonatomic, copy) NSString *assellphone;
/**"dealer":{}*/
@property (nonatomic, strong) Dealer *dealer;
/**"dealerprice": "391.80",*/
@property (nonatomic, copy) NSString *dealerprice;
/**"enddate": "2015-06-30",*/
@property (nonatomic, copy) NSString *enddate;
/**"fctprice": "406.80",*/
@property (nonatomic, copy) NSString *fctprice;
/**"inventorystate": 0,*/
@property (nonatomic, assign) NSInteger inventorystate;

/**"ordercount": 1,*/
@property (nonatomic, assign) NSInteger ordercount;

/**"orderrange": "售全国",*/
@property (nonatomic, copy) NSString *orderrange;
/**"orderrangetitle": "可销往全国",*/
@property (nonatomic, copy) NSString *orderrangetitle;
/**"seriesid": 3382,*/
@property (nonatomic, assign) NSInteger seriesid;

/**"seriesname": "迈凯伦650S",*/
@property (nonatomic, copy) NSString *seriesname;
/**"specid": 18459,*/
@property (nonatomic, assign) NSInteger specid;

/**"specname": "2014款 3.8T Spider",*/
@property (nonatomic, copy) NSString *specname;
/**"specpic": "http://www.autoimg.cn/upload/2014/10/6/m_201410061351008897410.jpg",*/
@property (nonatomic, copy) NSString *specpic;
/**"specstatus": "",*/
@property (nonatomic, copy) NSString *specstatus;
/**"styledinventorystate": "http://x.autoimg.cn/dealer/minisite/images/icon/InventoryState0.png"*/
@property (nonatomic, copy) NSString *styledinventorystate;

@end
