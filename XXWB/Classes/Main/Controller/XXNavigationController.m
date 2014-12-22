//
//  XXNavigationController.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXNavigationController.h"

@interface XXNavigationController ()

@end

@implementation XXNavigationController

+ (void)initialize
{
    // 设置BarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = XXColor(239, 116, 8);
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
