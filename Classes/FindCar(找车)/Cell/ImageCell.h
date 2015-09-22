//
//  ImageCell.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/12.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageButton, Image;
@interface ImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet ImageButton *imageBtn;

@property (nonatomic, strong) Image *image;

@end
