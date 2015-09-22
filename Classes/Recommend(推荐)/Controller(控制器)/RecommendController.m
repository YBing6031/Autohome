//
//  RecommendController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "RecommendController.h"
#import "Recommend.h"

@interface RecommendController ()<ASIHTTPRequestDelegate, UITableViewDataSource, UITableViewDelegate, HeadScrollViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong)NSMutableDictionary *dataDict;//里面存放cell的数据

@property (nonatomic, strong)NSMutableDictionary *allBrandDict;//key值为品牌的id value值为brand模型
@property (nonatomic, strong)NSMutableDictionary *allLevelDict;//key值为级别的levelid value值为Level模型
@property (nonatomic, strong)NSMutableDictionary *allMovieDict;//key值为HeadViewContent的value value值为HeadViewContent模型

@property (nonatomic, strong)NSDictionary *provinceDict;//所有的省份
@property (nonatomic, strong)NSArray *firstletterArr;//所有的省份排好序的首字母数组

@property (nonatomic, strong)NSArray *urlArr;
@property (nonatomic, strong)NSMutableArray *tableViewArr;

@property (nonatomic, strong)UITableView *currentPopTableView;

@property (nonatomic, strong)NSMutableDictionary *currentCellDict;//记录当前选中的cell

@property (nonatomic, assign)NSInteger brandid;//记录当前选择的品牌id
@property (nonatomic, assign)NSInteger levelid;//记录当前选择的级别id
@property (nonatomic, copy) NSString *movievalue;//记录当前视频选择的value
@property (nonatomic, assign)City *currentSelectCity;//记录当前选择的城市city


@property (nonatomic, strong)NSIndexPath *currentProvinceIndexPath;//记录当前选择的省份indexpath

@property (nonatomic, strong) UIView *headerView;//记录当前的头视图

@property (assign, nonatomic) NSInteger currentTableViewIndex;
@property (assign, nonatomic) BOOL flag;//记录是上拉刷新 还是下拉刷新

@property (nonatomic, strong) CLLocationManager *locationMgr;
@property (nonatomic, strong) CLGeocoder *geocoder;//地理位置编码与反编码
@end

@implementation RecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self location];
    
    [self.view addSubview:[[UIView alloc] initWithFrame:CGRectZero]];
    
    self.currentCellDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    self.dataDict = [NSMutableDictionary dictionaryWithCapacity:0];
    self.tableViewArr = [NSMutableArray arrayWithCapacity:0];
    self.urlArr = @[RecommendTableViewURL1(1), RecommendTableViewURL2, RecommendTableViewURL3(0), RecommendTableViewURL4, RecommendTableViewURL5(1), RecommendTableViewURL6, RecommendTableViewURL7(110100), RecommendTableViewURL8, RecommendTableViewURL9, RecommendTableViewURL10, RecommendTableViewURL11, RecommendTableViewURL12, RecommendTableViewURL13, RecommendTableViewURL14];
    
    [Net sendAsynchronousWithURL:HeaderViewURL tag:100 delegate:self];
    [Net sendAsynchronousWithURL:LivingURL tag:101 delegate:self];
    [Net sendAsynchronousWithURL:self.urlArr[0] tag:1 delegate:self];
//    [MBProgressHUD showMessage:@"正在加载中"];
}

