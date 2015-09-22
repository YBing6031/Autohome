//
//  Replycount.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reply : NSObject

/**"bigimageurl": "",*/
@property (nonatomic, copy) NSString *bigimageurl;
/**"carname": "马自达3 Axela昂克赛拉",*/
@property (nonatomic, copy) NSString *carname;
/**"content": "我发现大到世界风云，小到吃喝拉屎，再到bbs论坛，任何一条新闻都可以引起中国网民的对骂，唯独只有浏览黄色论坛的网民素质高，那里从来没见过骂人的，全部都是:楼主辛苦了，谢谢楼主，楼主好人一生平安",*/
@property (nonatomic, copy) NSString *content;
/**"floor": 51,*/
@property (nonatomic, assign) NSInteger floor;

/**"id": 47627272,*/
@property (nonatomic, assign) NSInteger id;
/**"imageid": 0,*/
@property (nonatomic, assign) NSInteger imageid;
/**"isadd": false,*/
@property (nonatomic, assign) BOOL isadd;
/**"isanchor": 0,*/
@property (nonatomic, assign) BOOL isanchor;
/**"isbusinessauth": 0,*/
@property (nonatomic, assign) BOOL isbusinessauth;
/**"iscarowner": 1,*/
@property (nonatomic, assign) BOOL iscarowner;
/**"issocialize": 0,*/
@property (nonatomic, assign) BOOL issocialize;
/**"name": "还是母乳喂养好",*/
@property (nonatomic, copy) NSString *name;
/**"nameid": 17955629,*/
@property (nonatomic, assign) NSInteger nameid;
/**"namepic": "http://i1.autoimg.cn/album/userheaders/2015/6/3/7c20741b-9a13-4ef6-8976-01785993bbdd_120X120.jpg",*/
@property (nonatomic, copy) NSString *namepic;
/**"smallimageurl": "",*/
@property (nonatomic, copy) NSString *smallimageurl;
/**"sourcecontent": "",*/
@property (nonatomic, copy) NSString *sourcecontent;
/**"sourceisanchor": 0,*/
@property (nonatomic, assign) BOOL sourceisanchor;
/**"sourcename": "",*/
@property (nonatomic, copy) NSString *sourcename;
/**"sourcenameid": 0,*/
@property (nonatomic, assign) NSInteger sourcenameid;
/**"sourceupcount": 0,*/
@property (nonatomic, assign) NSInteger sourceupcount;
/**"time": "1小时前",*/
@property (nonatomic, copy) NSString *time;
/**"upcount": 213*/
@property (nonatomic, assign) NSInteger upcount;

@end
