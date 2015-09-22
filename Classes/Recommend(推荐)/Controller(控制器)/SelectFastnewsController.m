//
//  SelectFastnewsController.m
//  Autohome
//
//  Created by aoyolo1 on 15/6/7.
//  Copyright (c) 2015年 游兵. All rights reserved.
//

#import "SelectFastnewsController.h"
#import "Net.h"
#import "News.h"
#import "FastNewsForSelect.h"
#import "MJExtension.h"
#import "Message.h"
#import "MessageCell.h"
#import "Comment.h"
#import "CommentCell.h"
#import "PublishCommentCell.h"
#import "Fastnews.h"
#import "UIImageView+WebCache.h"

@interface SelectFastnewsController ()<UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FastNewsForSelect *fastNewsForSelect;

@property (strong, nonatomic) UIView *headerView;
@end

@implementation SelectFastnewsController
- (IBAction)backClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setNews:(News *)news
{
    _news = news;
    self.id = news.id;
}

- (void)setFastnews:(Fastnews *)fastnews
{
    _fastnews = fastnews;
    self.id = fastnews.id;
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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PublishCommentCell" bundle:nil] forCellReuseIdentifier:@"PublishCommentCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [Net sendAsynchronousWithURL:FastNewsSelectURL(self.id) tag:1 delegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fastNewsForSelect.messagelist.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 + [[self.fastNewsForSelect.messagelist[section] commentlist] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *message = self.fastNewsForSelect.messagelist[indexPath.section];
    if (indexPath.row == 0) {
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.message = message;
        return cell;
    }
    if (indexPath.row == message.commentlist.count+1) {
        PublishCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublishCommentCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.comment = message.commentlist[indexPath.row-1];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = request.responseData;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"result"];
    FastNewsForSelect *fastNewsSelect = [FastNewsForSelect objectWithKeyValues:dict];
    self.fastNewsForSelect = fastNewsSelect;
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*768/1024-50)];
    headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headerView;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:fastNewsSelect.newsdata.img]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [headerView addSubview:imageView];
    
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*768/1024-50)];
    [headerImage sd_setImageWithURL:[NSURL URLWithString:fastNewsSelect.newsdata.img]];
    headerImage.contentMode = UIViewContentModeScaleAspectFill;
    headerImage.clipsToBounds = YES;
    self.headerView = headerImage;
//    [self.view addSubview:self.headerView];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
    
    [self.tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@", request.error.localizedDescription);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //判断是否登录了
//    if (登录) {
//        return YES;
//    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
    
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    static CGFloat offsetY;
    static CGFloat offsetCountLabelY;
    if (y<0) {
        [self.view addSubview:self.headerView];
        self.headerView.height += offsetY-y;
        offsetY = y;
    } else {
        self.headerView.height = kScreenW*768/1024-50;
        [self.headerView removeFromSuperview];
    }
    offsetCountLabelY = y;
}

@end
