//
//  ShowCarMsgController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/11.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "ShowCarMsgController.h"
#import "Net.h"
#import "MJExtension.h"
#import "Car.h"
#import "Engine.h"
#import "Spec.h"
#import "Param.h"
#import "SpecCell.h"
#import "CarMessageCell.h"
#import "CarMessageTwoCell.h"
#import "HeaderCarMsgView.h"
#import "TableScrollView.h"
#import "PageTableView.h"
#import "Picture.h"
#import "CategoryMe.h"
#import "Color.h"
#import "Defaultpic.h"
#import "Image.h"
#import "DefaultpicCell.h"
#import "Dealer.h"
#import "DealerCell.h"
#import "TableViewHeaderView.h"
#import "ShowView.h"
#import "ImageCell.h"
#import "GetCityNum.h"
#import "Province.h"
#import "City.h"
#import "Club.h"
#import "Topic.h"
#import "TopicTwoCell.h"
#import "SeePostControler.h"
#import "KouBei.h"
#import "SpecTwoCell.h"
#import "KouBeiHeaderView.h"
#import "ShowCarMsgNews.h"
#import "NewsCell.h"
#import "Information.h"
#import "UIButton+WebCache.h"
#import "DealerMapController.h"
#import "UIImageView+WebCache.h"
#import "DataBase.h"
#import "Serie.h"
#import "Hotserie.h"


@interface ShowCarMsgController ()<ASIHTTPRequestDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic)Car *car;
@property (weak, nonatomic) IBOutlet HeaderCarMsgView *navView;
@property (weak, nonatomic) IBOutlet TableScrollView *tableScrollView;

@property (strong, nonatomic) NSMutableArray *tableViewArr;
@property (strong, nonatomic) NSMutableArray *specs;
@property (strong, nonatomic) NSArray *urls;

@property (strong, nonatomic) Picture *picture;//图片
@property (strong, nonatomic) NSMutableArray *dealers;//经销商

@property (strong, nonatomic) UITableView *currentPopTableView;

@property (strong, nonatomic) Spec *currentSpec;
@property (strong, nonatomic) Color *currentColor;
@property (strong, nonatomic) CategoryMe *currentCategory;

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSDictionary *provinceDict;//存放所有省份
@property (strong, nonatomic) NSArray *firstletterArr;//存放所有省份的拼音首字母

@property (strong, nonatomic)Province *currentProvince;

@property (strong, nonatomic)Club *club;//论坛页面数据

@property (assign, nonatomic) NSInteger currentIndex;//论坛页面当前选择的是最后回复 还是最新发布 还是精华帖

@property (strong, nonatomic) KouBei *koubei;//口碑页面的数据
@property (assign, nonatomic) BOOL isStopSale;//在售 还是停售

@property (strong, nonatomic) UIWebView *webView;//详解页面的webView

@property (strong, nonatomic) Information *information;//资讯页面

@property (strong, nonatomic) UIImageView *headerView;//综述里面的头视图
@property (strong, nonatomic) UILabel *picCountLabel;//综述里面的头视图
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@end

@implementation ShowCarMsgController
- (IBAction)collectClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    DataBase *db = [DataBase shareDataBase];
    if (sender.selected)//收藏
    {
        [db insertCollectToDataBaseWithSeriesid:self.seriesid name:self.name price:self.price imgurl:self.imgurl];
        [[NSNotificationCenter defaultCenter] postNotificationName:AddColletNotificationName object:@{@"seriesid":@(self.seriesid), @"name":self.name, @"price":self.price, @"imgurl":self.imgurl} userInfo:nil];
    }
    else//取消收藏
    {
        [db deleteCollectWithSeriesid:self.seriesid];
        [[NSNotificationCenter defaultCenter] postNotificationName:CacelColletNotificationName object:@{@"seriesid":@(self.seriesid), @"name":self.name, @"price":self.price, @"imgurl":self.imgurl} userInfo:nil];
    }
}

- (void)setSerie:(Serie *)serie
{
    _serie = serie;
    self.seriesid = serie.id;
    self.name = serie.name;
    self.price = serie.price;
    self.imgurl = serie.imgurl;
}

