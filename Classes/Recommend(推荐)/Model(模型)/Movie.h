//
//  Movie.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/4.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, copy) NSString *smallimg;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSInteger playcount;
@property (nonatomic, assign) NSInteger id;


@end
