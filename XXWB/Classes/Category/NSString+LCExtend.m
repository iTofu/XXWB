//
//  NSString+LCExtend.m
//  XXWB
//
//  Created by 刘超 on 14/12/19.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "NSString+LCExtend.h"

@implementation NSString (LCExtend)

- (CGSize)sizeWithFontSize:(CGFloat)fontSize
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica" size:fontSize];
    CGSize size = [self sizeWithAttributes:attributes];
    return size;
}

- (CGRect)boundsWithFontSize:(CGFloat)fontSize textWidth:(CGFloat)width
{
    CGSize textSize = CGSizeMake(width, MAXFLOAT);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica" size:fontSize];
    CGRect frame = [self boundingRectWithSize:textSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributes
                                      context:nil];
    return frame;
}

@end
