//
//  message.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Message.h"
#import "Attachment.h"
#import "Comment.h"
#import "MJExtension.h"

@implementation Message

- (NSDictionary *)objectClassInArray
{
    return @{@"attachments":[Attachment class],
             @"commentlist":[Comment class]};
}


@end
