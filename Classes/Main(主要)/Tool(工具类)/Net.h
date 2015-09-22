//
//  Net.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface Net : NSObject

+ (void)sendAsynchronousWithURL:(NSString *)url tag:(NSInteger)tag delegate:(id)delegate;
/**
 判断是否有网
 */
+ (BOOL)netIsReachable;

@end
