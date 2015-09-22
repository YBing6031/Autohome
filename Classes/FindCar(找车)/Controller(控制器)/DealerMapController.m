//
//  DealerMapController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/17.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "DealerMapController.h"
#import <MapKit/MapKit.h>
#import "Dealer.h"
#import "Manager.h"

@interface DealerMapController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DealerMapController

- (void)setDealer:(Dealer *)dealer
{
    _dealer = dealer;
    self.location = [[CLLocation alloc] initWithLatitude:[dealer.lat doubleValue] longitude:[dealer.lon doubleValue]];
}

- (void)rightClick
{
    Manager *manager = [Manager sharedManager];
    CLLocation *currentLocation = manager.location;
    //创建导航请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    //设置交通方式
    request.transportType = MKDirectionsTransportTypeAny;
    //设置起点
    MKPlacemark *mkplSource = [[MKPlacemark alloc] initWithCoordinate:currentLocation.coordinate addressDictionary:nil];
    request.source = [[MKMapItem alloc] initWithPlacemark:mkplSource];
    //设置终点
    MKPlacemark *mkplDestination = [[MKPlacemark alloc] initWithCoordinate:self.location.coordinate addressDictionary:nil];
    request.destination = [[MKMapItem alloc] initWithPlacemark:mkplDestination];
    //创建导航对象
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        //NSLog(@"%zi", response.routes.count);
        //获取路线
        MKRoute *route = [response.routes firstObject];
        //添加路线到地图上
        [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveLabels];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"地图";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"到这去" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    //定位
    CLLocationCoordinate2D coordinate = self.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
    [self addAnno];
}

//添加标注
- (void)addAnno
{
    //给地图添加标注
    MKPointAnnotation *pointAnno = [[MKPointAnnotation alloc] init];
    pointAnno.coordinate = self.location.coordinate;//给标注指定经纬度
    //如果不设置标题则无法弹出气泡
    pointAnno.title = self.dealer.name;
    [self.mapView addAnnotation:pointAnno];//将标注加入地图
    //自动弹出气泡
    [self.mapView selectAnnotation:pointAnno animated:NO];
}

//将标注显示出来   addAnnotation时 会调用该方法
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *anno  = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    //是否弹出信息
    anno.canShowCallout = YES;
    //点标注弹出图片
    anno.image = [UIImage imageNamed:@"pinRed"];
    return anno;
}

//设置导航路线 并渲染时候调用
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *polyline = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    //线宽
    polyline.lineWidth = 2;
    //画笔的颜色
    polyline.strokeColor = [UIColor blueColor];
    return polyline;
}

@end
