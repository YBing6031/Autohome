//
//  News.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *smallpic;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, assign) NSInteger replycount;
/**mediatype==6显示ImageNewsCell 图片的地址是indexdetail
 mediatype==1 表示为新闻
 mediatype==2 表示为说客
 mediatype==3 表示视频
 mediatype==7 表示为播报中
 mediatype==5 表示为论坛
 */
@property (nonatomic, assign) NSInteger mediatype;
/**图片地址*/
@property (nonatomic, copy) NSString *indexdetail;
/**类型*/
@property (nonatomic, copy) NSString *type;


//快报
/**"createtime": "12:31",*/
@property (nonatomic, copy) NSString *createtime;
/**"img": "http://app0.autoimg.cn/zx/newspic/Broadcast/2015/6/5/2015060515012384374.jpg",*/
@property (nonatomic, copy) NSString *img;
/**"newsauthor": "郭枫",*/
@property (nonatomic, copy) NSString *newsauthor;
/**"newsstate": 2,*/
@property (nonatomic, copy) NSString *newsstate;
/**"newstypeanme": "其他快报",*/
@property (nonatomic, copy) NSString *newstypeanme;
/**"newstypeid": 4,*/
@property (nonatomic, copy) NSString *newstypeid;
/**"reviewcount": 76381,*/
@property (nonatomic, copy) NSString *reviewcount;

@end
