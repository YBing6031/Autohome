//
//  Headlineinfo.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Headlineinfo : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *smallpic;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, assign) NSInteger replycount;
/**mediatype==6显示ImageNewsCell 图片的地址是indexdetail
 mediatype==2 表示为说客
 mediatype==3 表示视频
 mediatype==7 表示为播报中
 mediatype==5 表示为论坛
 */
@property (nonatomic, assign) NSInteger mediatype;
/**图片地址*/
@property (nonatomic, copy) NSString *indexdetail;

@end
