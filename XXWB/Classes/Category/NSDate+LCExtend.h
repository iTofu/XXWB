//
//  NSDate+LCExtend.h
//  XXWB
//
//  Created by 刘超 on 14/12/23.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LCExtend)

/**
 *  是否是今天
 */
- (BOOL)isToday;
/**
 *  是否是昨天
 */
- (BOOL)isYesterday;
/**
 *  是否是今年
 */
- (BOOL)isThisYear;

/**
 *  获取与当前时间的差距
 */
- (NSDateComponents *)deltaToNow;

@end
