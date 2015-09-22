//
//  Serie.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Serie : NSObject

/**"id": 923,*/
@property (nonatomic, assign) NSInteger id;

/**"imgurl": "http://car0.autoimg.cn/upload/2014/2/11/s_201402111825333964435.jpg",*/
@property (nonatomic, copy) NSString *imgurl;
/**"levelid": 6,*/
@property (nonatomic, assign) NSInteger levelid;

/**"levelname": "大型车",*/
@property (nonatomic, copy) NSString *levelname;
/**"name": "Rapide",*/
@property (nonatomic, copy) NSString *name;
/**"price": "358.88-428.00万"*/
@property (nonatomic, copy) NSString *price;

+ (instancetype)serieWithID:(NSInteger)ID name:(NSString *)name price:(NSString *)price imgurl:(NSString *)imgurl;

@end
