//
//  PublishCommentCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "PublishCommentCell.h"

@implementation PublishCommentCell

- (void)setDelegate:(id)delegate
{
    _delegate = delegate;
    self.publishCommentTF.delegate = delegate;
}

@end
