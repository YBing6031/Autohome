//
//  FindCarController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "FindCarController.h"
#import "HeadScrollView.h"
#import "TableScrollView.h"
#import "Net.h"
#import "PageTableView.h"
#import "HeadViewContent.h"
#import "BrandGroup.h"
#import "Brand.h"
#import "MJExtension.h"
#import "BrandCell.h"
#import "ShowView.h"
#import "Hotsaleserie.h"
#import "Hotserie.h"
#import "HotserieCell.h"
#import "ShowCarMsgController.h"
#import "FCT.h"
#import "Serie.h"
#import "Metalist.h"
#import "Meta.h"
#import "HeadViewContent.h"
#import "FilterCell.h"
#import "SerieTwo.h"
#import "Specitemgroup.h"
#import "Spec.h"
#import "FilterResultController.h"
#import "DownPrice.h"
#import "DownPriceCell.h"
#import "DataBase.h"

@interface FindCarController ()<UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate, HeadScrollViewDelegate>
@property (weak, nonatomic) IBOutlet HeadScrollView *navScrollView;
@property (weak, nonatomic) IBOutlet TableScrollView *tableScrollView;

@property (strong , nonatomic) NSArray *urls;

@property (strong , nonatomic) NSMutableArray *tableViewArr;
@property (strong , nonatomic) NSMutableArray *brandGroupArr;
@property (strong , nonatomic) UITableView *currentPopTableView;
@property (strong , nonatomic) NSMutableArray *hotsaleseries;

@property (strong, nonatomic) NSMutableArray *fctArr;

@property (strong, nonatomic) Metalist *metalist;

@property (strong, nonatomic) NSMutableDictionary *filterDict;

@property (strong, nonatomic) UIButton *totalButton;

@property (strong, nonatomic) NSMutableArray *serieTwoArr;

@property (strong, nonatomic) NSDictionary *totalDict;

@property (strong, nonatomic) NSArray *filterConditionArr;

@property (strong, nonatomic) FilterCell *currentSelectCell;

@property (strong, nonatomic) NSMutableArray *downPriceArr;

@property (strong, nonatomic) NSMutableArray *collects;

@end

@implementation FindCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.urls = @[FindCarAllBrandURL, FindCarFilterURL, FindCarDownPriceURL, FindCar2SCURL];
    
    self.filterConditionArr = @[@"品牌", @"价格", @"级别", @"国别", @"变速箱", @"结构", @"排量", @"燃料", @"配置"];
    
    [self.view addSubview:[[UIView alloc] initWithFrame:CGRectZero]];
    self.brandGroupArr = [NSMutableArray array];
    self.tableViewArr = [NSMutableArray array];
    self.hotsaleseries = [NSMutableArray array];
    
    
    self.navScrollView.headViewcontents = @[[HeadViewContent headViewContentWithName:@"品牌"], [HeadViewContent headViewContentWithName:@"刷选"], [HeadViewContent headViewContentWithName:@"降价"], [HeadViewContent headViewContentWithName:@"找二手车"]];
    self.navScrollView.headScrollViewDelegate = self;
    
    //新建tableView
    for (int i = 0; i < 4; i++)
    {
        UITableViewStyle style = UITableViewStylePlain;
        if (i == 2) {
            style = UITableViewStyleGrouped;
        }
        PageTableView *tableView = [PageTableView pageTableView:CGRectMake(i*kScreenW, 0, kScreenW, kScreenH-20-35-49) delegate:self tag:i+1 registerNibNames:@[@"BrandCell", @"FilterCell", @"DownPriceCell"] style:style];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if (i == 1) {
            tableView.y = 35;
            tableView.height = kScreenH-20-35-49-64-35;
        }
        [self.tableScrollView addSubview:tableView];
        [self.tableViewArr addObject:tableView];
    }
    self.tableScrollView.contentSize = CGSizeMake(kScreenW*4, 0);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kScreenW, kScreenH-64-49-20-35, kScreenW, 64)];
    bgView.backgroundColor = [UIColor grayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(8, 8, kScreenW-8*2, 48);
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.backgroundColor = [UIColor blueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(totalButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.totalButton = button;
    [bgView addSubview:button];
    [self.tableScrollView addSubview:bgView];
    
    //添加筛选条件的头视图
    [self addFilterHeaderView];
    
    [Net sendAsynchronousWithURL:FindCarAllBrandURL tag:1 delegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCollect:) name:AddColletNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cacelCollect:) name:CacelColletNotificationName object:nil];
}

