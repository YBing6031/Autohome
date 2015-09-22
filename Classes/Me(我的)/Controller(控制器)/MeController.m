//
//  MeController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "MeController.h"
#import "HeadScrollView.h"
#import "TableScrollView.h"
#import "PageTableView.h"
#import "HeadViewContent.h"
#import "MeCell.h"
#import "DiscoverCell.h"

@interface MeController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_dataArr;
}
@property (weak, nonatomic) IBOutlet HeadScrollView *navScrollView;
@property (weak, nonatomic) IBOutlet TableScrollView *tableScrollView;

@property (strong, nonatomic) PageTableView *pageTableView;

@end

@implementation MeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = @[@[@{@"icon":@"me_favourite", @"title":@"我的收藏"},
                   @{@"icon":@"me_history", @"title":@"浏览历史"},
                   @{@"icon":@"me_draft", @"title":@"草稿箱"}],
                 @[@{@"icon":@"me_setting", @"title":@"设置"}]];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navScrollView.headViewcontents = @[[HeadViewContent headViewContentWithName:@"我"]];
    
    self.pageTableView = [PageTableView pageTableView:CGRectMake(0, 0, kScreenW, kScreenH-20-35-49) delegate:self tag:1 registerNibNames:@[@"DiscoverCell"] style:UITableViewStyleGrouped];
    [self.tableScrollView addSubview:self.pageTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    return [_dataArr[section-1] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MeCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverCell" forIndexPath:indexPath];
        cell.dict = _dataArr[indexPath.section-1][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

@end
