//
//  PageTableView.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "PageTableView.h"

@implementation PageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.page = 1;
    }
    return self;
}


+ (instancetype)pageTableView:(CGRect)rect style:(UITableViewStyle)style tag:(NSInteger)tag delegate:(id)delegate dataSource:(id)dataSource cellNib:(NSString *)cellNib rowHeight:(CGFloat)rowHeight
{
    PageTableView *tableView = nil;
    if (tag == 2||tag == 3) {
        tableView = [[PageTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    } else {
        tableView = [[PageTableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    }
    tableView.tag = tag;
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    [tableView registerNib:[UINib nibWithNibName:cellNib bundle:nil] forCellReuseIdentifier:cellNib];
    [tableView registerNib:[UINib nibWithNibName:@"FastnewsTwoCell" bundle:nil] forCellReuseIdentifier:@"FastnewsTwoCell"];
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    tableView.estimatedRowHeight = rowHeight;
    return tableView;
}

+ (instancetype)pageTableView:(CGRect)rect delegate:(id)delegate tag:(NSInteger)tag
{
    PageTableView *tableView = [[PageTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    tableView.tag = tag;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    return tableView;
}

+ (instancetype)pageTableView:(CGRect)rect delegate:(id)delegate tag:(NSInteger)tag registerNibNames:(NSArray *)registerNibNames style:(UITableViewStyle)style
{
    PageTableView *tableView = [[PageTableView alloc] initWithFrame:rect style:style];
    for (NSString *registerNibName in registerNibNames) {
        [tableView registerNib:[UINib nibWithNibName:registerNibName bundle:nil] forCellReuseIdentifier:registerNibName];
    }
//    tableView.bounces = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    tableView.tag = tag;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    return tableView;
}

@end
