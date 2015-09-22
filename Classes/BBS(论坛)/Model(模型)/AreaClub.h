//
//  Area.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaClub : NSObject

/**"bbsid": 100001,*/
@property (nonatomic, assign) NSInteger bbsid;

/**"bbsname": "安徽",*/
@property (nonatomic, copy) NSString *bbsname;
/**"bbstype": "a",*/
@property (nonatomic, copy) NSString *bbstype;
/**"firstletter": "A"*/
@property (nonatomic, copy) NSString *firstletter;

@end
