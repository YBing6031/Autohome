//
//  Hotsaleserie.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotsaleserie : NSObject

@property (nonatomic, strong) NSArray *hotseries;

/**"levelid": 2,*/
@property (nonatomic, assign) NSInteger levelid;

/**"levelname": "小型车"*/
@property (nonatomic, copy) NSString *levelname;


@end
