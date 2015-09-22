//
//  Level.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

/**"levelid": 0,*/
@property (nonatomic, assign) NSInteger levelid;
/**"levelname": "不限"*/
@property (nonatomic, copy) NSString *levelname;

@end
