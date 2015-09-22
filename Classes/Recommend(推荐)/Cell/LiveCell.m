//
//  LiveCell.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/4.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "LiveCell.h"
#import "UIImageView+WebCache.h"
#import "Live.h"

@implementation LiveCell

- (void)setLive:(Live *)live
{
    _live = live;
    self.radiopicurlImageView.layer.cornerRadius = self.radiopicurlImageView.bounds.size.width/2;
    [self.radiopicurlImageView sd_setImageWithURL:[NSURL URLWithString:live.radiopicurl]];
    self.albumLabel.text = live.album;
    self.anchorLabel.text = live.anchor;
}

@end
