//
//  NSString+LCExtend.h
//  XXWB
//
//  Created by 刘超 on 14/12/19.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LCExtend)

/**
 *  返回单行字符串对应的文本控件size(默认字体为'HelveticaNeue', 可进入'NSString+LCExtend.m'中修改)
 *
 *  @param fontSize 字体大小
 */
- (CGSize)sizeWithFontSize:(CGFloat)fontSize;

/**
 *  返回多行字符串对应的文本控件frame(默认字体为'HelveticaNeue', 可进入'NSString+LCExtend.m'中修改)
 *
 *  @param fontSize 字体大小
 *  @param width    文本控件的最大宽度
 */
- (CGRect)boundsWithFontSize:(CGFloat)fontSize textWidth:(CGFloat)width;

@end
