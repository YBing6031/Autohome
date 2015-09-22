//
//  FilterResultController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/15.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "FilterResultController.h"
#import "FilterResultCell.h"

@interface FilterResultController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FilterResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"筛选结果";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FilterResultCell" bundle:nil] forCellReuseIdentifier:@"FilterResultCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 84;
    
    UIView *tarbar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-49, kScreenW, 49)];
    tarbar.backgroundColor = RGB(250, 250, 250);
    
    UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, kScreenW, 21)];
    totalLabel.text = [NSString stringWithFormat:@"共%zi个车系%zi个车型", [self.totalDict[@"rowcount"] integerValue], [self.totalDict[@"totalspeccount"] integerValue]];
    totalLabel.font = [UIFont systemFontOfSize:12];
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.textColor = [UIColor grayColor];
    [tarbar addSubview:totalLabel];
    
    [self.view addSubview:tarbar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterResultCell" forIndexPath:indexPath];
    cell.serieTwo = self.dataArr[indexPath.row];
    return cell;
}

@end
