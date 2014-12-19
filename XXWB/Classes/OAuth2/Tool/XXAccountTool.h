//
//  XXAccountTool.h
//  XXWB
//
//  Created by 刘超 on 14/12/18.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XXAccount;

@interface XXAccountTool : NSObject

/**
 *  存储账号
 */
+ (void)saveAccount:(XXAccount *)account;
/**
 *  获取账号
 */
+ (XXAccount *)account;

@end
