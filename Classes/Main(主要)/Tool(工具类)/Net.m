//
//  Net.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "Net.h"
#import "AppDelegate.h"
#import "Reachability.h"

@implementation Net

+ (void)sendAsynchronousWithURL:(NSString *)url tag:(NSInteger)tag delegate:(id)delegate
{
    [self netIsReachable];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//    if (![self netIsReachable]) {
        //设置缓存时间
        request.secondsToCache = 60;
        //缓存策略
        [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [request setDownloadCache:appDelegate.cache];
//    }
    request.tag = tag;
    request.delegate = delegate;
    [request startAsynchronous];
    
}

+ (BOOL)netIsReachable
{
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if (!reach.isReachable) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UILabel *pop = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenH-49-40, kScreenW, 40)];
        pop.alpha = 0;
        pop.backgroundColor = [UIColor redColor];
        pop.textAlignment = NSTextAlignmentCenter;
        pop.text = @"您当网络不可用,请检查网络设置";
        pop.textColor = [UIColor whiteColor];
        [UIView animateWithDuration:1 animations:^{
            pop.alpha = 1;
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:pop repeats:NO];
        }];
        
        [window addSubview:pop];
    }
    return reach.isReachable;
}

+ (void)timerAction:(NSTimer *)timer
{
    UILabel *pop = (UILabel *)timer.userInfo;
    [UIView animateWithDuration:1 animations:^{
        pop.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [pop removeFromSuperview];
        }
    }];
}

@end
