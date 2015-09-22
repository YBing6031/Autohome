//
//  SelectShuokeController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "SelectShuokeController.h"
#import "Net.h"
#import "News.h"

@interface SelectShuokeController ()<ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SelectShuokeController

- (void)setNews:(News *)news
{
    _news = news;
    [Net sendAsynchronousWithURL:ShuokeSelectURL(self.news.id) tag:1 delegate:self];
    NSLog(@"%@", ShuokeSelectURL(self.news.id));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = request.responseData;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:dict[@"result"][@"weburl"]]];
    [self.webView loadRequest:request1];
}

@end
