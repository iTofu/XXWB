//
//  UIImage+Extend.h
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

/**
 *  返回一张可拉伸的图片
 */
+ (instancetype)resizedImageWithName:(NSString *)imageName;
+ (instancetype)resizedImageWithName:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height;

@end
