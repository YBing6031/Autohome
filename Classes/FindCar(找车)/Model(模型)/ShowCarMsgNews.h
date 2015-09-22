//
//  ShowCarMsgNews.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowCarMsgNews : NSObject

/**"detail": "&nbsp;&nbsp;&nbsp; [汽车之家&nbsp;...",*/
@property (nonatomic, copy) NSString *detail;
/**"id": 871531,*/
@property (nonatomic, assign) NSInteger id;
/**"jumppage": 1,*/
@property (nonatomic, assign) NSInteger jumppage;
/**"lastid": "20150506142700871531",*/
@property (nonatomic, copy) NSString *lastid;
/**"newstype": 0,*/
@property (nonatomic, assign) NSInteger newstype;
/**"replycount": 1534,*/
@property (nonatomic, assign) NSInteger replycount;
/**"smallpic": "http://www0.autoimg.cn/zx/newspic/2015/5/6/120x90_0_2015050616372438943.jpg",*/
@property (nonatomic, copy) NSString *smallpic;
/**"time": "2015-05-06",*/
@property (nonatomic, copy) NSString *time;
/**"title": "售14.69万元 上海大众新款POLO GTI上市",*/
@property (nonatomic, copy) NSString *title;
/**"type": "新闻中心",*/
@property (nonatomic, copy) NSString *type;
/**"updatetime": "20150506163731"*/
@property (nonatomic, copy) NSString *updatetime;

@end
