//
//  LiveCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/4.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
@class Live;
@interface LiveCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *radiopicurlImageView;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UILabel *anchorLabel;

@property (nonatomic, strong) Live *live;

@end
