//
//  BBSController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "BBSController.h"
#import "HeadScrollView.h"
#import "PageTableView.h"
#import "HeadViewContent.h"
#import "Net.h"
#import "MJExtension.h"
#import "Topic.h"
#import "Topiclist.h"
#import "NewsCell.h"
#import "TableScrollView.h"
#import "Manager.h"
#import "TableViewHeaderView.h"
#import "ShowView.h"
#import "Metalist.h"
#import "Meta.h"
#import "HeadViewContent.h"
#import "TableViewHeaderViewButton.h"
#import "SeePostControler.h"
#import "FavoriteCell.h"
#import "BBSTheme.h"
#import "FavoriteBBSController.h"
#import "AreaClub.h"
#import "MJRefresh.h"

@interface BBSController ()<HeadScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet HeadScrollView *navScrollView;
@property (weak, nonatomic) IBOutlet TableScrollView *tableScrollView;
@property (strong, nonatomic) NSMutableArray *tableViewArr;
@property (strong, nonatomic) Topiclist *topiclist;
@property (strong, nonatomic) UITableView *currentPopTableView;

@property (assign, nonatomic) NSInteger currentHeadViewContentValue;//当前栏目的value
@property (strong, nonatomic) UITableViewCell *currentCell;//当前栏目的cell
@property (strong, nonatomic) NSIndexPath *currentIndexPath;//当前栏目的indexpath

@property (strong, nonatomic) NSMutableArray *themes;

@property (strong, nonatomic)NSMutableDictionary *areamDict;//地区字典 key值为省份的拼音首字母 value值为省份的可变数组
@property (strong, nonatomic)NSMutableArray *areamArr;//地区数组 存放的是排序好了的省份拼音的首字母

@property (assign, nonatomic)NSInteger currentPage;
@property (assign, nonatomic)BOOL flag;

@property (assign, nonatomic) NSInteger currentValue;

@property (strong, nonatomic) TableViewHeaderView *headerView;

@end

@implementation BBSController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[[UIView alloc] initWithFrame:CGRectZero]];
    self.currentPage = 1;
    self.tableViewArr = [NSMutableArray array];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navScrollView.headViewcontents = @[[HeadViewContent headViewContentWithName:@"精选日报"], [HeadViewContent headViewContentWithName:@"常用论坛"]];
    self.navScrollView.headScrollViewDelegate = self;
    
    //添加导航视图
    [self addNavView];
    
    
    //新建tableView
    for (int i = 0; i < 2; i++)
    {
        PageTableView *tableView = [PageTableView pageTableView:CGRectMake(i*kScreenW, 0, kScreenW, kScreenH-20-35-49) delegate:self tag:i+1];
        if (i == 0) {
            [tableView addHeaderWithTarget:self action:@selector(onHeaderRefresh)];
            [tableView addFooterWithTarget:self action:@selector(onFooterRefresh)];
            tableView.y = 44;
            tableView.height -= 44;
        }
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.tableScrollView addSubview:tableView];
        [self.tableViewArr addObject:tableView];
    }
    self.tableScrollView.contentSize = CGSizeMake(kScreenW*2, 0);
    
    [Net sendAsynchronousWithURL:BBSJingXuanURL(0,self.currentPage) tag:1 delegate:self];
}

- (void)addNavView
{
    Manager *manager = [Manager sharedManager];
    NSArray *headViewContents = [manager.metalist.metalist[4] list];
    
    TableViewHeaderView *headerView = [TableViewHeaderView tableViewHeaderViewWithheadViewContents:headViewContents frame:CGRectMake(0, 0, kScreenW-44, 44)];
    headerView.block1 = ^(TableViewHeaderView *headerView, TableViewHeaderViewButton *button){
        Manager *manager = [Manager sharedManager];
        HeadViewContent *headViewContent = [manager.metalist.metalist[4] list][button.tag];
        self.currentHeadViewContentValue = [headViewContent.value integerValue];
        headerView.selectedButtonIndex = button.tag;
        
        self.currentIndexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
        
        self.flag = NO;
        self.currentValue = button.value;
        [Net sendAsynchronousWithURL:BBSJingXuanURL(button.value,1) tag:1 delegate:self];
    };
    headerView.showsHorizontalScrollIndicator = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    view.backgroundColor = RGB(250, 250, 250);
    [view addSubview:headerView];
    self.headerView = headerView;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenW-44, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"bar_btn_icon_album"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [self.tableScrollView addSubview:view];
}

