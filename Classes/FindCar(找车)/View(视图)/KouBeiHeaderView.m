//
//  KouBeiHeaderView.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/13.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "KouBeiHeaderView.h"

@implementation KouBeiHeaderView

- (instancetype)initWithGrade:(NSString *)grade peoplenum:(NSInteger)peoplenum frame:(CGRect)frame block:(KouBeiHeaderViewBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        _block = block;
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"fame_icon_fraction"];
        [self addSubview:self.imgView];
        
        _gradeLabel = [[UILabel alloc] init];
        _gradeLabel.font = [UIFont systemFontOfSize:20];
        _gradeLabel.text = [NSString stringWithFormat:@"%@分", grade];
        
        NSMutableAttributedString *mAttStr = [[NSMutableAttributedString alloc] initWithString:_gradeLabel.text];
        
        [mAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(_gradeLabel.text.length-1, 1)];
        _gradeLabel.attributedText = mAttStr;
        
        [self addSubview:self.gradeLabel];
        
        _peoplenumLabel = [[UILabel alloc] init];
        _peoplenumLabel.font = [UIFont systemFontOfSize:12];
        _peoplenumLabel.text = [NSString stringWithFormat:@"%zi人参与", peoplenum];
        [self addSubview:self.peoplenumLabel];
        
        _sellButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _sellButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sellButton setTitle:@"在售" forState:UIControlStateNormal];
        [_sellButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_sellButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        _sellButton.tag = 1;
        [_sellButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _sellButton.selected = YES;
        [_sellButton setTintColor:[UIColor clearColor]];
        [self addSubview:self.sellButton];
        
        _stopSaleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _stopSaleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_stopSaleButton setTitle:@"停售" forState:UIControlStateNormal];
        [_stopSaleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_stopSaleButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        _stopSaleButton.tag = 2;
        [_stopSaleButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_stopSaleButton setTintColor:[UIColor clearColor]];
        [self addSubview:self.stopSaleButton];
    }
    return self;
}

+ (instancetype)kouBeiHeaderViewWithGrade:(NSString *)grade peoplenum:(NSInteger)peoplenum frame:(CGRect)frame block:(KouBeiHeaderViewBlock)block
{
    return [[[self class] alloc] initWithGrade:grade peoplenum:peoplenum frame:frame block:(KouBeiHeaderViewBlock)block];
}

- (void)onClick:(UIButton *)button
{
    if (_block) {
        self.block(self, button.tag-1);
    }
    if (button.tag == 1) {
        button.selected = YES;
        self.stopSaleButton.selected = NO;
    }
    else if (button.tag == 2) {
        button.selected = YES;
        self.sellButton.selected = NO;

    }
}

- (void)layoutSubviews
{
    _imgView.frame = CGRectMake(10, 10, 44, 44);
    
    _gradeLabel.frame = CGRectMake(62, 12, 100, 21);
    
    _peoplenumLabel.frame = CGRectMake(62, 36, 100, 15);
    
    _sellButton.frame = CGRectMake(8, 60, 40, 35);
    
    _stopSaleButton.frame = CGRectMake(48, 60, 40, 35);
}

@end
