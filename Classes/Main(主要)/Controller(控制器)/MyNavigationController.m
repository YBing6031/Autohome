//
//  MyNavigationController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "MyNavigationController.h"
#import "MainViewController.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 0) {
        self.navigationBarHidden = YES;
        ((MainViewController *)self.tabBarController).customTarbar.hidden = NO;
    } else {
        self.navigationBarHidden = NO;
        ((MainViewController *)self.tabBarController).customTarbar.hidden = YES;
    }
//    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count == 2) {
        self.navigationBarHidden = YES;
//        self.tabBarController.tabBar.hidden = NO;
        ((MainViewController *)self.tabBarController).customTarbar.hidden = NO;
    } else {
        self.navigationBarHidden = NO;
//        self.tabBarController.tabBar.hidden = YES;
        ((MainViewController *)self.tabBarController).customTarbar.hidden = YES;
    }
    return [super popViewControllerAnimated:animated];
}


@end
