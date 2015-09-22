//
//  MainViewController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "MainViewController.h"
#import "RecommendController.h"
#import "BBSController.h"
#import "FindCarController.h"
#import "DiscoverController.h"
#import "MeController.h"
#import "MyNavigationController.h"

@interface MainViewController ()

@property (nonatomic, strong)UIButton *currentbtn;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义tarbar
    self.tabBar.hidden = YES;
    UIView *tarbar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-49, kScreenW, 49)];
    tarbar.backgroundColor = RGB(250, 250, 250);
    CGFloat w = kScreenW/5;
    for (int i = 0; i < 5; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*w, 0, w, 44);
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"item0%d_selected", i+1]] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"item0%d", i+1]] forState:UIControlStateNormal];
        if (i == 0) {
            button.selected = YES;
            self.currentbtn = button;
        }
        button.tag = i+1;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [tarbar addSubview:button];
    }
    self.customTarbar = tarbar;
    [self.view addSubview:tarbar];
    
    RecommendController *recommendCtl = [[RecommendController alloc] init];
    [self addChildCtlToViewControllers:recommendCtl];
    
    BBSController *bbsCtl = [[BBSController alloc] init];
    [self addChildCtlToViewControllers:bbsCtl];
    
    FindCarController *findCarCtl = [[FindCarController alloc] init];
    [self addChildCtlToViewControllers:findCarCtl];
    
    DiscoverController *discoverCtl = [[DiscoverController alloc] init];
    [self addChildCtlToViewControllers:discoverCtl];
    
    MeController *meCtl = [[MeController alloc] init];
    [self addChildCtlToViewControllers:meCtl];
    
}

- (void)addChildCtlToViewControllers:(UIViewController *)vc
{
    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClick:(UIButton *)button
{
    self.currentbtn.selected = NO;
    button.selected = YES;
    self.currentbtn = button;
    
    self.selectedIndex = button.tag - 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
