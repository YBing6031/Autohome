//
//  Specitemgroup.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/15.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Specitemgroup : NSObject

/**"groupname": "1.5升 涡轮增压 169马力",*/
@property (nonatomic, copy) NSString *groupname;
/**"specitems":[]*/
@property (nonatomic, strong) NSMutableArray *specitems;

@end
