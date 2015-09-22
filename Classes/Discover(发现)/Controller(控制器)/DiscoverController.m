//
//  DiscoverController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "DiscoverController.h"
#import "HeadScrollView.h"
#import "TableScrollView.h"
#import "HeadViewContent.h"
#import "PageTableView.h"
#import "Net.h"
#import "UIButton+WebCache.h"
#import "DiscoverGroup.h"
#import "Discover.h"
#import "DiscoverPage.h"
#import "MJExtension.h"
#import "DiscoverCell.h"

@interface DiscoverController ()<UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate>

@property (weak, nonatomic) IBOutlet HeadScrollView *navScrollView;
@property (weak, nonatomic) IBOutlet TableScrollView *tableScrollView;

@property (strong, nonatomic) PageTableView *pageTableView;
@property (strong, nonatomic) DiscoverPage *discoverPage;
@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navScrollView.headViewcontents = @[[HeadViewContent headViewContentWithName:@"发现"]];
    
    self.pageTableView = [PageTableView pageTableView:CGRectMake(0, 0, kScreenW, kScreenH-20-35-49) delegate:self tag:1 registerNibNames:@[@"DiscoverCell"] style:UITableViewStyleGrouped];
    [self.tableScrollView addSubview:self.pageTableView];
    
    [Net sendAsynchronousWithURL:DiscoverHeaderViewURL tag:1 delegate:self];
    [Net sendAsynchronousWithURL:DiscoverCellURL tag:2 delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil][@"result"];
    if (request.tag == 1)//头视图
    {
        UIButton *headerView = [UIButton buttonWithType:UIButtonTypeCustom];
        headerView.frame = CGRectMake(0, 0, kScreenW, kScreenW*150/540);
        [headerView sd_setBackgroundImageWithURL:[NSURL URLWithString:dict[@"imgurl"]] forState:UIControlStateNormal];
        self.pageTableView.tableHeaderView = headerView;
    }
    else if (request.tag == 2)
    {
        self.discoverPage = [DiscoverPage objectWithKeyValues:dict];
        [self.pageTableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.discoverPage.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.discoverPage.list[section] list] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverCell" forIndexPath:indexPath];
    Discover *discover = [self.discoverPage.list[indexPath.section] list][indexPath.row];
    if (indexPath.section == 1) {
        cell.timeLabel.hidden = NO;
        cell.timeLabel.text = [NSString stringWithFormat:@"%@-%@", self.discoverPage.radiotime[@"starttime"], self.discoverPage.radiotime[@"endtime"]];
    } else {
        cell.timeLabel.hidden = YES;
    }
    cell.discover = discover;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

@end