//下拉刷新
- (void)onHeaderRefresh
{
    self.currentPage = 1;
    self.flag = NO;
    [Net sendAsynchronousWithURL:BBSJingXuanURL(self.currentValue,self.currentPage) tag:1 delegate:self];
}

- (void)onFooterRefresh
{
    self.currentPage++;
    self.flag = YES;
    [Net sendAsynchronousWithURL:BBSJingXuanURL(self.currentValue,self.currentPage) tag:1 delegate:self];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 1) {
        return 1;
    }
    else if (tableView.tag == 2) {
        return 1;
    }
    else if (tableView.tag == 201) {
        return 1;
    }
    else if (tableView.tag == 202) {
        return 1;
    }
    else if (tableView.tag == 203) {
        return self.areamArr.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return self.topiclist.list.count;
    }
    else if (tableView.tag == 2) {
        return 3;
    }
    else if (tableView.tag == 201) {
        Manager *manager = [Manager sharedManager];
        return [[manager.metalist.metalist[4] list] count];
    }
    else if (tableView.tag == 202) {
        return self.themes.count;
    }
    else if (tableView.tag == 203) {
        return [self.areamDict[self.areamArr[section]] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        Topic *topic = [self.topiclist list][indexPath.row];
        cell.topic = topic;
        
        return cell;
    }
    else if (tableView.tag == 2) {
        FavoriteCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FavoriteCell" owner:self options:nil] lastObject];
        if (indexPath.row == 0) [cell setIco:@"forum_icon_auto" title:@"车系论坛" subTitle:@"为你的爱车找到队伍"];
        else if (indexPath.row == 1) [cell setIco:@"forum_icon_location" title:@"地区论坛" subTitle:@"老乡见老乡，两眼泪汪汪"];
        else if (indexPath.row == 2) [cell setIco:@"forum_icon_theme" title:@"主题论坛" subTitle:@"兴趣爱好的聚集地"];
        return cell;
        
    }
    else if (tableView.tag == 201) {//分栏
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        Manager *manager = [Manager sharedManager];
        HeadViewContent *headViewContent = [manager.metalist.metalist[4] list][indexPath.row];
        if (self.currentHeadViewContentValue == [headViewContent.value integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.currentCell = cell;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = headViewContent.name;
        return cell;
    }
    else if (tableView.tag == 202) {//主题
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        BBSTheme *theme = self.themes[indexPath.row];
        cell.textLabel.text = theme.bbsname;
        return cell;
    }
    else if (tableView.tag == 203) {//地区
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        AreaClub *area = self.areamDict[self.areamArr[indexPath.section]][indexPath.row];
        cell.textLabel.text = area.bbsname;
        return cell;
        
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 203) {
        return self.areamArr[section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 203) {
        return 21;
    }
    return CGFLOAT_MIN;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView.tag == 203) {
        return self.areamArr;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 1) {
        SeePostControler *seePostCtl = [[SeePostControler alloc] init];
        Topic *topic = self.topiclist.list[indexPath.row];
        seePostCtl.topicid = topic.topicid;
        [self.navigationController pushViewController:seePostCtl animated:YES];
    }
    else if (tableView.tag == 2) {
        if (indexPath.row == 2) {//主题论坛
            [self popViewWithTitles:@[@"主题论坛", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:202];
            [Net sendAsynchronousWithURL:BBSThemeURL tag:202 delegate:self];
        }
        else if (indexPath.row == 1) {//地区论坛
            [self popViewWithTitles:@[@"地区论坛", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:203];
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AHCache" ofType:@"plist"]];
            NSString *jsonStr = dict[@"AreaClub"];
            NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *areaArr = dataDict[@"result"][@"list"];
            if (self.areamDict == nil) {
                self.areamDict = [NSMutableDictionary dictionaryWithCapacity:0];
                for (NSDictionary *areaDict in areaArr) {
                    AreaClub *area = [AreaClub objectWithKeyValues:areaDict];
                    if (self.areamDict[area.firstletter] == nil) {
                        [self.areamDict setObject:[NSMutableArray arrayWithCapacity:0] forKey:area.firstletter];
                    }
                    [self.areamDict[area.firstletter] addObject:area];
                }
                self.areamArr = [NSMutableArray arrayWithArray:[self.areamDict allKeys]];
                [self.areamArr sortUsingSelector:@selector(compare:)];
            }
            [self.currentPopTableView reloadData];
        }
    }
    else if (tableView.tag == 201) {
        self.flag = NO;
        self.currentCell.accessoryType = UITableViewCellAccessoryNone;
        Manager *manager = [Manager sharedManager];
        HeadViewContent *headViewContent = [manager.metalist.metalist[4] list][indexPath.row];
        self.currentHeadViewContentValue = [headViewContent.value integerValue];
        self.currentCell = [tableView cellForRowAtIndexPath:indexPath];
        self.currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.currentIndexPath = indexPath;
        //发送请求刷新数据
        if (self.themes == nil) {
            [Net sendAsynchronousWithURL:BBSJingXuanURL([headViewContent.value integerValue], 1) tag:1 delegate:self];
        }
        self.currentValue = [headViewContent.value integerValue];
        self.headerView.selectedButtonIndex = indexPath.row;
        
        [(ShowView *)self.currentPopTableView.superview close];
    }
    else if (tableView.tag == 202) {
        FavoriteBBSController *favoriteBBSCtl = [[FavoriteBBSController alloc] init];
        BBSTheme *theme = self.themes[indexPath.row];
        favoriteBBSCtl.theme = theme;
        favoriteBBSCtl.navigationItem.title = theme.bbsname;
        //关闭popview
        [(ShowView *)[self.currentPopTableView superview] close];
        [self.navigationController pushViewController:favoriteBBSCtl animated:YES];
    }
    else if (tableView.tag == 203) {
        FavoriteBBSController *favoriteBBSCtl = [[FavoriteBBSController alloc] init];
        AreaClub *area = self.areamDict[self.areamArr[indexPath.section]][indexPath.row];
        favoriteBBSCtl.area = area;
        favoriteBBSCtl.navigationItem.title = area.bbsname;
        //关闭popview
        [(ShowView *)[self.currentPopTableView superview] close];
        [self.navigationController pushViewController:favoriteBBSCtl animated:YES];
    }
}

- (void)popViewWithTitles:(NSArray *)titles frame:(CGRect)frame tableTag:(NSInteger)tag
{
    ShowView *showView = [[ShowView alloc] initWithTitles:titles frame:frame delegate:self dataSource:self];
    self.currentPopTableView = showView.tableView;
    self.currentPopTableView.tag = tag;
    [showView show];
    [self.currentPopTableView reloadData];
}

- (void)popView:(UIButton *)button
{
    [self popViewWithTitles:@[@"栏目分类", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:201];
    [self.currentPopTableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = request.responseData;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"result"];
    if (request.tag == 1) {
        
        [self.tableViewArr[0] headerEndRefreshing];
        [self.tableViewArr[0] footerEndRefreshing];
        Topiclist *topiclist = [Topiclist objectWithKeyValues:dict];
        if (!self.flag)//下拉刷新
        {
            self.topiclist = topiclist;
        } else {
            [self.topiclist.list addObjectsFromArray:topiclist.list];
        }
        [self.tableViewArr[request.tag - 1] reloadData];
    }
    if (request.tag == 202) {//主题论坛
        NSArray *themes = dict[@"list"];
        if (self.themes == nil) {
            self.themes = [NSMutableArray array];
            for (NSDictionary *themeDict in themes) {
                BBSTheme *theme = [BBSTheme objectWithKeyValues:themeDict];
                [self.themes addObject:theme];
            }
        }
        [self.currentPopTableView reloadData];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[TableScrollView class]]) return;
    static CGFloat endX;
    CGFloat offsetX = scrollView.contentOffset.x;
    if (self.navScrollView.isBtnClicked)
    {
        endX = offsetX;
        return;
    }
    self.navScrollView.bottomView.x += (offsetX-endX)/4;
    endX = offsetX;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[TableScrollView class]]) return;
    //计算出第几页
    int page = scrollView.contentOffset.x/kScreenW;
    //改变导航栏上的buttonr
    self.navScrollView.currentSelectIndex = page;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //按钮点击完之后把 该标记设为no 不然滚动 bottomview就不会跟着滚动了
    self.navScrollView.isBtnClicked = NO;
}

#pragma mark - HeadScrollViewDelegate
- (void)headScrollView:(HeadScrollView *)headScrollView onClickIndex:(NSInteger)index
{
    [self.tableScrollView setContentOffset:CGPointMake((index-1)*kScreenW, 0) animated:YES];
}

@end
