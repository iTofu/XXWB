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

@interface XXHomeViewController ()

/**
 *  标题按钮状态
 */
@property (nonatomic, assign, getter = isTitleOpen) BOOL titleOpen;

@property (nonatomic, strong) NSArray *statusFrames;

@end

@implementation XXHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = XXColor(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, XXStatusPadding * 0.5, 0);
    
    // 设置tabBarItem
    [self setupTabBarItem];
    
    // 加载数据源
    [self setupStatuses];
}

/**
 *  加载数据源
 */
- (void)setupStatuses
{
    // HUD
    [SVProgressHUD showWithStatus:@"正在刷新" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:XXColor(246, 246, 246)];
    
    // Net
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *pars = [NSMutableDictionary dictionary];
    pars[@"access_token"] = [XXAccountTool account].access_token; // 用户token
    pars[@"count"] = @20; // 每页微博个数
    
    [manager GET:XXHomeStatus
      parameters:pars
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [SVProgressHUD showSuccessWithStatus:@"刷新成功"];
             
             NSArray *statusArray = [XXStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
             
             NSMutableArray *statusFrameArray = [NSMutableArray array];
             for (XXStatus *status in statusArray) {
                 XXStatusFrame *statusFrame = [[XXStatusFrame alloc] init];
                 statusFrame.status = status;
                 [statusFrameArray addObject:statusFrame];
             }
             self.statusFrames = statusFrameArray;
             
             [self.tableView reloadData];
             [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
             
             XXLog(@"error: %@", error.localizedDescription);
    }];
}

// 设置tabBarItem
- (void)setupTabBarItem
{
    // 设置左右item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) imageName:@"navigationbar_friendsearch" highlightedImageName:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) imageName:@"navigationbar_pop" highlightedImageName:@"navigationbar_pop_highlighted"];
    
    // 设置中间button
    XXTitleButton *titleButton = [XXTitleButton titleButton];
    NSString *title = @"小小梦想家哟";
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
    
    [self setupStatuses];
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
