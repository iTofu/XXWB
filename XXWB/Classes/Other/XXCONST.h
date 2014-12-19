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

#define XXHomeStatus @"https://api.weibo.com/2/statuses/home_timeline.json"

// 多行尺寸的计算
// CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(10.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:XXBadgeButtonTitleSize]} context:nil];

#endif