- (void)setHotserie:(Hotserie *)hotserie
{
    _hotserie = hotserie;
    self.seriesid = hotserie.seriesid;
    self.name = hotserie.seriesname;
    self.price = hotserie.price;
    self.imgurl = hotserie.img;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断是否收藏了
    DataBase *db = [DataBase shareDataBase];
    self.collectBtn.selected = [db isCollectedWithSericesid:self.seriesid];
    
    self.urls = @[FindCarClickHotsaleURL(self.seriesid,@""), ShowCarImageURL(self.seriesid, 0, 0, 0), ShowCarDealerURL(self.seriesid,440300,0), ShowCarBBSURL(self.seriesid), ShowCarKouBeiURL(self.seriesid), ShowCarExplainURL(self.seriesid, self.name), ShowCarNewsURL(self.seriesid)];
    
    self.tableViewArr = [NSMutableArray array];
    
    [self.view addSubview:[[UIView alloc] initWithFrame:CGRectZero]];
    
    //设置navigationbar
    [self setupNavigationBar];
    
    //设置不向下偏移
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //创建7个tableView
    //新建tableView
    for (int i = 0; i < 7; i++)
    {
        if (i == 5)//详解 不需要创建tableView  创建webView
        {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(i*kScreenW, 0, kScreenW, kScreenH-70-20)];
            self.webView = webView;
            [self.tableScrollView addSubview:webView];
            continue;
        }
        UITableViewStyle style;
        if (i == 1 || i == 2 || i ==3 || i == 4) {
            style = UITableViewStylePlain;
        } else {
            style = UITableViewStyleGrouped;
        }
        
        PageTableView *tableView = [PageTableView pageTableView:CGRectMake(i*kScreenW, 0, kScreenW, kScreenH-70-20) delegate:self tag:i+1 registerNibNames:@[@"SpecCell", @"CarMessageCell", @"CarMessageTwoCell", @"DefaultpicCell", @"DealerCell", @"TopicTwoCell", @"SpecTwoCell", @"NewsCell"] style:style];
        [self.tableScrollView addSubview:tableView];
        [self.tableViewArr addObject:tableView];
        
    }
    self.tableScrollView.contentSize = CGSizeMake(kScreenW*7, 0);
    
    //设置collectionView
    [self setupCollectionView];
    
    //请求数据
    [Net sendAsynchronousWithURL:FindCarClickHotsaleURL(self.seriesid,@"") tag:1 delegate:self];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        self.view = nil;
    }
}

- (void)setupNavigationBar
{
    self.navView.titles = @[@"返回", @"综述", @"图片", @"经销商", @"论坛", @"口碑", @"详解", @"资讯"];
    self.navView.block = ^(HeaderCarMsgView *headerView, NSInteger index) {
        if (index == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            self.navView.currentIndex = index - 1;
            [self.tableScrollView setContentOffset:CGPointMake(kScreenW*(index-1), 0) animated:YES];
        }
    };
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(kScreenW/3, kScreenW/4);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenW, 44, kScreenW, kScreenH-20-70-44) collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)valueChange:(UISegmentedControl *)segmentCtl
{
    self.currentIndex = segmentCtl.selectedSegmentIndex;
    if (segmentCtl.selectedSegmentIndex == 0) {//最后回复
        [Net sendAsynchronousWithURL:ShowCarBBSURL(self.seriesid) tag:4 delegate:self];
    }
    else if (segmentCtl.selectedSegmentIndex == 1) {//最新发布
        [Net sendAsynchronousWithURL:ShowCarBBSURL(self.seriesid) tag:4 delegate:self];
    }
    else {//精华帖
        [Net sendAsynchronousWithURL:ShowCarBBSURL(self.seriesid) tag:4 delegate:self];
    }
}

