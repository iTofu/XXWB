//
//  XXWeiboTool.m
//  XXWB
//
//  Created by 刘超 on 14/12/18.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXWeiboTool.h"
#import "XXNewfeatureViewController.h"
#import "XXTabBarController.h"

@implementation XXWeiboTool

+ (void)chooseRootViewController
{
    NSString *key = @"CFBundleShortVersionString";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 取出沙盒中版本号
    NSString *lastVersion = [defaults stringForKey:key];
    // 获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[XXTabBarController alloc] init];
    } else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[XXNewfeatureViewController alloc] init];
        
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}

@end
