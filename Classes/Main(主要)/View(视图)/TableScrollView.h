//
//  TableScrollView.h
//  Autohome
//
//  Created by aoyolo1 on 15/6/3.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableScrollView : UIScrollView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *pageDataModels;

@property (nonatomic, assign)NSInteger tableViewCount;



@end
