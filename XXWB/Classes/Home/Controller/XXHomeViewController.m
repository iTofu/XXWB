//
//  XXHomeViewController.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXHomeViewController.h"
#import "UIBarButtonItem+Extend.h"
#import "XXTitleButton.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "XXAccountTool.h"
#import "XXAccount.h"
#import "XXStatus.h"
#import "XXUser.h"
#import "NSString+LCExtend.h"
#import "UIImageView+WebCache.h"
#import "XXStatusCell.h"
#import "XXStatusFrame.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface XXHomeViewController ()

/**
 *  标题按钮状态
 */
@property (nonatomic, assign, getter = isTitleOpen) BOOL titleOpen;
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation XXHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置刷新
    [self setupRefresh];
    
    // 设置NavigationBar
    [self setupNavigationBar];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = XXColor(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, XXStatusPadding * 0.5, 0);
}

/**
 *  设置刷新
 */
- (void)setupRefresh
{
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    
    // 上拉加载
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

/**
 *  下拉刷新
 */
- (void)headerRereshing
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Net
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *pars = [NSMutableDictionary dictionary];
    pars[@"access_token"] = [XXAccountTool account].access_token; // 用户token
    pars[@"count"] = @20; // 每页微博个数
    if (self.statusFrames.count) {
        XXStatus *status = [self.statusFrames[0] status];
        pars[@"since_id"] = status.idstr; // 加载ID比since_id大的微博
    }
    
    [manager GET:XXHomeStatus
      parameters:pars
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [self.tableView headerEndRefreshing];
             
             NSArray *statusArray = [XXStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
             
             NSMutableArray *statusFrameArray = [NSMutableArray array];
             for (XXStatus *status in statusArray) {
                 XXStatusFrame *statusFrame = [[XXStatusFrame alloc] init];
                 statusFrame.status = status;
                 [statusFrameArray addObject:statusFrame];
             }
             
             NSMutableArray *tempArray = [NSMutableArray array];
             [tempArray addObjectsFromArray:statusFrameArray];
             [tempArray addObjectsFromArray:self.statusFrames];
             self.statusFrames = tempArray;
             
             [self.tableView reloadData];
             if (statusFrameArray.count) {
                 [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
             }
             
             // 显示新微博数量
             [self showNewStatusCount:(int)statusFrameArray.count];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [self.tableView headerEndRefreshing];
             
             XXLog(@"error: %@", error.localizedDescription);
         }];
}

/**
 *  上拉加载
 */
- (void)footerRereshing
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Net
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *pars = [NSMutableDictionary dictionary];
    pars[@"access_token"] = [XXAccountTool account].access_token; // 用户token
    pars[@"count"] = @20; // 每页微博个数
    if (self.statusFrames.count) {
        XXStatus *status = [[self.statusFrames lastObject] status];
        long long maxId = [status.idstr longLongValue] - 1;
        pars[@"max_id"] = @(maxId);
    }
    
    [manager GET:XXHomeStatus
      parameters:pars
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [self.tableView footerEndRefreshing];
             
             NSArray *statusArray = [XXStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
             
             NSMutableArray *statusFrameArray = [NSMutableArray array];
             for (XXStatus *status in statusArray) {
                 XXStatusFrame *statusFrame = [[XXStatusFrame alloc] init];
                 statusFrame.status = status;
                 [statusFrameArray addObject:statusFrame];
             }
             
             [self.statusFrames addObjectsFromArray:statusFrameArray];
             
             [self.tableView reloadData];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [self.tableView footerEndRefreshing];
             
             XXLog(@"error: %@", error.localizedDescription);
         }];
}

// 显示新微博数量
- (void)showNewStatusCount:(int)count
{
    UIButton *btn = [[UIButton alloc] init];
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    NSString *title = nil;
    if (count) {
        title = [NSString stringWithFormat:@"%d条新微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新微博" forState:UIControlStateNormal];
    }
    
    CGFloat btnX = 0;
    CGFloat btnH = 30;
    CGFloat btnW = self.view.bounds.size.width;
    CGFloat btnY = 64 - btnH;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7
                              delay:1
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             btn.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             [btn removeFromSuperview];
                         }];
    }];
}

// 设置NavigationBar
- (void)setupNavigationBar
{
    // 设置左右item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) imageName:@"navigationbar_friendsearch" highlightedImageName:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) imageName:@"navigationbar_pop" highlightedImageName:@"navigationbar_pop_highlighted"];
    
    // 设置中间button
    XXTitleButton *titleButton = [XXTitleButton titleButton];
    NSString *title = @"小小微博";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    CGSize titleSize = [title sizeWithFontSize:XXTitleButtonSize];
    titleButton.bounds = CGRectMake(0, 0, titleSize.width + titleButton.imageView.bounds.size.width + 5, 30);
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

// 监听中间标题按钮的点击
- (void)titleButtonClick:(XXTitleButton *)button
{
    self.titleOpen = !self.isTitleOpen;
    
    UIImage *image = [UIImage imageNamed:self.isTitleOpen ? @"navigationbar_arrow_up" : @"navigationbar_arrow_down"];
    [button setImage:image forState:UIControlStateNormal];
}

// 查找好友
- (void)friendSearch
{
    XXLog(@"小小微博--friendSearch");
}

// 扫一扫
- (void)pop
{
    XXLog(@"小小微博--pop");
    
    [self.refreshControl beginRefreshing];
    [self headerRereshing];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXStatusCell *cell = [XXStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.statusFrames[indexPath.row] cellHeight];
}

@end
