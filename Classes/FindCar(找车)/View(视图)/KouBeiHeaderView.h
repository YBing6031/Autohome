//
//  KouBeiHeaderView.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KouBeiHeaderView;
typedef void(^KouBeiHeaderViewBlock)(KouBeiHeaderView *kouBeiHeaderView, NSInteger buttonIndex);

@interface KouBeiHeaderView : UIView

@property (nonatomic, strong, readonly) UILabel *gradeLabel;

@property (nonatomic, strong, readonly) UILabel *peoplenumLabel;

@property (nonatomic, strong, readonly) UIImageView *imgView;

@property (nonatomic, strong, readonly) UIButton *sellButton;
@property (nonatomic, strong, readonly) UIButton *stopSaleButton;

@property (nonatomic, assign) NSInteger selectedButtonIndex;

@property (nonatomic, copy) KouBeiHeaderViewBlock block;


- (instancetype)initWithGrade:(NSString *)grade peoplenum:(NSInteger)peoplenum frame:(CGRect)frame block:(KouBeiHeaderViewBlock)block;

+ (instancetype)kouBeiHeaderViewWithGrade:(NSString *)grade peoplenum:(NSInteger)peoplenum frame:(CGRect)frame block:(KouBeiHeaderViewBlock)block;

@end
