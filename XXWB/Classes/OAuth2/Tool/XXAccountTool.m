//
//  XXAccountTool.m
//  XXWB
//
//  Created by 刘超 on 14/12/18.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXAccountTool.h"
#import "XXAccount.h"

#define XXAcountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation XXAccountTool

+ (void)saveAccount:(XXAccount *)account
{
    // 计算过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:XXAcountFile];
}

+ (XXAccount *)account
{
    XXAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:XXAcountFile];
    
    // 判断是否过期
    if ([[NSDate date] compare:account.expiresTime] == NSOrderedAscending) { // 没过期
        return account;
    } else {
        return nil;
    }
}

@end
