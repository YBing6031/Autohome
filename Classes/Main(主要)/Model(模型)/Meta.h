//
//  Meta.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meta : NSObject

/**"key": "newstype",*/
@property (nonatomic, copy) NSString *key;
/**"list":*/
@property (nonatomic, strong) NSArray *list;

@end
