//
//  PublishCommentCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *publishCommentTF;

@property (nonatomic, weak) id delegate;

@end