- (void)location
{
    _geocoder = [[CLGeocoder alloc] init];
    
    _locationMgr = [[CLLocationManager alloc] init];
    //定位精度 精度越高 定位所需时间越长
    _locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    //重新定位所需移动的最小距离  kCLDistanceFilterNone表示任意的距离移动都会导致重新定位
    _locationMgr.distanceFilter = kCLDistanceFilterNone;
    _locationMgr.delegate = self;
    //开始更新地理位置
    if ([CLLocationManager locationServicesEnabled]) {
        //请求用户授权
        [_locationMgr requestAlwaysAuthorization];
        //开始定位
        [_locationMgr startUpdatingLocation];
    } else {
        NSLog(@"location service not enabled!");
    }
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self =  [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
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

//下拉刷新
- (void)onHeaderRefresh
{
    self.flag = YES;
    [Net sendAsynchronousWithURL:self.urlArr[self.currentTableViewIndex] tag:self.currentTableViewIndex+1 delegate:self];
}

//上拉刷新
- (void)onFooterRefresh
{
    self.flag = NO;
    PageTableView *tableView = self.tableViewArr[self.currentTableViewIndex];
    [Net sendAsynchronousWithURL:RecommendTableViewURL1(++tableView.page) tag:self.currentTableViewIndex+1 delegate:self];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
//    [MBProgressHUD hideHUD];
    [Net netIsReachable];
    if (self.tableViewArr.count) {
        [self.tableViewArr[self.currentTableViewIndex] headerEndRefreshing];
        [self.tableViewArr[self.currentTableViewIndex] footerEndRefreshing];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
//    [MBProgressHUD hideHUD];
    if (self.tableViewArr.count) {
        [self.tableViewArr[self.currentTableViewIndex] headerEndRefreshing];
        [self.tableViewArr[self.currentTableViewIndex] footerEndRefreshing];
    }
    if (request.tag>=1 && request.tag<=14) {
        if (self.flag)//下拉刷新
        {
            if (request.tag == 2|| request.tag == 3|| request.tag == 13|| request.tag == 14) {
                [self.dataDict[@(self.currentTableViewIndex+1)] removeAllObjects];
            }
            else {
                PageDataModel *model = self.dataDict[@(self.currentTableViewIndex+1)];
                [model.newslist removeAllObjects];
            }
        }

    }
    
    NSData *data = request.responseData;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    dict = dict[@"result"];
    if (request.tag == 100)//返回的是导航栏上分类的数据
    {
        Metalist *metalist = [Metalist objectWithKeyValues:dict];
        
        //保存到单例中去
        Manager *manager = [Manager sharedManager];
        manager.metalist = metalist;
        
        [self.dataDict setObject:metalist forKey:@(request.tag)];
        self.navScrollView.headViewcontents = [metalist.metalist[0] list];
        self.navScrollView.headScrollViewDelegate = self;
        
        int count = (int)self.navScrollView.headViewcontents.count;
        //新建tableView
        for (int i = 0; i < count; i++)
        {
            PageTableView *tableView = [PageTableView pageTableView:CGRectMake(i*kScreenW, 0, kScreenW, kScreenH-20-35-49) style:UITableViewStyleGrouped tag:i+1 delegate:self dataSource:self cellNib:@"NewsCell" rowHeight:77];
            [tableView addHeaderWithTarget:self action:@selector(onHeaderRefresh)];
            [tableView addFooterWithTarget:self action:@selector(onFooterRefresh)];
            [self.tableScrollView addSubview:tableView];
            [self.tableViewArr addObject:tableView];
        }
        
        if (self.headerView) {
            if (self.tableViewArr.count) {
                [self.tableViewArr[0] setTableHeaderView:self.headerView];
            }
        }
        
        //保存到字典中
        if (self.allMovieDict == nil) {
            self.allMovieDict = [NSMutableDictionary dictionaryWithCapacity:0];
            for (HeadViewContent *headViewContent in [metalist.metalist[3] list]) {
                [self.allMovieDict setObject:headViewContent forKey:headViewContent.value];
            }
        }
        self.tableScrollView.contentSize = CGSizeMake(kScreenW*count, 0);
    }
    else if (request.tag == 101)//返回的是正在直播的数据
    {
        if ([dict[@"albumid"] integerValue] == 0) return;
        Live *live = [Live objectWithKeyValues:dict];
        [self.dataDict setObject:live forKey:@"live"];
        if (self.tableViewArr.count) {
            [self.tableViewArr[0] reloadData];
        }
    }
    else if (request.tag == 2)//快报
    {
        NSArray *array = dict[@"list"];
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
        NSString *class = @"Fastnews";
        for (NSDictionary *dict in array) {
            id obj = [NSClassFromString(class) objectWithKeyValues:dict];
            [mArr addObject:obj];
        }
        [self.dataDict setObject:mArr forKey:@(request.tag)];
        
        PageTableView *pageTableView = self.tableViewArr[request.tag-1];
        pageTableView.isRefresh = YES;
        [pageTableView reloadData];
    }
    else if (request.tag == 3 || request.tag == 13 || request.tag == 14){
        NSArray *array = dict[@"list"];
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
        NSString *class = request.tag == 14 ? @"Shuoke" : @"Movie";
        for (NSDictionary *dict in array) {
            id obj = [NSClassFromString(class) objectWithKeyValues:dict];
            [mArr addObject:obj];
        }
        [self.dataDict setObject:mArr forKey:@(request.tag)];
        
        PageTableView *pageTableView = self.tableViewArr[request.tag-1];
        pageTableView.isRefresh = YES;
        [pageTableView reloadData];
    }
    else if (request.tag == 201)//全部品牌的数据
    {
        NSArray *array = dict[@"brandlist"];
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
        NSString *class = @"BrandGroup";
        for (NSDictionary *dict in array) {
            id obj = [NSClassFromString(class) objectWithKeyValues:dict];
            [mArr addObject:obj];
        }
        [self.dataDict setObject:mArr forKey:@(request.tag)];
        //保存到字典中
        if (self.allBrandDict == nil) {
            self.allBrandDict = [NSMutableDictionary dictionaryWithCapacity:0];
            for (BrandGroup *brandGroup in self.dataDict[@(request.tag)]) {
                for (Brand *brand in brandGroup.list) {
                    [self.allBrandDict setObject:brand forKey:@(brand.id)];
                }
            }
        }
        [self.currentPopTableView reloadData];
    }
    else if (request.tag == 202)//全部级别数据
    {
        NSArray *array = dict[@"list"];
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
        NSString *class = @"Level";
        for (NSDictionary *dict in array) {
            id obj = [NSClassFromString(class) objectWithKeyValues:dict];
            [mArr addObject:obj];
        }
        [self.dataDict setObject:mArr forKey:@(request.tag)];
        
        if (self.allLevelDict == nil) {
            self.allLevelDict = [NSMutableDictionary dictionaryWithCapacity:0];
            for (Level *level in mArr) {
                [self.allLevelDict setObject:level forKey:@(level.levelid)];
            }
        }
        [self.currentPopTableView reloadData];
    }
    else {
        if (!dict) return;
        PageDataModel *model = [PageDataModel objectWithKeyValues:dict];
        
        if (self.dataDict[@(request.tag)]) {
            PageDataModel *model1 = self.dataDict[@(request.tag)];
            [model1.newslist addObjectsFromArray:model.newslist];
        } else {
            [self.dataDict setObject:model forKey:@(request.tag)];
        }
        PageTableView *pageTableView = nil;
        if (self.tableViewArr.count) {
            pageTableView = self.tableViewArr[request.tag-1];
        }
        if (model.focusimg.count)
        {
            self.headerView = [HeaderView headerViewWithFocusimgs:model.focusimg frame:CGRectMake(0, 0, kScreenW, kScreenW/2)];
            if (pageTableView != nil) {
                pageTableView.tableHeaderView = self.headerView;
            }
        }
        
        pageTableView.isRefresh = YES;
        [pageTableView reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1) {
        if (self.dataDict[@"live"]) {
            return 2;
        }
    }
    else if (tableView.tag == 201) {
        return [self.dataDict[@(tableView.tag)] count] + 1;
    }
    else if (tableView.tag == 202) {
        return 1;
    }
    else if (tableView.tag == 203) {
        return 1;
    }
    else if (tableView.tag == 204) {
        return self.firstletterArr.count;
    }
    else if (tableView.tag == 205) {
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1) {
        if (self.dataDict[@"live"]) {
            if (section == 0) {
                return 1;
            } else {
                return [[self.dataDict[@(tableView.tag)] newslist] count];
            }
        }
    }
    else if (tableView.tag == 201) {
        if (section == 0) return 1;
        else return [[self.dataDict[@(tableView.tag)][section-1] list] count];
    }
    else if (tableView.tag == 202) {
        return [self.dataDict[@(tableView.tag)] count];
    }
    else if (tableView.tag == 203) {
        return [[[self.dataDict[@(100)] metalist][3] list] count];
    }
    else if (tableView.tag == 204) {
        return [self.provinceDict[self.firstletterArr[section]] count];
    }
    else if (tableView.tag == 3 || tableView.tag == 13 || tableView.tag == 14 || tableView.tag == 2) return [self.dataDict[@(tableView.tag)] count];
    else if (tableView.tag == 205) {
        return [[self.provinceDict[self.firstletterArr[self.currentProvinceIndexPath.section]][self.currentProvinceIndexPath.row] citys] count];
    }
    return [[self.dataDict[@(tableView.tag)] newslist] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1 && self.dataDict[@"live"] && indexPath.section==0) {
        LiveCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"LiveCell" owner:self options:nil] lastObject];
        cell.live = self.dataDict[@"live"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (tableView.tag == 201) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.textLabel.text = @"全部";
        } else {
            cell.textLabel.text = [[self.dataDict[@(tableView.tag)][indexPath.section-1] list][indexPath.row] name];
        }
        return cell;
    }
    else if (tableView.tag == 202) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        Level *level = self.dataDict[@(tableView.tag)][indexPath.row];
        if (self.levelid == level.levelid) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.currentCellDict setObject:cell forKey:@(tableView.tag)];
        }
        cell.textLabel.text = level.levelname;
        return cell;
    }
    else if (tableView.tag == 203) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        HeadViewContent *headContent = [[self.dataDict[@(100)] metalist][3] list][indexPath.row];
        TableViewHeaderViewButton *button = ((PageTableView *)self.tableViewArr[tableView.tag-200-1]).headerView.buttons[0];
        if ([button.currentTitle isEqualToString:headContent.name]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.currentCellDict setObject:cell forKey:@(tableView.tag)];
        }
        cell.textLabel.text = headContent.name;
        return cell;
    }
    else if (tableView.tag == 204)//选择省份
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        Province *province = self.provinceDict[self.firstletterArr[indexPath.section]][indexPath.row];
        cell.textLabel.text = province.name;
        return cell;
    }
    else if (tableView.tag == 205) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        City *city = [self.provinceDict[self.firstletterArr[self.currentProvinceIndexPath.section]][self.currentProvinceIndexPath.row] citys][indexPath.row];
        cell.textLabel.text = city.name;
        return cell;
    }
    else if (tableView.tag == 2) {
        FastnewsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FastnewsTwoCell"];
        cell.fastnews = self.dataDict[@(tableView.tag)][indexPath.row];
        return cell;
    }
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    if (tableView.tag == 3 || tableView.tag == 13 || tableView.tag == 14) {
        id obj = self.dataDict[@(tableView.tag)][indexPath.row];
        NSString *key = tableView.tag == 14 ? @"shuoke" : @"movie";
        [cell setValue:obj forKey:key];
    } else {
        News *news = [self.dataDict[@(tableView.tag)] newslist][indexPath.row];
        if (news.mediatype == 6)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageNewsCell" owner:self options:nil] lastObject];
        }
        else if (news.mediatype == 7)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FastnewsCell" owner:self options:nil] lastObject];
        }
        if (news.id == [[self.dataDict[@(tableView.tag)] headlineinfo] id]) {
            cell.headlineinfo = [self.dataDict[@(tableView.tag)] headlineinfo];
        } else {
            cell.news = news;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2 || tableView.tag == 3 || tableView.tag == 7) {
        return 44;
    }
    else if (tableView.tag == 201) {
        return 25;
    }
    else if (tableView.tag == 204) {
        return 21;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView.tag == 201) {
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
        for (BrandGroup *bg in self.dataDict[@(tableView.tag)]) {
            [mArr addObject:bg.letter];
        }
        return mArr;
    }
    else if (tableView.tag == 204) {
        return self.firstletterArr;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView.tag == 201) {
        return index+1;
    }
    return index;
}

