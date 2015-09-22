//
//  TableScrollView.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "TableScrollView.h"
#import "PageDataModel.h"
#import "PageTableView.h"

@implementation TableScrollView

- (void)setPageDataModels:(NSArray *)pageDataModels
{
    _pageDataModels = pageDataModels;
    for (int i = 0; i < pageDataModels.count; i++)
    {
        PageTableView *tableView = [[PageTableView alloc] initWithFrame:CGRectMake(i*self.width, 0, self.width, self.height) style:UITableViewStylePlain];
        tableView.tag = i+100;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
    }
}

- (void)setTableViewCount:(NSInteger)tableViewCount
{
    _tableViewCount = tableViewCount;
    for (int i = 0; i < tableViewCount; i++)
    {
        PageTableView *tableView = [[PageTableView alloc] initWithFrame:CGRectMake(i*self.width, 0, self.width, self.height) style:UITableViewStylePlain];
        tableView.tag = i+1;
        tableView.delegate = self.delegate;
        tableView.dataSource = self.delegate;
        
        
        
        [self addSubview:tableView];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pageDataModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"111";
    return cell;
}

@end
