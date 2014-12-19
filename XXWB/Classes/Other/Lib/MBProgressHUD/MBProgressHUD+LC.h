//
//  MBProgressHUD+LC.h
//
//  Created by Leo on 14-12-03.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LC)

/** 提示成功并消失 */
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/** 提示错误并消失 */
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

/** 显示加载提示并不主动消失 */
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

/** 隐藏加载提示 */
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