- (void)addCollect:(NSNotification *)notification
{
    if (self.collects == nil) {
        self.collects = [NSMutableArray array];
        DataBase *db = [DataBase shareDataBase];
        [db selectCollect:self.collects];
    }
    [self.collects addObject:notification.object];
}

- (void)cacelCollect:(NSNotification *)notification
{
    [self.collects removeObject:notification.object];
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

- (void)addFilterHeaderView
{
    UIView *filterView = [[UIView alloc] initWithFrame:CGRectMake(kScreenW, 0, kScreenW, 35)];
    filterView.backgroundColor = RGB(220, 220, 220);
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 25)];
    lab.text = @"筛选条件";
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:12];
    [filterView addSubview:lab];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(kScreenW-100, 0, 100, 35);
    [clearBtn setImage:[UIImage imageNamed:@"bar_btn_icon_shut"] forState:UIControlStateNormal];
    
    [clearBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    clearBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [clearBtn setTitle:@"清空条件" forState:UIControlStateNormal];
    [filterView addSubview:clearBtn];
    [self.tableScrollView addSubview:filterView];
}

- (void)clearBtnClick:(UIButton *)button
{
    self.filterDict = nil;
    [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    [self.tableViewArr[1] reloadData];
}

- (void)totalButtonOnClick:(UIButton *)button
{
    FilterResultController *filterResultCtl = [[FilterResultController alloc] init];
    filterResultCtl.dataArr = self.serieTwoArr;
    filterResultCtl.totalDict = self.totalDict;
    [self.navigationController pushViewController:filterResultCtl animated:YES];
}

- (void)popViewWithTitles:(NSArray *)titles frame:(CGRect)frame tableTag:(NSInteger)tag block:(void(^)(id, id))block
{
    ShowView *showView = [[ShowView alloc] initWithSegmentTitles:titles frame:frame delegate:self dataSource:self];
    showView.block = block;
    self.currentPopTableView = showView.tableView;
    self.currentPopTableView.tag = tag;
    [showView show];
    [self.currentPopTableView reloadData];
}

- (void)popViewWithTitles:(NSArray *)titles frame:(CGRect)frame tableTag:(NSInteger)tag
{
    ShowView *showView = [[ShowView alloc] initWithTitles:titles frame:frame delegate:self dataSource:self];
    self.currentPopTableView = showView.tableView;
    self.currentPopTableView.tag = tag;
    [showView show];
    [self.currentPopTableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 1)//品牌
    {
        return self.brandGroupArr.count?self.brandGroupArr.count + 2:0;
    }
    else if (tableView.tag == 2)//筛选
    {
        return 1;
    }
    else if (tableView.tag == 3)//降价
    {
        return self.downPriceArr.count;
    }
    else if (tableView.tag == 200)//我的收藏
    {
        return 1;
    }
    else if (tableView.tag == 201)//热销车
    {
        return self.hotsaleseries.count;
    }
    else if (tableView.tag == 202)
    {
        return self.fctArr.count;
    }
    else if (tableView.tag == 203)//筛选条件 品牌
    {
        return self.brandGroupArr.count + 1;
    }
    else if (tableView.tag == 204 || tableView.tag == 205 || tableView.tag == 206 || tableView.tag == 207 || tableView.tag == 208 || tableView.tag == 209 || tableView.tag == 210 || tableView.tag == 211)//价格 级别 国别 变速箱 结构 排量 燃料 配置
    {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1)//品牌
    {
        if (self.brandGroupArr.count) {
            if (section < 2) {
                return 1;
            }
            else {
                return [[self.brandGroupArr[section-2] list] count];
            }
        }
    }
    else if (tableView.tag == 2)//筛选
    {
        return self.metalist.metalist.count;
    }
    else if (tableView.tag == 3)//降价
    {
        return 1;
    }
    else if (tableView.tag == 200)//我的收藏
    {
        return self.collects.count;
    }
    else if (tableView.tag == 201) //热销车
    {
        return [[self.hotsaleseries[section] hotseries] count];
    }
    else if (tableView.tag == 202)
    {
        return [[self.fctArr[section] serieslist] count];
    }
    else if (tableView.tag == 203)
    {
        if (section == 0) {
            return 1;
        }
        return [[self.brandGroupArr[section-1] list] count];
    }
    else if (tableView.tag == 204)
    {
        return [[self.metalist.metalist[2] list] count];
    }
    else if (tableView.tag == 205)//级别
    {
        return [[self.metalist.metalist[0] list] count];
    }
    else if (tableView.tag == 206)//国别
    {
        return [[self.metalist.metalist[1] list] count];
    }
    else if (tableView.tag == 207)//变速箱
    {
        return [[self.metalist.metalist[4] list] count];
    }
    else if (tableView.tag == 208)//结构
    {
        return [[self.metalist.metalist[3] list] count];
    }
    else if (tableView.tag == 209)//排量
    {
        return [[self.metalist.metalist[6] list] count];
    }
    else if (tableView.tag == 210)//燃料
    {
        return [[self.metalist.metalist[8] list] count];
    }
    else if (tableView.tag == 211)//配置
    {
        return [[self.metalist.metalist[7] list] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 1)//品牌
    {
        BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.customBrand = [Brand brandWithName:@"我的收藏" imgurl:@"findcar_icon_collect"];
        }
        else if (indexPath.section == 1) {
            cell.customBrand = [Brand brandWithName:@"热销车" imgurl:@"icon_hot"];
        }
        else {
            Brand *brand = [self.brandGroupArr[indexPath.section-2] list][indexPath.row];
            cell.brand = brand;
        }
        return cell;
    }
    else if (tableView.tag == 2)//筛选
    {
        FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
        
        cell.keyLabel.text = self.filterConditionArr[indexPath.row];
        cell.valueLabel.text = @"不限";
        return cell;
    }
    else if (tableView.tag == 3)//降价
    {
        DownPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownPriceCell" forIndexPath:indexPath];
        DownPrice *downPrice = self.downPriceArr[indexPath.section];
        cell.downPrice = downPrice;
        return cell;
    }
    else if (tableView.tag == 200)//我的收藏
    {
        HotserieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotserieCell" forIndexPath:indexPath];
        NSDictionary *serieDict = self.collects[indexPath.row];
        cell.serie = [Serie serieWithID:[serieDict[@"seriesid"] integerValue] name:serieDict[@"name"] price:serieDict[@"price"] imgurl:serieDict[@"imgurl"]];
        return cell;
    }
    else if (tableView.tag == 201)//热销车
    {
        HotserieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotserieCell" forIndexPath:indexPath];
        Hotserie *hotserie = [self.hotsaleseries[indexPath.section] hotseries][indexPath.row];
        cell.hotserie = hotserie;
        return cell;
    }
    else if (tableView.tag == 202)
    {
        HotserieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotserieCell" forIndexPath:indexPath];
        Serie *serie = [self.fctArr[indexPath.section] serieslist][indexPath.row];
        cell.serie = serie;
        return cell;
    }
    else if (tableView.tag == 203)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.textLabel.text = @"全部";
        } else {
            Brand *brand = [self.brandGroupArr[indexPath.section-1] list][indexPath.row];
            cell.textLabel.text = brand.name;
        }
        return cell;
    }
    else if (tableView.tag == 204)//价格
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[2] list][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = headViewContent.name;
        return cell;
    }
    else if (tableView.tag == 205)
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[0] list][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        if ([self.filterDict[@"l"] integerValue] == [headViewContent.value integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = headViewContent.name;
        return cell;
    }
    else if (tableView.tag == 206)
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[1] list][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        if ([self.filterDict[@"c"] integerValue] == [headViewContent.value integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = headViewContent.name;
        return cell;
    }
    else if (tableView.tag == 207)
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[4] list][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        if ([self.filterDict[@"b"] integerValue] == [headViewContent.value integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = headViewContent.name;
        return cell;
    }
    else if (tableView.tag == 208)
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[3] list][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        if ([self.filterDict[@"st"] integerValue] == [headViewContent.value integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = headViewContent.name;
        return cell;
    }
    else if (tableView.tag == 209)
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[6] list][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = headViewContent.name;
        return cell;
    }
    else if (tableView.tag == 210)//燃料
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[8] list][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        if ([self.filterDict[@"f"] integerValue] == [headViewContent.value integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = headViewContent.name;
        return cell;
    }
    else if (tableView.tag == 211)//配置
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[7] list][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        if ([self.filterDict[@"conf"] integerValue] == [headViewContent.value integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = headViewContent.name;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 1) {//品牌
        if (indexPath.section == 0)//我的收藏
        {
            if (self.collects == nil) {
                self.collects = [NSMutableArray array];
                DataBase *db = [DataBase shareDataBase];
                [db selectCollect:self.collects];
            }
            [self popViewWithTitles:@[@"我的收藏", @"关闭"] frame:CGRectMake(0, 55, 300, kScreenH-55-49) tableTag:200];
            [self.currentPopTableView registerNib:[UINib nibWithNibName:@"HotserieCell" bundle:nil] forCellReuseIdentifier:@"HotserieCell"];
        }
        else if (indexPath.section == 1)//热销车
        {
            [self popViewWithTitles:@[@"轿车", @"SUV"] frame:CGRectMake(0, 55, 300, kScreenH-55-49) tableTag:201 block:^(FindCarController *vc, UISegmentedControl *segmentCtl) {
                [Net sendAsynchronousWithURL:FindCarHotsaleURL(segmentCtl.selectedSegmentIndex) tag:201 delegate:self];
            }];
            [Net sendAsynchronousWithURL:FindCarHotsaleURL(0) tag:201 delegate:self];
        }
        else {
            Brand *brand = [self.brandGroupArr[indexPath.section-2] list][indexPath.row];
            [self popViewWithTitles:@[@"在售", @"全部"] frame:CGRectMake(0, 55, 300, kScreenH-55-49) tableTag:202 block:^(FindCarController *vc, UISegmentedControl *segmentCtl) {
                [Net sendAsynchronousWithURL:FindCarClickBrandURL(brand.id, segmentCtl.selectedSegmentIndex+1) tag:202 delegate:self];
            }];
            [Net sendAsynchronousWithURL:FindCarClickBrandURL(brand.id, 1) tag:202 delegate:self];
        }
    }
    else if (tableView.tag == 2)//筛选
    {
        [self popViewWithTitles:@[[NSString stringWithFormat:@"选择%@", self.filterConditionArr[indexPath.row]], @"关闭"] frame:CGRectMake(0, 20, 300, kScreenH-20) tableTag:203+indexPath.row];
        self.currentSelectCell = (FilterCell *)[tableView cellForRowAtIndexPath:indexPath];
    }
    else if (tableView.tag == 200)//我的收藏
    {
        ShowCarMsgController *showCarMsgCtl = [[ShowCarMsgController alloc] init];
        NSDictionary *serieDict = self.collects[indexPath.row];
        showCarMsgCtl.serie = [Serie serieWithID:[serieDict[@"seriesid"] integerValue] name:serieDict[@"name"] price:serieDict[@"price"] imgurl:serieDict[@"imgurl"]];
        [(ShowView *)self.currentPopTableView.superview close];
        [self.navigationController pushViewController:showCarMsgCtl animated:YES];
    }
    else if (tableView.tag == 201) //热销车
    {
        ShowCarMsgController *showCarMsgCtl = [[ShowCarMsgController alloc] init];
        Hotserie *hotserie = [self.hotsaleseries[indexPath.section] hotseries][indexPath.row];
        showCarMsgCtl.hotserie = hotserie;
        
        [(ShowView *)self.currentPopTableView.superview close];
        [self.navigationController pushViewController:showCarMsgCtl animated:YES];
    }
    else if (tableView.tag == 202)
    {
        ShowCarMsgController *showCarMsgCtl = [[ShowCarMsgController alloc] init];
        Serie *serie = [self.fctArr[indexPath.section] serieslist][indexPath.row];
        showCarMsgCtl.serie = serie;
        
        [(ShowView *)self.currentPopTableView.superview close];
        [self.navigationController pushViewController:showCarMsgCtl animated:YES];
    }
    else if (tableView.tag == 203)
    {
        if (indexPath.section > 0) {
            Brand *brand = [self.brandGroupArr[indexPath.section-1] list][indexPath.row];
            if (self.filterDict == nil) self.filterDict = [NSMutableDictionary dictionaryWithCapacity:0];
            [self.filterDict setObject:@(brand.id) forKey:@"bid"];
            self.currentSelectCell.valueLabel.text = brand.name;
        } else {
            [self.filterDict setObject:@(0) forKey:@"bid"];
            self.currentSelectCell.valueLabel.text = @"不限";
        }
        
        [(ShowView *)self.currentPopTableView.superview close];
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
    else if (tableView.tag == 204)//选择价格
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[2] list][indexPath.row];
        if (self.filterDict == nil) self.filterDict = [NSMutableDictionary dictionaryWithCapacity:0];
        NSArray *priceArr = [headViewContent.value componentsSeparatedByString:@"|"];
        [self.filterDict setObject:@([priceArr[0] integerValue] * 10000) forKey:@"mip"];
        [self.filterDict setObject:@([priceArr[1] integerValue] * 10000) forKey:@"map"];
        self.currentSelectCell.valueLabel.text = headViewContent.name;
        [(ShowView *)self.currentPopTableView.superview close];
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
    else if (tableView.tag == 205)
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[0] list][indexPath.row];
        if (self.filterDict == nil) self.filterDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [self.filterDict setObject:@([headViewContent.value integerValue]) forKey:@"l"];
        self.currentSelectCell.valueLabel.text = headViewContent.name;
        [(ShowView *)self.currentPopTableView.superview close];
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
    else if (tableView.tag == 206)
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[1] list][indexPath.row];
        if (self.filterDict == nil) self.filterDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [self.filterDict setObject:@([headViewContent.value integerValue]) forKey:@"c"];
        self.currentSelectCell.valueLabel.text = headViewContent.name;
        [(ShowView *)self.currentPopTableView.superview close];
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
    else if (tableView.tag == 207)
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[4] list][indexPath.row];
        if (self.filterDict == nil) self.filterDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [self.filterDict setObject:@([headViewContent.value integerValue]) forKey:@"b"];
        self.currentSelectCell.valueLabel.text = headViewContent.name;
        [(ShowView *)self.currentPopTableView.superview close];
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
    else if (tableView.tag == 208)//结构
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[3] list][indexPath.row];
        if (self.filterDict == nil) self.filterDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [self.filterDict setObject:@([headViewContent.value integerValue]) forKey:@"st"];
        self.currentSelectCell.valueLabel.text = headViewContent.name;
        [(ShowView *)self.currentPopTableView.superview close];
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
    else if (tableView.tag == 209)//选择排量
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[6] list][indexPath.row];
        if (self.filterDict == nil) self.filterDict = [NSMutableDictionary dictionaryWithCapacity:0];
        NSArray *midArr = [headViewContent.value componentsSeparatedByString:@"|"];
        [self.filterDict setObject:midArr[0] forKey:@"mid"];
        [self.filterDict setObject:midArr[1] forKey:@"mad"];
        self.currentSelectCell.valueLabel.text = headViewContent.name;
        [(ShowView *)self.currentPopTableView.superview close];
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
    else if (tableView.tag == 210)//燃料
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[8] list][indexPath.row];
        if (self.filterDict == nil) self.filterDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [self.filterDict setObject:@([headViewContent.value integerValue]) forKey:@"f"];
        self.currentSelectCell.valueLabel.text = headViewContent.name;
        [(ShowView *)self.currentPopTableView.superview close];
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
    else if (tableView.tag == 211)//配置
    {
        HeadViewContent *headViewContent = [self.metalist.metalist[7] list][indexPath.row];
        if (self.filterDict == nil) self.filterDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [self.filterDict setObject:@([headViewContent.value integerValue]) forKey:@"conf"];
        self.currentSelectCell.valueLabel.text = headViewContent.name;
        [(ShowView *)self.currentPopTableView.superview close];
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1)//品牌
    {
        if (section == 0) {
            return @"⭐️";
        }
        else if (section == 1) {
            return @"推荐";
        }
        else {
            return [self.brandGroupArr[section-2] letter];
        }
    }
    else if (tableView.tag == 201)//热销车
    {
        return [self.hotsaleseries[section] levelname];
    }
    else if (tableView.tag == 202)
    {
        return [self.fctArr[section] name];
    }
    else if (tableView.tag == 203)//选择品牌
    {
        if (section > 0) {
            return [self.brandGroupArr[section-1] letter];
        } else {
            return @" ";
        }
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView.tag == 1) {
        NSMutableArray *letterArr = [NSMutableArray array];
        for (BrandGroup *brandGroup in self.brandGroupArr) {
            [letterArr addObject:brandGroup.letter];
        }
        return letterArr;
    }
    else if (tableView.tag == 203) {
        NSMutableArray *letterArr = [NSMutableArray array];
        for (BrandGroup *brandGroup in self.brandGroupArr) {
            [letterArr addObject:brandGroup.letter];
        }
        return letterArr;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1 || tableView.tag == 201 || tableView.tag == 202 || tableView.tag == 203) {
        return 21;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView.tag == 3) {
        return 15;
    }
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView.tag == 1) {
        return index+2;
    }
    else if (tableView.tag == 203) {
        return index+1;
    }
    return index;
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = request.responseData;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"result"];
    if (request.tag == 1)//返回车的全部品牌
    {
        NSArray *brandArr = dict[@"brandlist"];
        for (NSDictionary *brandGroupDict in brandArr) {
            BrandGroup *brandGroup = [BrandGroup objectWithKeyValues:brandGroupDict];
            [self.brandGroupArr addObject:brandGroup];
        }
        ((PageTableView *)self.tableViewArr[request.tag - 1]).isRefresh = YES;
        [self.tableViewArr[request.tag - 1] reloadData];
    }
    else if (request.tag == 2)//筛选
    {
        self.metalist = [Metalist objectWithKeyValues:dict];
        
        ((PageTableView *)self.tableViewArr[request.tag - 1]).isRefresh = YES;
        [self.tableViewArr[request.tag - 1] reloadData];
    }
    else if (request.tag == 3) //降价
    {
        if (self.downPriceArr == nil) {
            self.downPriceArr = [NSMutableArray array];
        }
        for (NSDictionary *downPriceDict in dict[@"carlist"]) {
            [self.downPriceArr addObject:[DownPrice objectWithKeyValues:downPriceDict]];
        }
        ((PageTableView *)self.tableViewArr[request.tag - 1]).isRefresh = YES;
        [self.tableViewArr[request.tag - 1] reloadData];
    }
    else if (request.tag == 11)//筛选
    {
        self.totalDict = @{@"rowcount":dict[@"rowcount"], @"totalspeccount":dict[@"totalspeccount"]};
        [self.totalButton setTitle:[NSString stringWithFormat:@"共%zi个车系%zi个车型符合条件", [dict[@"rowcount"] integerValue], [dict[@"totalspeccount"] integerValue]] forState:UIControlStateNormal];
        if (self.serieTwoArr == nil) {
            self.serieTwoArr = [NSMutableArray array];
        } else {
            [self.serieTwoArr removeAllObjects];
        }
        for (NSDictionary *serieDict in dict[@"seriesitems"]) {
            [self.serieTwoArr addObject:[SerieTwo objectWithKeyValues:serieDict]];
        }
    }
    else if (request.tag == 201)//返回热销车
    {
        NSArray *hotArr = dict[@"list"];
        [self.hotsaleseries removeAllObjects];
        for (NSDictionary *hotDict in hotArr) {
            Hotsaleserie *hot = [Hotsaleserie objectWithKeyValues:hotDict];
            [self.hotsaleseries addObject:hot];
        }
        [self.currentPopTableView reloadData];
    }
    else if (request.tag == 202)//点击车品牌返回的数据
    {
        NSArray *fctArr = dict[@"fctlist"];
        if (self.fctArr == nil) {
            self.fctArr = [NSMutableArray array];
        }
        [self.fctArr removeAllObjects];
        for (NSDictionary *fctDict in fctArr) {
            FCT *fct = [FCT objectWithKeyValues:fctDict];
            [self.fctArr addObject:fct];
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
    self.navScrollView.bottomView.x += (offsetX-endX)/7;
    endX = offsetX;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[TableScrollView class]]) return;
    //计算出第几页
    int page = scrollView.contentOffset.x/kScreenW;
    //改变导航栏上的buttonr
    self.navScrollView.currentSelectIndex = page;
    
    if (((PageTableView *)self.tableViewArr[page]).isRefresh) return;
    [Net sendAsynchronousWithURL:self.urls[page] tag:page+1 delegate:self];
    if (page == 1) {
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[TableScrollView class]]) return;
    //计算出第几页
    int page = scrollView.contentOffset.x/kScreenW;
    //改变导航栏上的buttonr
    self.navScrollView.currentSelectIndex = page;
    
    //按钮点击完之后把 该标记设为no 不然滚动 bottomview就不会跟着滚动了
    self.navScrollView.isBtnClicked = NO;
    
    if (((PageTableView *)self.tableViewArr[page]).isRefresh) return;
    [Net sendAsynchronousWithURL:self.urls[page] tag:page+1 delegate:self];
    if (page == 1) {
        [Net sendAsynchronousWithURL:FindCarFilterURL1([self.filterDict[@"mip"] integerValue], [self.filterDict[@"map"] integerValue], [self.filterDict[@"l"] integerValue], [self.filterDict[@"c"] integerValue], [self.filterDict[@"b"] integerValue], [self.filterDict[@"st"] integerValue], [self.filterDict[@"mid"] floatValue], [self.filterDict[@"mad"] floatValue], [self.filterDict[@"conf"] integerValue], [self.filterDict[@"bid"] integerValue], [self.filterDict[@"f"] integerValue]) tag:11 delegate:self];
    }
}

#pragma mark - HeadScrollViewDelegate
- (void)headScrollView:(HeadScrollView *)headScrollView onClickIndex:(NSInteger)index
{
    [self.tableScrollView setContentOffset:CGPointMake((index-1)*kScreenW, 0) animated:YES];
}


@end
