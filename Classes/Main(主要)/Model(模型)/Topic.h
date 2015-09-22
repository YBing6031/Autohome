//
//  Top.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

/**"bbsid": 740,*/
@property (nonatomic, assign) NSInteger bbsid;

/**"bbsname": "奥迪A7论坛",*/
@property (nonatomic, copy) NSString *bbsname;
/**"bbstype": "c",*/
@property (nonatomic, copy) NSString *bbstype;
/**"posttime": "2015-04-20",*/
@property (nonatomic, copy) NSString *posttime;
/**"replynum": 6,*/
@property (nonatomic, assign) NSInteger replynum;

/**"title": "A7 18寸轮毂加胎 一千公里拆的 有需要的吗？",*/
@property (nonatomic, copy) NSString *title;
/**"topicid": 40567060,*/
@property (nonatomic, assign) NSInteger topicid;

/**"topictype": ""*/
@property (nonatomic, copy) NSString *topictype;



/**"lastreplydate": "2分钟前",*/
@property (nonatomic, copy) NSString *lastreplydate;
/**"postmemberid": 0,*/
@property (nonatomic, assign) NSInteger postmemberid;

/**"postusername": "唐小超",*/
@property (nonatomic, copy) NSString *postusername;
/**"replycounts": 324,*/
@property (nonatomic, assign) NSInteger replycounts;

/**"smallpic": "http://club0.autoimg.cn/album/images/2015/06/09/240180_c198e73a-ddbe-4c9b-8000-78186a3ffe73.jpg",*/
@property (nonatomic, copy) NSString *smallpic;
/**"views": 117442*/
@property (nonatomic, assign) NSInteger views;



/**"isclosed": 0,*/
@property (nonatomic, assign) BOOL isclosed;
/**"isopuptopic": 0,*/
@property (nonatomic, assign) BOOL isopuptopic;
/**"ispic": 1,*/
@property (nonatomic, assign) BOOL ispic;
/**"isview": 0,*/
@property (nonatomic, assign) BOOL isview;
/**"posttopicdate": "1个月前",*/
@property (nonatomic, copy) NSString *posttopicdate;

@end
