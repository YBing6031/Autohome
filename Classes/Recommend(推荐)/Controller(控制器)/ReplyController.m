//
//  ReplyController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "ReplyController.h"
#import "ReplyCell.h"
#import "Reply.h"
#import "Net.h"
#import "News.h"
#import "MJExtension.h"
#import "Movie.h"
#import "Shuoke.h"

@interface ReplyController ()<UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *hotlist;
@property (strong, nonatomic)NSMutableArray *list;

@end

@implementation ReplyController

- (void)setNews:(News *)news
{
    _news = news;
    [Net sendAsynchronousWithURL:NewsReplyURL(news.id) tag:1 delegate:self];
}

- (void)setMovie:(Movie *)movie
{
    _movie = movie;
    [Net sendAsynchronousWithURL:MovieReplyURL(movie.id) tag:1 delegate:self];
}

- (void)setShuoke:(Shuoke *)shuoke
{
    _shuoke = shuoke;
    [Net sendAsynchronousWithURL:ShuokeReplyURL(shuoke.id) tag:1 delegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hotlist = [NSMutableArray array];
    self.list = [NSMutableArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReplyCell" bundle:nil] forCellReuseIdentifier:@"ReplyCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotlist.count;
    }
    if (section == 1) {
        return self.list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyCell" forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.section == 0) {
        cell.reply = self.hotlist[indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.reply = self.list[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"热门";
    } else if (section == 1) {
        return @"最新";
    }
    return nil;
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = request.responseData;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"result"];
    for (NSDictionary *hotDict in dict[@"hotlist"]) {
        Reply *reply = [Reply objectWithKeyValues:hotDict];
        [self.hotlist addObject:reply];
    }
    for (NSDictionary *replyDict in dict[@"list"]) {
        Reply *reply = [Reply objectWithKeyValues:replyDict];
        [self.list addObject:reply];
    }
    
    [self.tableView reloadData];
}

@end
