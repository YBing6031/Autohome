//
//  FavoriteBBSController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/10.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "FavoriteBBSController.h"
#import "Net.h"
#import "BBSTheme.h"
#import "Topic.h"
#import "TopicTwoCell.h"
#import "Topiclist.h"
#import "MJExtension.h"
#import "SeePostControler.h"
#import "AreaClub.h"
#import "MJRefresh.h"

@interface FavoriteBBSController ()<UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Topiclist *topiclist;
@property (assign, nonatomic) NSInteger currentIndex;//记录是最新发布  最后回复 精华帖

@property (strong, nonatomic)UIView *tarbar;//底下tarbar
@property (strong, nonatomic)UILabel *postCountLabel;//显示一共多少帖

@property (copy, nonatomic)NSString *bbstype;//bbstype
@property (assign, nonatomic)NSInteger bbsid;//bbsid

@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) BOOL flag;

@end

@implementation FavoriteBBSController

- (void)setTheme:(BBSTheme *)theme
{
    _theme = theme;
    self.bbstype = theme.bbstype;
    self.bbsid = theme.bbsid;
    [Net sendAsynchronousWithURL:BBSFavoriteURL(theme.bbsid, theme.bbstype, 0,0,1) tag:1 delegate:self];
}

- (void)setArea:(AreaClub *)area
{
    _area = area;
    self.bbstype = area.bbstype;
    self.bbsid = area.bbsid;
    [Net sendAsynchronousWithURL:BBSFavoriteURL(area.bbsid, area.bbstype, 0, 0, 1) tag:1 delegate:self];
}

//下拉刷新
- (void)onHeaderRefresh
{
    self.currentPage = 1;
    self.flag = NO;
    [self sendAsynchronousForSegmentIndex];
}

- (void)onFooterRefresh
{
    self.currentPage++;
    self.flag = YES;
    [self sendAsynchronousForSegmentIndex];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView addHeaderWithTarget:self action:@selector(onHeaderRefresh)];
    [self.tableView addFooterWithTarget:self action:@selector(onFooterRefresh)];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicTwoCell" bundle:nil] forCellReuseIdentifier:@"TopicTwoCell"];
    //创建底下tarbar
    UIView *tarbar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-49, kScreenW, 49)];
    
    UIButton *writePostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    writePostBtn.frame = CGRectMake(kScreenW-49, 0, 49, 49);
    [writePostBtn setImage:[UIImage imageNamed:@"bar_btn_icon_posting_a"] forState:UIControlStateNormal];
    [tarbar addSubview:writePostBtn];
    
    UIButton *stowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stowBtn.frame = CGRectMake(kScreenW-49*2, 0, 49, 49);
    [stowBtn setImage:[UIImage imageNamed:@"bar_btn_icon_collect_a"] forState:UIControlStateNormal];
    [tarbar addSubview:stowBtn];
    
    UILabel *postCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW/2-100/2, 14, 100, 21)];
    postCountLabel.font = [UIFont systemFontOfSize:12];
    postCountLabel.textColor = [UIColor grayColor];
    postCountLabel.textAlignment = NSTextAlignmentCenter;
    self.postCountLabel = postCountLabel;
    [tarbar addSubview:postCountLabel];
    
    tarbar.backgroundColor = RGB(246, 246, 246);
    [self.view addSubview:tarbar];
    self.tarbar = tarbar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
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
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"result"];
    if (!dict) return;
    if (request.tag == 1) {
        if (!self.flag) {
            [self.tableView headerEndRefreshing];
            self.topiclist = [Topiclist objectWithKeyValues:dict];
        } else {
            [self.tableView footerEndRefreshing];
            [self.topiclist.list addObjectsFromArray:[[Topiclist objectWithKeyValues:dict] list]];
            NSLog(@"%zi", _topiclist.list.count);
        }
        //显示共多少帖
        self.postCountLabel.text = [NSString stringWithFormat:@"共%zi帖", self.topiclist.rowcount];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topiclist.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicTwoCell" forIndexPath:indexPath];
    Topic *topic = self.topiclist.list[indexPath.row];
    cell.type = self.currentIndex;
    cell.topic = topic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    headerView.backgroundColor = RGB(246, 246, 246);
    UISegmentedControl *segmentCtl = [[UISegmentedControl alloc] initWithItems:@[@"最后回复", @"最新发布", @"精华帖"]];
    segmentCtl.frame = CGRectMake(8, 8, kScreenW-8*2, 44-8*2);
    segmentCtl.selectedSegmentIndex = self.currentIndex;
    [segmentCtl addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:segmentCtl];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SeePostControler *seePostCtl = [[SeePostControler alloc] init];
    Topic *topic = self.topiclist.list[indexPath.row];
    seePostCtl.topicid = topic.topicid;
    [self.navigationController pushViewController:seePostCtl animated:YES];
}

- (void)valueChange:(UISegmentedControl *)segmentCtl
{
    self.currentIndex = segmentCtl.selectedSegmentIndex;
    self.flag = NO;
    self.currentPage = 1;
    [self sendAsynchronousForSegmentIndex];
}

- (void)sendAsynchronousForSegmentIndex
{
    if (self.currentIndex == 0) {//最后回复
        [Net sendAsynchronousWithURL:BBSFavoriteURL(self.bbsid, self.bbstype, 0, 0, self.currentPage) tag:1 delegate:self];
    }
    else if (self.currentIndex == 1) {//最新发布
        [Net sendAsynchronousWithURL:BBSFavoriteURL(self.bbsid, self.bbstype, 0, 2, self.currentPage) tag:1 delegate:self];
    }
    else {//精华帖
        [Net sendAsynchronousWithURL:BBSFavoriteURL(self.bbsid, self.bbstype, 1, 0, self.currentPage) tag:1 delegate:self];
    }
}

@end
