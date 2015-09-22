//
//  Dealer.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dealer : NSObject

/**"address": "深圳市福田区卓越时代广场二期裙楼商业01层20-21号 （阿斯顿马丁  深圳）",*/
@property (nonatomic, copy) NSString *address;
/**"city": "深圳",*/
@property (nonatomic, copy) NSString *city;
/**"cityid": 440300,*/
@property (nonatomic, assign) NSInteger cityid;
/**"countyid": 440304,*/
@property (nonatomic, assign) NSInteger countyid;

/**"id": 84227,*/
@property (nonatomic, assign) NSInteger id;

/**"is24hour": 1,*/
@property (nonatomic, assign) BOOL is24hour;
/**"is400": 1,*/
@property (nonatomic, assign) BOOL is400;
/**"isauth": 1,*/
@property (nonatomic, assign) BOOL isauth;
/**"iscloseorder": 1,*/
@property (nonatomic, assign) BOOL iscloseorder;
/**"ishavelowprice": 0,*/
@property (nonatomic, assign) BOOL ishavelowprice;
/**"ispromotion": 1,*/
@property (nonatomic, assign) BOOL ispromotion;
/**"lat": "22.539421",*/
@property (nonatomic, copy) NSString *lat;

/**"lon": "114.064819",*/
@property (nonatomic, copy) NSString *lon;
/**"loworminprice": "358.88",*/
@property (nonatomic, copy) NSString *loworminprice;
/**"name": "阿斯顿马丁  深圳",*/
@property (nonatomic, copy) NSString *name;
/**"newsid": 26126615,*/
@property (nonatomic, assign) NSInteger newsid;

/**"newstitle": "2014款最新款 Rapide S 深圳店优惠巨大",*/
@property (nonatomic, copy) NSString *newstitle;
/**"newstype": 2,*/
@property (nonatomic, assign) NSInteger newstype;

/**"orderrange": "售全国",*/
@property (nonatomic, copy) NSString *orderrange;
/**"oriormaxprice": "428.00",*/
@property (nonatomic, copy) NSString *oriormaxprice;
/**"phone": "4009729313",*/
@property (nonatomic, copy) NSString *phone;
/**"phonestyled": "<span class=\"dealer_400_wrap\"><span class=\"dealer_400_big\" style=\"color:#D60000;font-family:Arial;font-weight:700;\">400-872-9313</span><img class=\"dealer_400_icon\" style=\"width:14px;height:14px;margin-left:5px;padding-bottom:4px;vertical-align:middle;border:0\" title=\"汽车之家认证电话，请您放心拨打！\" src=\"http://x.autoimg.cn/dealer/minisite/images/20120801/icon/check.gif?20120717A\" /><img class=\"dealer_400_icon2\" style=\"width:23px;height:13px;margin-left:3px;padding-bottom:5px;vertical-align:middle;border:0\" title=\"24小时恭候致电！\" src=\"http://x.autoimg.cn/dealer/minisite/images/20130115/icon/24h.gif\" /><img class=\"dealer_400_icon2\" style=\"width:34px;height:13px;margin-left:3px;padding-bottom:5px;vertical-align:middle;border:0;float:none;\" title=\"可销往全国\" src=\"http://x.autoimg.cn/dealer/openapi/images/order/0.png\" /></span>",*/
@property (nonatomic, copy) NSString *phonestyled;
/**"price": "",*/
@property (nonatomic, copy) NSString *price;
/**"provinceid": 440000,*/
@property (nonatomic, assign) NSInteger provinceid;

/**"publishtime": "1999/01/01 00:00:00",*/
@property (nonatomic, copy) NSString *publishtime;
/**"saleprice": "",*/
@property (nonatomic, copy) NSString *saleprice;
/**"scopename": "4s",*/
@property (nonatomic, copy) NSString *scopename;
/**"scopestatus": 1,*/
@property (nonatomic, assign) NSInteger scopestatus;

/**"seriesid": 923,*/
@property (nonatomic, assign) NSInteger seriesid;

/**"seriesname": "Rapide",*/
@property (nonatomic, copy) NSString *seriesname;
/**"shortname": "深圳庞大新贵",*/
@property (nonatomic, copy) NSString *shortname;
/**"teltext": "立即拨打"*/
@property (nonatomic, copy) NSString *teltext;


@end
