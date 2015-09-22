//
//  Live.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/4.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Live : NSObject

/**"album": "汽车旅馆",*/
@property (nonatomic, copy) NSString *album;
/**"albumid": 35,*/
@property (nonatomic, copy) NSString *albumid;
/**"anchor": "DJ程一",*/
@property (nonatomic, copy) NSString *anchor;
/**"endtime": "2015-06-04 22:00:00",*/
@property (nonatomic, copy) NSString *endtime;
/**"id": 1229,*/
@property (nonatomic, copy) NSString *id;
/**"programtime": "20:00 - 22:00",*/
@property (nonatomic, copy) NSString *programtime;
/**"radioinfourl": "http://live.fm.autohome.com.cn/auto.m3u8",*/
@property (nonatomic, copy) NSString *radioinfourl;
/**"radiopicurl": "http://www0.autoimg.cn/zx/newspic/RadioProPic/2015/4/24/200x0_0_2015042419284062619.jpg",*/
@property (nonatomic, copy) NSString *radiopicurl;
/**"starttime": "2015-06-04 20:00:00",*/
@property (nonatomic, copy) NSString *starttime;
/**"title": "和你聊得来的人"*/
@property (nonatomic, copy) NSString *title;


@end