- (void)headerViewOnClik
{
    [self.tableScrollView setContentOffset:CGPointMake(kScreenW, 0) animated:YES];
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = request.responseData;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"result"];
    if (request.tag == 1)//综述
    {
        Car *car = [Car objectWithKeyValues:dict];
        car.sc2count = [dict[@"2sccount"] integerValue];
        self.car = car;
        if (self.specs == nil) {
            self.specs = [NSMutableArray array];
        }
        [self.specs removeAllObjects];
        for (Engine *engine in self.car.enginelist) {
            for (Spec *spec in engine.speclist) {
                [self.specs addObject:spec];
            }
        }
        UIButton *headerView = [UIButton buttonWithType:UIButtonTypeCustom];
        headerView.frame = CGRectMake(0, 0, kScreenW, 200);
        headerView.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [headerView sd_setImageWithURL:[NSURL URLWithString:self.car.logo] forState:UIControlStateNormal];
        [headerView addTarget:self action:@selector(headerViewOnClik) forControlEvents:UIControlEventTouchUpInside];
        UILabel *picCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-100, headerView.height-30, 100, 30)];
        picCountLabel.textColor = [UIColor whiteColor];
        picCountLabel.textAlignment = NSTextAlignmentCenter;
        picCountLabel.font = [UIFont systemFontOfSize:12];
        picCountLabel.text = [NSString stringWithFormat:@"%zi张图片", self.car.piccount];
        self.picCountLabel = picCountLabel;
        PageTableView *tableView = (PageTableView*)self.tableViewArr[request.tag-1];
        [self.tableScrollView addSubview:picCountLabel];
        self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:self.car.logo]];
        self.headerView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerView.clipsToBounds = YES;
        [tableView setTableHeaderView:headerView];
        tableView.isRefresh = YES;
        [tableView reloadData];
    }
    else if (request.tag == 2)//图片
    {
        Picture *picture = [Picture objectWithKeyValues:dict];
        self.picture = picture;
        ((PageTableView*)self.tableViewArr[request.tag-1]).isRefresh = YES;
        [self.tableViewArr[request.tag-1] reloadData];
        if (self.currentCategory.id != 0) {
            [self.tableScrollView addSubview:self.collectionView];
            [self.collectionView reloadData];
        } else {
            [self.collectionView removeFromSuperview];
        }
    }
    else if (request.tag == 3)//经销商
    {
        NSArray *dealers = dict[@"dealerlist"];
        self.dealers = [NSMutableArray arrayWithArray:[Dealer objectArrayWithKeyValuesArray:dealers]];
        ((PageTableView*)self.tableViewArr[request.tag-1]).isRefresh = YES;
        [self.tableViewArr[request.tag-1] reloadData];
    }
    else if (request.tag == 4)//论坛
    {
        Club *club = [Club objectWithKeyValues:dict];
        self.club = club;
        ((PageTableView*)self.tableViewArr[request.tag-1]).isRefresh = YES;
        [self.tableViewArr[request.tag-1] reloadData];
    }
    else if (request.tag == 5)//口碑
    {
        KouBei *koubei = [KouBei objectWithKeyValues:dict];
        self.koubei = koubei;
        
        //创建tableview的头视图
        [self.tableViewArr[request.tag-1] setTableHeaderView:[KouBeiHeaderView kouBeiHeaderViewWithGrade:koubei.grade peoplenum:koubei.peoplenum frame:CGRectMake(0, 0, kScreenW, 95) block:^(KouBeiHeaderView *kouBeiHeaderView, NSInteger buttonIndex) {
            self.isStopSale = buttonIndex;
            [self.tableViewArr[request.tag-1] reloadData];
        }]];
        ((PageTableView*)self.tableViewArr[request.tag-1]).isRefresh = YES;
        [self.tableViewArr[request.tag-1] reloadData];
    }
    else if (request.tag == 6)//详解
    {
        NSString *htmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self.webView loadHTMLString:htmlStr baseURL:nil];
    }
    else if (request.tag == 7)//资讯
    {
        self.information = [Information objectWithKeyValues:dict];
        ((PageTableView*)self.tableViewArr[request.tag-2]).isRefresh = YES;
        [self.tableViewArr[request.tag-2] reloadData];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picture.piclist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.image = self.picture.piclist[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1) {
        return self.specs.count + 2;
    }
    else if (tableView.tag == 2) {
        return 1;
    }
    else if (tableView.tag == 3) {
        return 1;
    }
    else if (tableView.tag == 4)
    {
        return 1;
    }
    else if (tableView.tag == 5)
    {
        if (!self.isStopSale) {
            return self.koubei.selllist.count;
        }
        else {
            return self.koubei.stoplist.count;
        }
    }
    else if (tableView.tag == 7)
    {
        return 1;
    }
    else if (tableView.tag == 201)//全部车型
    {
        return 1;
    }
    else if (tableView.tag == 202)//全部颜色
    {
        return 1;
    }
    else if (tableView.tag == 203)//全部类型
    {
        return 1;
    }
    else if (tableView.tag == 205)//省份
    {
        return self.firstletterArr.count;
    }
    else if (tableView.tag == 206)//选择城市
    {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return 1;
    }
    else if (tableView.tag == 2) {
        return self.picture.defaultpiclist.count;
    }
    else if (tableView.tag == 3) {
        return self.dealers.count;
    }
    else if (tableView.tag == 4)
    {
        return self.club.list.count;
    }
    else if (tableView.tag == 5)
    {
        if (!self.isStopSale) {
            return [[self.koubei.selllist[section] specs] count];
        } else {
            return [[self.koubei.stoplist[section] specs] count];
        }
    }
    else if (tableView.tag == 7)
    {
        return self.information.list.count;
    }
    else if (tableView.tag == 201)//全部车型
    {
        return self.picture.speclist.count;
    }
    else if (tableView.tag == 202)//全部颜色
    {
        return self.picture.colorlist.count;
    }
    else if (tableView.tag == 203)//全部类型
    {
        return self.picture.categorylist.count;
    }
    else if (tableView.tag == 205)//省份
    {
        return [self.provinceDict[self.firstletterArr[section]] count];
    }
    else if (tableView.tag == 206)//选择城市
    {
        return self.currentProvince.citys.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1)//综述
    {
        if (indexPath.section == 0) {
            CarMessageTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarMessageTwoCell" forIndexPath:indexPath];
            cell.car = self.car;
            return cell;
        }
        else if (indexPath.section == 1) {
            CarMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarMessageCell" forIndexPath:indexPath];
            cell.delegate = self;
            [cell setCar:self.car delegate:^(NSInteger index) {
                if (index == 0)//在售
                {
                    [Net sendAsynchronousWithURL:FindCarClickHotsaleURL(self.seriesid, @"") tag:1 delegate:self];
                }
                else//停售
                {
                    [Net sendAsynchronousWithURL:FindCarClickHotsaleURL(self.seriesid, @"0x0010") tag:1 delegate:self];
                }
            }];
            return cell;
        }
        else {
            SpecCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecCell" forIndexPath:indexPath];
            Spec *spec = self.specs[indexPath.section - 2];
            cell.spec = spec;
            return cell;
        }
    }
    else if (tableView.tag == 2)//图片
    {
        DefaultpicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultpicCell" forIndexPath:indexPath];
        Defaultpic *defaultpic = self.picture.defaultpiclist[indexPath.row];
        cell.delegate = self;
        cell.allImageURL = ShowCarImageURL(self.seriesid, 0, [self.picture.categorylist[indexPath.row+1] id], 0);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.defaultpic = defaultpic;
        return cell;
    }
    else if (tableView.tag == 3) //经销商
    {
        DealerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealerCell" forIndexPath:indexPath];
        cell.dealer = self.dealers[indexPath.row];
        return cell;
    }
    else if (tableView.tag == 4)//论坛
    {
        TopicTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicTwoCell" forIndexPath:indexPath];
        cell.topic = self.club.list[indexPath.row];
        return cell;
    }
    else if (tableView.tag == 5)//口碑
    {
        SpecTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecTwoCell" forIndexPath:indexPath];
        Spec *spec = nil;
        if (self.isStopSale) {
            spec = [self.koubei.stoplist[indexPath.section] specs][indexPath.row];
        } else {
            spec = [self.koubei.selllist[indexPath.section] specs][indexPath.row];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.spec = spec;
        return cell;
    }
    else if (tableView.tag == 7)//资讯
    {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        ShowCarMsgNews *showCarMsgNews = self.information.list[indexPath.row];
        cell.showCarMsgNews = showCarMsgNews;
        return cell;
    }
    else if (tableView.tag == 201)//全部车型
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        Spec *spec = self.picture.speclist[indexPath.row];
        if (self.currentSpec.id == spec.id) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = spec.name;
        return cell;
    }
    else if (tableView.tag == 202)//全部颜色
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        Color *color = self.picture.colorlist[indexPath.row];
        if (self.currentColor.id == color.id) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = color.name;
        return cell;
    }
    else if (tableView.tag == 203)//全部类型
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        CategoryMe *category = self.picture.categorylist[indexPath.row];
        if (self.currentCategory.id == category.id) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = category.name;
        return cell;
    }
    else if (tableView.tag == 205)//省份
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        Province *province = self.provinceDict[self.firstletterArr[indexPath.section]][indexPath.row];
        cell.textLabel.text = province.name;
        return cell;
        
    }
    else if (tableView.tag == 206)//选择城市
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        City *city = self.currentProvince.citys[indexPath.row];
        cell.textLabel.text = city.name;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 3)//经销商
    {
        Dealer *dealer = self.dealers[indexPath.row];
        DealerMapController *dealerMapCtl = [[DealerMapController alloc] init];
        dealerMapCtl.dealer = dealer;
        [self.navigationController pushViewController:dealerMapCtl animated:YES];
    }
    else if (tableView.tag == 4)//论坛
    {
        SeePostControler *seePostCtl = [[SeePostControler alloc] init];
        seePostCtl.topicid = [self.club.list[indexPath.row] topicid];
        [self.navigationController pushViewController:seePostCtl animated:YES];
    }
    else if (tableView.tag == 201) {
        [(ShowView *)self.currentPopTableView.superview close];
        self.currentSpec = self.picture.speclist[indexPath.row];
        [Net sendAsynchronousWithURL:ShowCarImageURL(self.seriesid, self.currentSpec.id, self.currentCategory.id, self.currentColor.id) tag:2 delegate:self];
    }
    else if (tableView.tag == 202) {
        [(ShowView *)self.currentPopTableView.superview close];
        self.currentColor = self.picture.colorlist[indexPath.row];
        [Net sendAsynchronousWithURL:ShowCarImageURL(self.seriesid, self.currentSpec.id, self.currentCategory.id, self.currentColor.id) tag:2 delegate:self];
    }
    else if (tableView.tag == 203) {
        [(ShowView *)self.currentPopTableView.superview close];
        self.currentCategory = self.picture.categorylist[indexPath.row];
        [Net sendAsynchronousWithURL:ShowCarImageURL(self.seriesid, self.currentSpec.id, self.currentCategory.id, self.currentColor.id) tag:2 delegate:self];
    }
    else if (tableView.tag == 205)//省份
    {
        [self popViewWithTitles:@[@"选择城市", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:206];
        self.currentProvince = self.provinceDict[self.firstletterArr[indexPath.section]][indexPath.row];
        [self.currentPopTableView reloadData];
    }
    else if (tableView.tag == 206)//选择城市
    {
        City *city = self.currentProvince.citys[indexPath.row];
        [Net sendAsynchronousWithURL:ShowCarDealerURL(self.seriesid, city.id, 0) tag:3 delegate:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        if (section == 0) return CGFLOAT_MIN;
        else return 30;
    }
    else if (tableView.tag == 2 || tableView.tag == 3 || tableView.tag == 4) {
        return 44;
    }
    else if (tableView.tag == 5)
    {
        return 30;
    }
    else if (tableView.tag == 205)//省份
    {
        return 21;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)popViewWithTitles:(NSArray *)titles frame:(CGRect)frame tableTag:(NSInteger)tag
{
    ShowView *showView = [[ShowView alloc] initWithTitles:titles frame:frame delegate:self dataSource:self];
    self.currentPopTableView = showView.tableView;
    self.currentPopTableView.tag = tag;
    [showView show];
    [self.currentPopTableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2)//图片
    {
        TableViewHeaderView *headerView = [TableViewHeaderView tableViewHeaderViewWithFindTypes:@[@"全部车型", @"全部颜色", @"全部类型"] types:@[@(TableViewHeaderViewButtonTypeAllCarType), @(TableViewHeaderViewButtonTypeAllColor), @(TableViewHeaderViewButtonTypeAllType)] frame:CGRectMake(0, 0, kScreenW, 44)];
        headerView.block = ^(TableViewHeaderView *headerView, TableViewHeaderViewButtonType type){
            if (type == TableViewHeaderViewButtonTypeAllCarType)//点击全部车型按钮
            {
                [self popViewWithTitles:@[@"选择车型", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:201];
            }
            else if (type == TableViewHeaderViewButtonTypeAllColor)//点击全部颜色按钮
            {
                [self popViewWithTitles:@[@"选择颜色", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:202];
            }
            else if (type == TableViewHeaderViewButtonTypeAllType)//选择全部类型按钮
            {
                [self popViewWithTitles:@[@"选择类型", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:203];
            }
        };
        ((PageTableView *)tableView).headerView = headerView;
        return headerView;
    }
    else if (tableView.tag == 3)//经销商
    {
        if (section == 0) {
            TableViewHeaderView *headerView = [TableViewHeaderView tableViewHeaderViewWithFindTypes:@[@"排序", @"深圳"] types:@[@(TableViewHeaderViewButtonTypeLocationSort), @(TableViewHeaderViewButtonTypeAllProvince)] frame:CGRectMake(0, 0, kScreenW, 44)];
            headerView.block = ^(TableViewHeaderView *headerView, TableViewHeaderViewButtonType type){
                if (type == TableViewHeaderViewButtonTypeLocationSort)//点击排序按钮
                {
                    [self popViewWithTitles:@[@"排序方式", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:204];
                }
                else if (type == TableViewHeaderViewButtonTypeAllProvince)//点击省份按钮
                {
                    self.provinceDict = [GetCityNum getCityNum][@"provinceDict"];
                    self.firstletterArr = [GetCityNum getCityNum][@"firstletterArr"];
                    [self popViewWithTitles:@[@"选择省份", @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:205];
                }
            };
            ((PageTableView *)tableView).headerView = headerView;
            return headerView;
        }
    }
    else if (tableView.tag == 4) //论坛
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
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        int count = 2;
        if (section == 2) {
            return [[self.car.enginelist firstObject] name];
        }
        for (int i = 0; i < self.car.enginelist.count; i++)
        {
            count += (int)[[self.car.enginelist[i] speclist] count];
            if (count == section) {
                return [self.car.enginelist[i+1] name];
            }
        }
    }
    else if (tableView.tag == 5) {
        if (self.isStopSale) {
            return [self.koubei.stoplist[section] name];
        } else {
            return [self.koubei.selllist[section] name];
        }
    }
    else if (tableView.tag == 205)//省份
    {
        return self.firstletterArr[section];
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView.tag == 205)//省份
    {
        return self.firstletterArr;
    }
    return nil;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1) {
        CGFloat y = scrollView.contentOffset.y;
        static CGFloat offsetY;
        static CGFloat offsetCountLabelY;
        self.picCountLabel.y += offsetCountLabelY-y;
        if (y<0) {
            self.headerView.height += offsetY-y;
            [self.tableScrollView insertSubview:self.headerView belowSubview:self.picCountLabel];
            offsetY = y;
        } else {
            self.headerView.height = 200;
            [self.headerView removeFromSuperview];
        }
        offsetCountLabelY = y;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[TableScrollView class]]) return;
    //计算出第几页
    int page = scrollView.contentOffset.x/kScreenW;
    //改变导航栏上的buttonr
    self.navView.currentIndex = page;
    if (page == 6) {
        if (((PageTableView*)self.tableViewArr[page-1]).isRefresh) return;
        [Net sendAsynchronousWithURL:self.urls[page] tag:page+1 delegate:self];
        return;
    }
    else if (page == 5)
    {
        [Net sendAsynchronousWithURL:self.urls[page] tag:page+1 delegate:self];
        return;
    }
    if (((PageTableView*)self.tableViewArr[page]).isRefresh) return;
    [Net sendAsynchronousWithURL:self.urls[page] tag:page+1 delegate:self];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[TableScrollView class]]) return;
    //计算出第几页
    int page = scrollView.contentOffset.x/kScreenW;
    self.navView.currentIndex = page;
    if (page == 6) {
        if (((PageTableView*)self.tableViewArr[page-1]).isRefresh) return;
        [Net sendAsynchronousWithURL:self.urls[page] tag:page+1 delegate:self];
        return;
    }
    else if (page == 5)
    {
        [Net sendAsynchronousWithURL:self.urls[page] tag:page+1 delegate:self];
        return;
    }
    if (((PageTableView*)self.tableViewArr[page]).isRefresh) return;
    [Net sendAsynchronousWithURL:self.urls[page] tag:page+1 delegate:self];
}


@end
