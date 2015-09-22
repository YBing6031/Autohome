//
//  Theme.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBSTheme : NSObject

/**"bbsid": 200009,*/
@property (nonatomic, assign) NSInteger bbsid;
/**"bbsname": "精彩作业论坛",*/
@property (nonatomic, copy) NSString *bbsname;
/**"bbstype": "o"*/
@property (nonatomic, copy) NSString *bbstype;

@end
