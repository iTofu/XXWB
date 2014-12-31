//
//  UIButton+LCExtend.h
//  XXWB
//
//  Created by Leo on 14-12-31.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LCExtend)

/**
 *  返回一个可充当UIBarButtonItem的按钮
 */
+ (instancetype)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (instancetype)barButtonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action;

@end
