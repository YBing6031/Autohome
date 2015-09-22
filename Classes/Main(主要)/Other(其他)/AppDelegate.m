//
//  AppDelegate.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "MobClickSocialAnalytics.h"
#import "MobClick.h"
#import "UMSocialQQHandler.h"

#define AppKey @"5554641d67e58e7b19000235"
@interface AppDelegate ()

@end

@implementation AppDelegate
{
    UIView *_lunchView;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.window.rootViewController = mainVC;
    //增加启动动画
//    [self addStartAnimation];
    
//    设置本地缓存
    [self setupCache];
    
    //增加分享功能
    [self addShare];
    
//    [self registerLocalNotification];
    
    return YES;
}

- (void)registerLocalNotification
{
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil]];
}

- (void)addShare
{
    [UMSocialData setAppKey:AppKey];
    
    [MobClick startWithAppkey:AppKey reportPolicy:BATCH channelId:@"Web"];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    
    //增加qq分享
    [UMSocialQQHandler setQQWithAppId:@"1104543547" appKey:@"61XW63bvXuRYDJw8" url:@"http://www.umeng.com/social"];
}

- (void)setupCache
{
    //设置本地缓存
    _cache = [[ASIDownloadCache alloc]init];
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cacheDir = [documentDir stringByAppendingPathComponent:@"Cache"];
    [[NSFileManager defaultManager]createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    [_cache setStoragePath:cacheDir];
    [_cache setDefaultCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
}

- (void)addStartAnimation
{
    //这样增加启动动画
    NSString *url = @"http://www0.autoimg.cn/zx/newspic/2015/5/16/620x0_1_2015051607090671419.jpg";
    UIView *lunchView = [[[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil] lastObject];
    lunchView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    [imgView sd_setImageWithURL:[NSURL URLWithString:url]];
    [lunchView addSubview:imgView];
    _lunchView = lunchView;
    [self.window addSubview:lunchView];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
}

- (void)timerAction
{
    [_lunchView removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//    notification.alertBody = @"123";
//    NSLog(@"%zi", application.applicationIconBadgeNumber);
//    notification.applicationIconBadgeNumber = application.applicationIconBadgeNumber+1;
//    
//    [application scheduleLocalNotification:notification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@", deviceToken);
}

@end
