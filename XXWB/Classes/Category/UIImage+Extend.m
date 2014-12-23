//
//  UIImage+Extend.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

+ (instancetype)resizedImageWithName:(NSString *)imageName
{
    return [self resizedImageWithName:imageName width:0.5 height:0.5];
}

+ (instancetype)resizedImageWithName:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * width
                                      topCapHeight:image.size.height * height];
}

@end
