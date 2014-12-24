//
//  XXCONST.h
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#ifndef XXWB_XXCONST_h
#define XXWB_XXCONST_h

// 系统版本
#define iOS7 ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)

// 自定义打印
#define XXLog(...) NSLog(__VA_ARGS__)

// 获取RGB颜色
#define XXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 首页微博接口
#define XXHomeStatus @"https://api.weibo.com/2/statuses/home_timeline.json"

// 发送微博接口
#define XXUpdateStatus @"https://api.weibo.com/2/statuses/update.json"

// OAuth2认证相关
#define XXOAuthAuthorizeURL @"https://api.weibo.com/oauth2/authorize?client_id=3041370356&redirect_uri=http://www.baidu.com"
#define XXOAuthAccessTokenURL @"https://api.weibo.com/oauth2/access_token"

#endif
