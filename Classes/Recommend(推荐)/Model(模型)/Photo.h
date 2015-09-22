//
//  Photo.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/18.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

/**"id": 2967069,*/
@property (nonatomic, assign) NSInteger id;

/**"imgurl": "http://car0.autoimg.cn/car/upload/2015/4/21/w_201504211140559494435112.jpg",*/
@property (nonatomic, copy) NSString *imgurl;
/**"seriesname": "大迈X5",*/
@property (nonatomic, copy) NSString *seriesname;
/**"specname": "2015款 基本型"*/
@property (nonatomic, copy) NSString *specname;

@end
