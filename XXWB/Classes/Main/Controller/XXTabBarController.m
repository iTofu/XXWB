//
//  XXTabBarController.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXTabBarController.h"
#import "XXHomeViewController.h"
#import "XXMessageViewController.h"
#import "XXDiscoverViewController.h"
#import "XXMeViewController.h"
#import "XXTabBarView.h"
#import "XXNavigationController.h"

@interface XXTabBarController () <XXTabBarViewDelegate>

@property (nonatomic, strong) XXTabBarView *tabBarView;
@property (nonatomic, strong) UIViewController *vc;
@end

@implementation XXTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    // 自定义tabBarView
    [self setupTabBarView];
    
    // 初始化所有子控制器
    [self setupAllChildViewControllers];
}

/**
 *  自定义tabBarView
 */
- (void)setupTabBarView
{
    XXTabBarView *tabBarView = [[XXTabBarView alloc] init];
    tabBarView.frame = self.tabBar.bounds;
    tabBarView.delegate = self;
    [self.tabBar addSubview:tabBarView];
    self.tabBarView = tabBarView;
}

#pragma mark - XXTabBarViewDelegate method

- (void)tabBarView:(XXTabBarView *)tabBarView didSelectedButtonFrom:(int)from to:(int)to
{
    // 切换控制器
    self.selectedIndex = to;
}

#pragma mark -

/**
 *  删除自带按钮
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化所有子控制器
 */
- (void)setupAllChildViewControllers
{
    XXHomeViewController *home = [[XXHomeViewController alloc] init];
    home.tabBarItem.badgeValue = @"2";
    [self setupChildViewController:home title:@"首页"
                         imageName:@"tabbar_home"
                 selectedImageName:@"tabbar_home_selected"];
    
    XXMessageViewController *message = [[XXMessageViewController alloc] init];
    message.tabBarItem.badgeValue = @"16";
    [self setupChildViewController:message title:@"消息"
                         imageName:@"tabbar_message_center"
                 selectedImageName:@"tabbar_message_center_selected"];
    
    XXDiscoverViewController *discover = [[XXDiscoverViewController alloc] init];
    discover.tabBarItem.badgeValue = @"new";
    self.vc = discover;
    [self setupChildViewController:discover title:@"发现"
                         imageName:@"tabbar_discover"
                 selectedImageName:@"tabbar_discover_selected"];
    
    XXMeViewController *me = [[XXMeViewController alloc] init];
    [self setupChildViewController:me title:@"我"
                         imageName:@"tabbar_profile"
                 selectedImageName:@"tabbar_profile_selected"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

/**
 *  初始化一个子控制器
 *
 *  @param VC                子控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */
- (void)setupChildViewController:(UIViewController *)VC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 给tabBarItem设置数据
    VC.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:imageName];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 初始化导航控制器
    XXNavigationController *nav = [[XXNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    
    // 添加tabBarView内部按钮
    [self.tabBarView addTabBarButtonWithItem:VC.tabBarItem];
}

@end
