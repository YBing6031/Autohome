//
//  PhotoBrowserViewController.m
//  AlbumDemo
//
//  Created by aoyolo1 on 15/5/1.
//  Copyright (c) 2015年 aoyolo1. All rights reserved.
//

#import "PhotoBrowserViewController.h"
#import "CycleScrollView.h"
#import "Net.h"
#import "News.h"
#import "CategoryMe.h"
#import "MJExtension.h"
#import "Photo.h"

@interface PhotoBrowserViewController ()<ASIHTTPRequestDelegate>

@property (strong, nonatomic) NSMutableArray *categorys;
@property (strong, nonatomic) NSMutableDictionary *countDict;
@property (strong, nonatomic) NSMutableArray *photos;
@property (assign, nonatomic) NSInteger typeIndex;
@property (strong, nonatomic) CycleScrollView *cycView;
@property (assign, nonatomic) BOOL isBtnClick;


@end

@implementation PhotoBrowserViewController
{
    NSInteger _ss;
    NSInteger _sp;
    NSInteger _rowCount;
}


- (void)loadImage
{
    NSArray *arr = [self.news.indexdetail componentsSeparatedByString:@"㊣"];
    _ss = [arr[0] integerValue];
    _sp = [arr[1] integerValue];
    [Net sendAsynchronousWithURL:ImageSelectURL(_ss, _sp, self.news.id, 0) tag:0 delegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categorys = [NSMutableArray array];
    self.countDict = [NSMutableDictionary dictionary];
    self.photos = [NSMutableArray array];
    [self loadImage];
    //1
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)addImageToView
{
    //2
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];
    if (self.cycView == nil) {
        CycleScrollView *cycView = [[CycleScrollView alloc] initWithFrame:self.view.bounds andImages:self.photos andCurrentIndex:_selectIndex andIndexChange:^(NSInteger index) {
            self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld", index+1, _rowCount];
        }];
        self.cycView = cycView;
        [self.view addSubview:cycView];
        //3
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [cycView addGestureRecognizer:tap];
    }
}

- (void)onTap:(UITapGestureRecognizer *)tap
{
    BOOL isHidden = !self.navigationController.navigationBar.isHidden;
    self.navigationController.navigationBarHidden = isHidden;
    [UIApplication sharedApplication].statusBarHidden = isHidden;
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil][@"result"];
    if (request.tag == 0) {
        _rowCount = [dict[@"rowcount"] integerValue];
        for (NSDictionary *categoryDict in dict[@"categorys"]) {
            CategoryMe *category = [CategoryMe objectWithKeyValues:categoryDict];
            [self.categorys addObject:category];
        }
        for (int i = 1; i < self.categorys.count; i++)
        {
            CategoryMe *category = self.categorys[i];
            [Net sendAsynchronousWithURL:ImageSelectURL(_ss, _sp, 0, category.id) tag:i+10 delegate:self];
        }
        for (NSDictionary *photoDict in dict[@"list"]) {
            Photo *photo = [Photo objectWithKeyValues:photoDict];
            [self.photos addObject:photo];
        }
        [self.countDict setObject:@(self.photos.count) forKey:@(0)];
        [self addImageToView];
        self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld", _selectIndex + 1, _rowCount];
        //创建分类button按钮
        CGFloat w = kScreenW/self.categorys.count;
        CGFloat h = 35;
        for (int i = 0; i < self.categorys.count; i++)
        {
            UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            typeBtn.frame = CGRectMake(i*w, kScreenH-h, w, h);
            typeBtn.backgroundColor = [UIColor blueColor];
            [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            typeBtn.tag = i+100;
            [typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [typeBtn setTitle:[self.categorys[i] name] forState:UIControlStateNormal];
            [self.view addSubview:typeBtn];
        }
    }
    else
    {
        for (NSDictionary *photoDict in dict[@"list"]) {
            Photo *photo = [Photo objectWithKeyValues:photoDict];
            [self.photos addObject:photo];
        }
        [self.countDict setObject:@(self.photos.count) forKey:@(request.tag - 10)];
    }
}

- (void)typeBtnClick:(UIButton *)button
{
    NSInteger tag = button.tag-100;
    NSInteger index = [self.countDict[@(tag-1)] integerValue] == 0 ? 1:[self.countDict[@(tag-1)] integerValue];
    self.cycView.currentIndex = index - 1;
    self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld", self.cycView.currentIndex+1, _rowCount];
}

@end
