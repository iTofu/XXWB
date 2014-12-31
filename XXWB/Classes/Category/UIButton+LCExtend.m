//
//  UIButton+LCExtend.m
//  XXWB
//
//  Created by Leo on 14-12-31.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "UIButton+LCExtend.h"

@implementation UIButton (LCExtend)

+ (instancetype)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [self barButtonWithTitle:title normalColor:[UIColor orangeColor] disabledColor:[UIColor grayColor] fontSize:15.0 target:target action:action];
}

+ (instancetype)barButtonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:disabledColor forState:UIControlStateDisabled];
    CGSize rightSize = [title sizeWithFont:[UIFont systemFontOfSize:15.0]];
    btn.frame = CGRectMake(0, 0, rightSize.width, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}

@end
