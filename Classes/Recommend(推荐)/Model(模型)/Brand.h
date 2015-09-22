//
//  Brand.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject

/**"id": 33,*/
@property (nonatomic, assign) NSInteger id;
/**"imgurl": "~/logo/brand/50/129472203719848750.jpg",*/
@property (nonatomic, copy) NSString *imgurl;
/**"name": "奥迪",*/
@property (nonatomic, copy) NSString *name;
/**"tmimg": null*/
@property (nonatomic, copy) NSString *tmimg;

+ (instancetype)brandWithName:(NSString *)name imgurl:(NSString *)imgurl;

@end
