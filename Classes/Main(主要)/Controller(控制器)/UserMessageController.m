//
//  UserMessageController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/8.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "UserMessageController.h"
#import "Net.h"
#import "User.h"
#import "MJExtension.h"
#import "Topic.h"
#import "Topiclist.h"
#import "TopicCell.h"
#import "UserMessageCell.h"
#import "UIImageView+WebCache.h"
#import "SeePostControler.h"

@interface UserMessageController ()<ASIHTTPRequestDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)User *user;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"TopicCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserMessageCell" bundle:nil] forCellReuseIdentifier:@"UserMessageCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    [Net sendAsynchronousWithURL:UserMessageURL(self.nameid) tag:1 delegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.user.topiclist.list.count?2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else {
        return self.user.topiclist.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UserMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserMessageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:{
                cell.typeLabel.text = @"来自";
                cell.messageLabel.text = self.user.areaname;
                break;}
            case 1:{
                cell.typeLabel.text = @"注册时间";
                cell.messageLabel.text = self.user.regtime;
                break;}
            case 2:{
                cell.typeLabel.text = @"关注";
                cell.messageLabel.text = self.user.mycarname;
                break;}
            case 3:{
                cell.typeLabel.text = @"勋章";
                cell.messageLabel.text = [NSString stringWithFormat:@"%zi", self.user.medalslist.count];
                break;}
            default:
                break;
        }
        return cell;
    }else
    {
        TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell" forIndexPath:indexPath];
        cell.topic = self.user.topiclist.list[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 64;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 50, 50)];
        if (self.user.minpic.length) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.user.minpic]];
        }
        else {
            imageView.image = [UIImage imageNamed:@"userpic_default_big"];
        }
        
        //判断是否为VIP
        if (self.user.iscarowner) {
            UIImageView *vip = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 20, 20)];
            vip.image = [UIImage imageNamed:@"user_icon_vip"];
            [imageView addSubview:vip];
        }
        
        [headerView addSubview:imageView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(66, 8, kScreenW-50-16-8, 30)];
        nameLabel.text = self.user.name;
        [headerView addSubview:nameLabel];
        
        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.x, nameLabel.y+nameLabel.height, 200, 20)];
        subLabel.font = [UIFont systemFontOfSize:12];
        subLabel.text = [NSString stringWithFormat:@"积分:%zi", self.user.integral];
        [headerView addSubview:subLabel];
        return headerView;
    }
    else
    {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return [NSString stringWithFormat:@"主题列表(共%zi贴)", self.user.topiclist.rowcount];
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return [NSString stringWithFormat:@"共%zi条结果", self.user.topiclist.rowcount];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    SeePostControler *seePostCtl = [[SeePostControler alloc] init];
    seePostCtl.topicid = [self.user.topiclist.list[indexPath.row] topicid];
    [self.navigationController pushViewController:seePostCtl animated:YES];
    
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = request.responseData;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"result"];
    User *user = [User objectWithKeyValues:dict];
    self.user = user;
    [self.tableView reloadData];
}

@end