#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 1) {
        BaseCell *cell = (BaseCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (cell.mediatype == 1 || cell.mediatype == 2 || cell.mediatype == 3)//新闻 说客 视频
        {
            News *news = [cell valueForKey:@"headlineinfo"];
            if (!news) {//如果不为空就表示为头条
                news = [cell valueForKey:@"news"];
            }
            SelectNewsController *selectNewsVC = [[SelectNewsController alloc] init];
            selectNewsVC.news = news;
            [self.navigationController pushViewController:selectNewsVC animated:YES];
        }
        else if (cell.mediatype == 5)//论坛
        {
            SeePostControler *seePostCtl = [[SeePostControler alloc] init];
            News *news = [self.dataDict[@(tableView.tag)] newslist][indexPath.row];
            seePostCtl.topicid = news.id;
            [self.navigationController pushViewController:seePostCtl animated:YES];
            
        }
        else if (cell.mediatype == 6)//图片
        {
            PhotoBrowserViewController *photoVC = [[PhotoBrowserViewController alloc] init];
            photoVC.news = [self.dataDict[@(tableView.tag)] newslist][indexPath.row];
            [self.navigationController pushViewController:photoVC animated:YES];
        }
        else if (cell.mediatype == 7)//快报
        {
            SelectFastnewsController *selectFastNewsVC = [[SelectFastnewsController alloc] init];
            News *news = [cell valueForKey:@"news"];
            selectFastNewsVC.news = news;
            [self.navigationController pushViewController:selectFastNewsVC animated:YES];
        }
    }
    
    else if (tableView.tag == 2)//快报
    {
        SelectFastnewsController *selectFastNewsVC = [[SelectFastnewsController alloc] init];
        Fastnews *fastnews = self.dataDict[@(tableView.tag)][indexPath.row];
        selectFastNewsVC.fastnews = fastnews;
        [self.navigationController pushViewController:selectFastNewsVC animated:YES];
    }

    else if (tableView.tag == 3 || tableView.tag == 13)//视频
    {
        Movie *movie = self.dataDict[@(tableView.tag)][indexPath.row];
        SelectNewsController *selectNewsCtl = [[SelectNewsController alloc] init];
        selectNewsCtl.movie = movie;
        [self.navigationController pushViewController:selectNewsCtl animated:YES];
    }
    
    else if (tableView.tag == 4 || tableView.tag == 5 || tableView.tag == 6 || tableView.tag == 8 || tableView.tag == 9 || tableView.tag == 10 || tableView.tag == 11 || tableView.tag == 12) //新闻
    {
        PageDataModel *pageDataModel = self.dataDict[@(tableView.tag)];
        News *news = [pageDataModel newslist][indexPath.row];
        SelectNewsController *selectNewsCtl = [[SelectNewsController alloc] init];
        selectNewsCtl.news = news;
        [self.navigationController pushViewController:selectNewsCtl animated:YES];
    }
    
    else if (tableView.tag == 7)//行情
    {
        PageDataModel *pageDataModel = self.dataDict[@(tableView.tag)];
        News *news = [pageDataModel newslist][indexPath.row];
        SelectMarketController *selectMarketCtl = [[SelectMarketController alloc] init];
        selectMarketCtl.news = news;
        [self.navigationController pushViewController:selectMarketCtl animated:YES];
    }
    
    else if (tableView.tag == 14)//说客
    {
        Shuoke *shuoke = self.dataDict[@(tableView.tag)][indexPath.row];
        SelectNewsController *selectNewsCtl = [[SelectNewsController alloc] init];
        selectNewsCtl.shuoke = shuoke;
        [self.navigationController pushViewController:selectNewsCtl animated:YES];
    }
    
    else if (tableView.tag == 201)//表示为全部品牌
    {
        [(ShowView *)self.currentPopTableView.superview close];
        //刷选数据
        if (indexPath.section >= 1) {
            BrandGroup *brandGroup = self.dataDict[@(tableView.tag)][indexPath.section-1];
            Brand *brand = [brandGroup list][indexPath.row];
            self.brandid = [brand id];
        } else {
            self.brandid = 0;
        }
        [Net sendAsynchronousWithURL:FastnewsBrushURL(self.brandid, self.levelid) tag:2 delegate:self];
        
    }
    else if (tableView.tag == 202)//全部级别
    {
        [(ShowView *)self.currentPopTableView.superview close];
        UITableViewCell *cell = self.currentCellDict[@(tableView.tag)];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.currentCellDict setObject:[tableView cellForRowAtIndexPath:indexPath] forKey:@(tableView.tag)];
        cell = self.currentCellDict[@(tableView.tag)];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        Level *level = self.dataDict[@(tableView.tag)][indexPath.row];
        
        //刷选数据
        self.levelid = level.levelid;
        [Net sendAsynchronousWithURL:FastnewsBrushURL(self.brandid, self.levelid) tag:2 delegate:self];
    }
    else if (tableView.tag == 203)//视频分类
    {
        [(ShowView *)self.currentPopTableView.superview close];
        UITableViewCell *cell = self.currentCellDict[@(tableView.tag)];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.currentCellDict setObject:[tableView cellForRowAtIndexPath:indexPath] forKey:@(tableView.tag)];
        cell = self.currentCellDict[@(tableView.tag)];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        HeadViewContent *headContent = [[self.dataDict[@(100)] metalist][3] list][indexPath.row];
        //刷新数据
        self.movievalue = headContent.value;
        [Net sendAsynchronousWithURL:RecommendTableViewURL3([headContent.value integerValue]) tag:3 delegate:self];
    }
    else if (tableView.tag == 204)//选择省份
    {
        self.currentProvinceIndexPath = indexPath;
        [((ShowView *)self.currentPopTableView.superview) close];
        [self popViewWithTitles:@[@"选择城市", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:205];
        [self.currentPopTableView reloadData];
    }
    else if (tableView.tag == 205)//选择城市
    {
        City *city = [self.provinceDict[self.firstletterArr[self.currentProvinceIndexPath.section]][self.currentProvinceIndexPath.row] citys][indexPath.row];
        [Net sendAsynchronousWithURL:RecommendTableViewURL7(city.id) tag:7 delegate:self];
        self.currentSelectCity = city;
        [(ShowView *)self.currentPopTableView.superview close];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 201 && section!=0) {
        return [self.dataDict[@(tableView.tag)][section-1] letter];
    }
    else if (tableView.tag == 204) {
        return self.firstletterArr[section];
    }
    return nil;
}

