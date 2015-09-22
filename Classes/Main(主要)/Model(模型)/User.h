//
//  User.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topiclist, Unreadnum;
@interface User : NSObject

/**"allowpost": 1,*/
@property (nonatomic, assign) NSInteger allowpost;

/**"areaname": "河北 保定",*/
@property (nonatomic, copy) NSString *areaname;

/**"authority": 0,*/
@property (nonatomic, assign) NSInteger authority;

/**"carid": 0,*/
@property (nonatomic, assign) NSInteger carid;

/**"cityname": "",*/
@property (nonatomic, copy) NSString *cityname;
/**"integral": 291,*/
@property (nonatomic, assign) NSInteger integral;

/**"isbusinessauth": 0,*/
@property (nonatomic, assign) BOOL isbusinessauth;
/**"iscarowner": 1,*/
@property (nonatomic, assign) BOOL iscarowner;
/**"isphoneauth": 1,*/
@property (nonatomic, assign) BOOL isphoneauth;
/**"maxpic": "http://i0.autoimg.cn/album/userheaders/2015/5/31/d8d816bf-3942-4d2e-a001-2f9b9f2929e4_120X120.jpg",*/
@property (nonatomic, copy) NSString *maxpic;
/**"medalslist": [
],*/
@property (nonatomic, strong) NSArray *medalslist;
/**"medalsnum": 0,*/
@property (nonatomic, assign) NSInteger medalsnum;

/**"memberid": 0,*/
@property (nonatomic, assign) NSInteger memberid;

/**"minpic": "http://i0.autoimg.cn/album/userheaders/2015/5/31/d8d816bf-3942-4d2e-a001-2f9b9f2929e4_120X120.jpg",*/
@property (nonatomic, copy) NSString *minpic;
/**"mycarname": "奥迪A7",*/
@property (nonatomic, copy) NSString *mycarname;
/**"name": "MRSAMG",*/
@property (nonatomic, copy) NSString *name;
/**"provincename": "",*/
@property (nonatomic, copy) NSString *provincename;
/**"regtime": "2011-11-27",*/
@property (nonatomic, copy) NSString *regtime;
/**"sex": "男",*/
@property (nonatomic, copy) NSString *sex;
/**"stampcount": 0,*/
@property (nonatomic, assign) NSInteger stampcount;

/**"topiclist":*/
@property (nonatomic, strong) Topiclist *topiclist;
/**"unreadnum": {
    "list": [
    ]
},*/
@property (nonatomic, strong) Unreadnum *unreadnum;
/**"userid": 4517137*/
@property (nonatomic, assign) NSInteger userid;



@end
