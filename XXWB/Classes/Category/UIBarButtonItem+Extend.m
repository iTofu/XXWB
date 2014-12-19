//
//  UIBarButtonItem+Extend.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "UIBarButtonItem+Extend.h"

@implementation UIBarButtonItem (Extend)

+ (instancetype)itemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName
{
    UIButton *item = [[UIButton alloc] init];
    UIImage *bgImage = [UIImage imageNamed:imageName];
    UIImage *highlightedBgImage = [UIImage imageNamed:highlightedImageName];
    [item setBackgroundImage:bgImage forState:UIControlStateNormal];
    [item setBackgroundImage:highlightedBgImage forState:UIControlStateHighlighted];
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    item.bounds = (CGRect){CGPointZero, bgImage.size};
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

@end
