//
//  SelectNewsController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "SelectNewsController.h"
#import "Net.h"
#import "News.h"
#import "MJExtension.h"
#import "ReplyController.h"
#import "Movie.h"
#import "Shuoke.h"
#import "UMSocial.h"
#import "MobClick.h"
#import "MBProgressHUD+MJ.h"

@interface SelectNewsController ()<ASIHTTPRequestDelegate, UMSocialUIDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSFileManager *manager;
@property (copy, nonatomic) NSString *path;

@property (strong, nonatomic)UIButton *replycountBtn;

@property (copy, nonatomic) NSString *weburl;
@end

@implementation SelectNewsController

- (void)setNews:(News *)news
{
    [MBProgressHUD showMessage:@"正在加载中"];
    _news = news;
    NSString *url = NewsSelectURL(self.news.id);
    NSString *url1 = NewsSelectURL1(self.news.id);
    switch (news.mediatype) {
        case 1:
            url = NewsSelectURL(self.news.id);
            url1 = NewsSelectURL1(self.news.id);
            break;
        case 2:
            url = ShuokeSelectURL(self.news.id);
            url1 = ShuokeSelectURL1(self.news.id);
            break;
        case 3:
            url = MovieSelectURL(self.news.id);
            url1 = MovieSelectURL1(self.news.id);
            break;
        default:
            break;
    }

    NSString *fileName = [url lastPathComponent];
    
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@", fileName]];
    self.path = path;
    if (![self.manager fileExistsAtPath:path]) {
        [Net sendAsynchronousWithURL:url tag:1 delegate:self];
    }
    
    if (url1) {
        [Net sendAsynchronousWithURL:url1 tag:2 delegate:self];
    }
}

- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    NSString *url = MovieSelectURL(self.movie.id);
    NSString *url1 = MovieSelectURL1(self.movie.id);
    NSString *fileName = [url lastPathComponent];
    
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@", fileName]];
    self.path = path;
    if (![self.manager fileExistsAtPath:path]) {
        [Net sendAsynchronousWithURL:url tag:1 delegate:self];
    }
    
    if (url1) {
        [Net sendAsynchronousWithURL:url1 tag:2 delegate:self];
    }
}

- (void)setShuoke:(Shuoke *)shuoke
{
    
    _shuoke = shuoke;
    NSString *url = ShuokeSelectURL(self.shuoke.id);
    NSString *url1 = ShuokeSelectURL1(self.shuoke.id);
    NSString *fileName = [url lastPathComponent];
    
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@", fileName]];
    self.path = path;
    if (![self.manager fileExistsAtPath:path]) {
        [Net sendAsynchronousWithURL:url tag:1 delegate:self];
    }
    
    if (url1) {
        [Net sendAsynchronousWithURL:url1 tag:2 delegate:self];
    }
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.manager = [NSFileManager defaultManager];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self setupNavigationBar];
    NSData *data = [[NSData alloc] initWithContentsOfFile:self.path];
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
    
    
    UIView *tarbarView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-49-64, kScreenW, 49)];
    tarbarView.backgroundColor = RGB(230, 230, 230);
//    tarbarView.backgroundColor = [UIColor redColor];
//    self.view.backgroundColor = [UIColor purpleColor];
    UITextField *publishCommentTF = [[UITextField alloc] initWithFrame:CGRectMake(8, 5, kScreenW-90, 39)];
    publishCommentTF.borderStyle = UITextBorderStyleRoundedRect;
    publishCommentTF.placeholder = @"发表评论";
    publishCommentTF.textAlignment = NSTextAlignmentCenter;
    
    [tarbarView addSubview:publishCommentTF];
    
    UIButton *replycountBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    replycountBtn.frame = CGRectMake(CGRectGetMaxX(publishCommentTF.frame)+5, 5, kScreenW-8-CGRectGetMaxX(publishCommentTF.frame)-5, 39);
    [replycountBtn setTitle:[NSString stringWithFormat:@"%zi评论", self.news.replycount] forState:UIControlStateNormal];
    [replycountBtn addTarget:self action:@selector(replycountClick) forControlEvents:UIControlEventTouchUpInside];
    self.replycountBtn = replycountBtn;
    [tarbarView addSubview:replycountBtn];
    
    [self.view addSubview:tarbarView];
    
    
    
}


- (void)setupNavigationBar
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.width = 55;
    leftButton.height = 34;
    [leftButton addTarget:self action:@selector(leftOnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@" 返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"bar_btn_icon_returntext"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(collect)];
    self.navigationItem.rightBarButtonItems = @[rightItem1, rightItem2];
}

- (void)share
{
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5554641d67e58e7b19000235"
                                      shareText:self.weburl
                                     shareImage:[UIImage imageNamed:@"share_180_180"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToRenren,UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter,nil]
                                       delegate:self];
}

- (void)collect
{
    
}

- (void)leftOnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)replycountClick
{
    ReplyController *replyCtl = [[ReplyController alloc] init];

    if (self.news) {
        replyCtl.news = self.news;
    } else if (self.movie) {
        replyCtl.movie = self.movie;
    } else if (self.shuoke) {
        replyCtl.shuoke = self.shuoke;
    }
    replyCtl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:replyCtl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        self.view = nil;
    }
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = request.responseData;
    if (request.tag==1) {
        [self.manager createFileAtPath:self.path contents:data attributes:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [str writeToFile:@"/Users/aoyolo1/Desktop/html.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
    }
    else if (request.tag == 2) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [self.replycountBtn setTitle:[NSString stringWithFormat:@"%zi评论", [dict[@"result"][@"replycount"] integerValue]] forState:UIControlStateNormal];
        self.weburl = dict[@"result"][@"url"];
        if (!self.weburl) {
            self.weburl = dict[@"result"][@"weburl"];
        }
    }
    [MBProgressHUD hideHUD];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUD];
    NSLog(@"%@", request.error.localizedDescription);
}

#pragma mark - UIWebViewDelegate
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [MBProgressHUD showMessage:@"正在加载中"];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [MBProgressHUD hideHUD];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [MBProgressHUD hideHUD];
//}

@end
