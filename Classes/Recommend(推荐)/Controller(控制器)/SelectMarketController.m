//
//  SelectMarketController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "SelectMarketController.h"
#import "Net.h"
#import "News.h"
#import "ReplyController.h"

@interface SelectMarketController ()<ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (copy, nonatomic) NSString *path;
@property (strong, nonatomic) NSFileManager *manager;
@property (strong, nonatomic)UIButton *replycountBtn;
@end

@implementation SelectMarketController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.manager = [NSFileManager defaultManager];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = MarketSelectURL(self.news.id);
    
    NSString *fileName = [url lastPathComponent];
    
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@", fileName]];
    self.path = path;
    if (![self.manager fileExistsAtPath:path]) {
        [Net sendAsynchronousWithURL:url tag:1 delegate:self];
    } else {
        NSData *data = [[NSData alloc] initWithContentsOfFile:self.path];
        [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
    }
    
    //设置tarbar
    [self setupTarbar];
}

- (void)setupTarbar
{
    UIView *tarbarView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-49, kScreenW, 49)];
    tarbarView.backgroundColor = RGB(230, 230, 230);
    
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

- (void)replycountClick
{
    ReplyController *replyCtl = [[ReplyController alloc] init];
    replyCtl.news = self.news;
    replyCtl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:replyCtl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = request.responseData;
    if (request.tag==1) {
        [self.manager createFileAtPath:self.path contents:data attributes:nil];
        [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@", request.error.localizedDescription);
}

@end
