//
//  TableViewHeaderView.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/5.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "TableViewHeaderView.h"
#import "TableViewHeaderViewButton.h"
#import "HeadViewContent.h"

#define kButtonW 100
@implementation TableViewHeaderView
{
    UIButton *_currentBtn;
    CGFloat _countW;
    NSMutableArray *_buttonArr;
}

- (instancetype)initWithFindTypes:(NSArray *)findTypes types:(NSArray *)types frame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if (self) {
        int count = (int)findTypes.count;
        
        CGFloat countW = 0;
        
        for (int i = 0; i < count; i++)
        {
            NSString *findType = findTypes[i];
            //创建按钮
            TableViewHeaderViewButton *typeBtn = [TableViewHeaderViewButton buttonWithType:UIButtonTypeCustom];
            CGSize size = [findType sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            
            typeBtn.frame = CGRectMake(countW, 0, (size.width+40), frame.size.height);
            
            if (i>0) {
                UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(countW+5, 10, 1, self.height-10*2)];
                separatorView.backgroundColor = [UIColor grayColor];
                [self addSubview:separatorView];
            }
            
            countW += size.width+40;
            
            [typeBtn setTitle:findType forState:UIControlStateNormal];
            [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            typeBtn.type = [types[i] integerValue];
            typeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            typeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -27, 0, 0);

            typeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, size.width+20, 0, 0);
            [typeBtn setImage:[UIImage imageNamed:@"filterbar_icon_arrow"] forState:UIControlStateNormal];
            typeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            //添加事件
            [typeBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:typeBtn];
            if (self.buttons == nil) {
                self.buttons = [NSMutableArray arrayWithCapacity:0];
            }
            [self.buttons addObject:typeBtn];
        }
        self.contentSize = CGSizeMake(countW, 0);
    }
    return self;
}

+ (instancetype)tableViewHeaderViewWithFindTypes:(NSArray *)findTypes types:(NSArray *)types frame:(CGRect)frame
{
    TableViewHeaderView *headerView = [[TableViewHeaderView alloc] initWithFindTypes:findTypes types:types frame:frame];
    
    return headerView;
}

- (instancetype)initWithheadViewContents:(NSArray *)headViewContents frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        int count = (int)headViewContents.count;
        CGFloat x = 0;
        _buttonArr = [NSMutableArray array];
        for (int i = 0; i < count; i++)
        {
            HeadViewContent *headViewContent = headViewContents[i];
            //创建按钮
            TableViewHeaderViewButton *typeBtn = [TableViewHeaderViewButton buttonWithType:UIButtonTypeCustom];
            CGSize size = [headViewContent.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            typeBtn.frame = CGRectMake(x, 0, size.width+10, frame.size.height);
            x += size.width+10;
            [typeBtn setTitle:headViewContent.name forState:UIControlStateNormal];
            [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [typeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            typeBtn.value = [headViewContent.value integerValue];
            typeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            typeBtn.tag = i;
            typeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            //添加事件
            [typeBtn addTarget:self action:@selector(onClick1:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:typeBtn];
            
            [_buttonArr addObject:typeBtn];
            if (self.buttons == nil) {
                self.buttons = [NSMutableArray arrayWithCapacity:0];
            }
            [self.buttons addObject:typeBtn];
            if (i == 0) {
                _currentBtn = typeBtn;
                _currentBtn.selected = YES;
            }
        }
        _countW = x;
        self.contentSize = CGSizeMake(x, 0);
    }
    return self;
}

+ (instancetype)tableViewHeaderViewWithheadViewContents:(NSArray *)headViewContents frame:(CGRect)frame
{
    return [[[self class] alloc] initWithheadViewContents:headViewContents frame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(250, 250, 250);
    }
    return self;
}

- (void)onClick:(TableViewHeaderViewButton *)button
{
    if (self.block) {
        self.block(self, button.type);
    }
}

- (void)onClick1:(TableViewHeaderViewButton *)button
{ 
    if (self.block1) {
        self.block1(self, button);
    }
}

- (void)setSelectedButtonIndex:(NSInteger)selectedButtonIndex
{
    _selectedButtonIndex = selectedButtonIndex;
    TableViewHeaderViewButton *button = _buttonArr[selectedButtonIndex];
    _currentBtn.selected = NO;
    _currentBtn = button;
    _currentBtn.selected = YES;
    
    
    CGFloat offsetX = button.x - (kScreenW-44)/2 + button.width/2;
    
    if (offsetX>0&&offsetX<_countW-kScreenW+44) {
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    else if (offsetX<0&&self.contentOffset.x>0)
    {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (offsetX>_countW-kScreenW+44&&self.contentOffset.x<_countW- kScreenW+44)
    {
        [self setContentOffset:CGPointMake(_countW-kScreenW+44, 0) animated:YES];
    }
    
}

@end
