//
//  XXHomeViewController.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXHomeViewController.h"
#import "XXBarButton.h"
#import "UIBarButtonItem+Extend.h"
#import "XXTitleButton.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "XXAccountTool.h"
#import "XXAccount.h"
#import "XXStatus.h"
#import "XXUser.h"
//#import "UIImageView+WebCache.h"

@interface XXHomeViewController ()

/**
 *  标题按钮状态
 */
@property (nonatomic, assign, getter = isTitleOpen) BOOL titleOpen;

@property (nonatomic, strong) NSArray *statuses;

@end

@implementation XXHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *pars = [NSMutableDictionary dictionary];
    pars[@"access_token"] = [XXAccountTool account].access_token;
    
    [manager GET:XXHomeStatus
      parameters:pars
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             self.statuses = [XXStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
             [self.tableView reloadData];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue" size:XXTitleButtonSize];
    CGSize titleSize = [title sizeWithAttributes:attributes];
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
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    XXStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    cell.detailTextLabel.text = status.user.name;
    //[cell.imageView setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted@3x"]];
    
    return cell;
}
@end
