//
//  Comment.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

/**"carname": "",*/
@property (nonatomic, copy) NSString *carname;
/**"content": "小编是陈震的徒弟么？这么猛啊？",*/
@property (nonatomic, copy) NSString *content;
/**"createtime": "1小时前",*/
@property (nonatomic, copy) NSString *createtime;
/**"headimg": "http://i1.autoimg.cn/album/userheaders/2015/1/2/f16b8d62-9ed2-4ad9-aaf7-14152f4b7b2b_120X120.jpg",*/
@property (nonatomic, copy) NSString *headimg;
/**"isbusinessauth": 0,*/
@property (nonatomic, assign) BOOL isbusinessauth;
/**"iscarower": 0,*/
@property (nonatomic, assign) BOOL iscarower;
/**"issocialize": 0,*/
@property (nonatomic, assign) BOOL issocialize;
/**"sourcecontent": "",*/
@property (nonatomic, copy) NSString *sourcecontent;
/**"sourcename": "",*/
@property (nonatomic, copy) NSString *sourcename;
/**"userid": 4024964,*/
@property (nonatomic, assign) NSInteger userid;
/**"username": "719066661"*/
@property (nonatomic, copy) NSString *username;

@end