- (void)popViewWithTitles:(NSArray *)titles frame:(CGRect)frame tableTag:(NSInteger)tag
{
    ShowView *showView = [[ShowView alloc] initWithTitles:titles frame:frame delegate:self dataSource:self];
    self.currentPopTableView = showView.tableView;
    self.currentPopTableView.tag = tag;
    [showView show];
    [self.currentPopTableView reloadData];
}

#pragma mark 返回表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2)//快报
    {
        //获取要显示的文字
        NSString *brandStr = [self.allBrandDict[@(self.brandid)] name];
        if (brandStr == nil) {
            brandStr = @"全部品牌";
        }
        NSString *levelStr = [self.allLevelDict[@(self.levelid)] levelname];
        if (levelStr == nil) {
            levelStr = @"全部级别";
        }
        TableViewHeaderView *headerView = [TableViewHeaderView tableViewHeaderViewWithFindTypes:@[brandStr, levelStr] types:@[@(TableViewHeaderViewButtonTypeAllBrand), @(TableViewHeaderViewButtonTypeAllLevel)] frame:CGRectMake(0, 0, kScreenW, 44)];
        headerView.block = ^(TableViewHeaderView *headerView, TableViewHeaderViewButtonType type){
            if (type == TableViewHeaderViewButtonTypeAllBrand)//点击全部品牌按钮
            {
                [self popViewWithTitles:@[@"选择品牌", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:201];
                [Net sendAsynchronousWithURL:AllBrandURL tag:201 delegate:self];//请求数据
            }
            if (type == TableViewHeaderViewButtonTypeAllLevel)//点击全部级别按钮
            {
                [self popViewWithTitles:@[@"选择级别", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:202];
                [Net sendAsynchronousWithURL:AllLevelURL tag:202 delegate:self];
            }
        };
        
        ((PageTableView *)tableView).headerView = headerView;
        return headerView;
    }
    
    if (tableView.tag == 3)//视频
    {
        //获取表头显示的文字
        NSString *movieStr = [self.allMovieDict[self.movievalue] name];
        
        if (movieStr==nil) {
            movieStr = @"全部";
        }
        TableViewHeaderView *headerView = [TableViewHeaderView tableViewHeaderViewWithFindTypes:@[movieStr] types:@[@(TableViewHeaderViewButtonTypeAllMovie)] frame:CGRectMake(0, 0, kScreenW, 44)];
        headerView.block = ^(TableViewHeaderView *headerView, TableViewHeaderViewButtonType type){
            if (type == TableViewHeaderViewButtonTypeAllMovie)//点击全部视频按钮
            {
                [self popViewWithTitles:@[@"视频分类", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:203];
            }
        };
        ((PageTableView *)tableView).headerView = headerView;
        return headerView;
    }
    
    if (tableView.tag == 7)//行情
    {
        
        //获取表头显示的文字
        NSString *provinceStr = self.currentSelectCity.name;
        
        if (provinceStr==nil) {
            provinceStr = @"全国";
        }
        TableViewHeaderView *headerView = [TableViewHeaderView tableViewHeaderViewWithFindTypes:@[provinceStr] types:@[@(TableViewHeaderViewButtonTypeAllProvince)] frame:CGRectMake(0, 0, kScreenW, 44)];
        headerView.block = ^(TableViewHeaderView *headerView, TableViewHeaderViewButtonType type){
            if (type == TableViewHeaderViewButtonTypeAllProvince)//点击选择省份按钮
            {
                [self popViewWithTitles:@[@"选择省份", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:204];
                
                self.provinceDict = [GetCityNum getCityNum][@"provinceDict"];
                self.firstletterArr = [GetCityNum getCityNum][@"firstletterArr"];
                
                [self.currentPopTableView reloadData];
            }
        };
        ((PageTableView *)tableView).headerView = headerView;
        return headerView;
    }
    return nil;
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
    self.navScrollView.bottomView.x += (offsetX-endX)/7;
    endX = offsetX;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[TableScrollView class]]) return;
    //计算出第几页
    int page = scrollView.contentOffset.x/kScreenW;
    self.currentTableViewIndex = page;
    //改变导航栏上的buttonr
    self.navScrollView.currentSelectIndex = page;
    PageTableView *pageTableView = self.tableViewArr[page];
    if (pageTableView.isRefresh) return;
    [Net sendAsynchronousWithURL:self.urlArr[page] tag:page+1 delegate:self];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[HeadScrollView class]]) return;
    //计算出第几页
    int page = scrollView.contentOffset.x/kScreenW;
    self.currentTableViewIndex = page;
    PageTableView *pageTableView = self.tableViewArr[page];
    
    //按钮点击完之后把 该标记设为no 不然滚动 bottomview就不会跟着滚动了
    self.navScrollView.isBtnClicked = NO;
    
    if (pageTableView.isRefresh) return;
    [Net sendAsynchronousWithURL:self.urlArr[page] tag:page+1 delegate:self];
    
}

#pragma mark - HeadScrollViewDelegate
- (void)headScrollView:(HeadScrollView *)headScrollView onClickIndex:(NSInteger)index
{
    [self.tableScrollView setContentOffset:CGPointMake((index-1)*kScreenW, 0) animated:YES];
}

#pragma mark - CLLocationManagerDelegate
//获取地理位置时调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //停止定位
    [self.locationMgr stopUpdatingLocation];
    //获取一个位置
    CLLocation *location = [locations firstObject];
    [[Manager sharedManager] setLocation:location];
    
    //地理位置反编码 将经纬度信息转换为真实的位置
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        CLPlacemark *clpk = placemarks[0];
        NSDictionary *dict = clpk.addressDictionary;
        NSLog(@"%@", dict);
        NSLog(@"%@%@", dict[@"State"], dict[@"City"]);
    }];
    
}

//获取地理位置出错时调用
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}
@end
