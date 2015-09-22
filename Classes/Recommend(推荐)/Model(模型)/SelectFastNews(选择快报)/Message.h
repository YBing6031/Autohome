//
//  message.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSArray *attachments;
@property (nonatomic, copy) NSString *authorname;
@property (nonatomic, strong) NSArray *commentlist;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, assign) NSInteger replycount;
@property (nonatomic, assign) NSInteger upcount;
@property (nonatomic, copy) NSString *publishtime;
@property (nonatomic, assign) NSInteger memberid;
@property (nonatomic, assign) NSInteger authorid;


@end
