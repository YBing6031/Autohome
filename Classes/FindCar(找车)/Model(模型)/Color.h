//
//  Color.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Color : NSObject

/**"id": 0,*/
@property (nonatomic, assign) NSInteger id;

/**"name": "全部颜色",*/
@property (nonatomic, copy) NSString *name;
/**"piccount": 1127,*/
@property (nonatomic, assign) NSInteger piccount;

/**"value": ""*/
@property (nonatomic, copy) NSString *value;


@end
