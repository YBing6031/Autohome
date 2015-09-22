//
//  SeePostControler.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "SeePostControler.h"
#import "Net.h"

@interface SeePostControler ()<ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *path;
@property (strong, nonatomic) NSFileManager *manager;
@end

@implementation SeePostControler

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    self.manager = [NSFileManager defaultManager];
    
    NSString *url = BBSSeePostURL(self.topicid);
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
