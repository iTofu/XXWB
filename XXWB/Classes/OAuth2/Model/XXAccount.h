//
//  XXAccount.h
//  XXWB
//
//  Created by 刘超 on 14/12/18.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;
/**
 *  过期时间
 */
@property (nonatomic, strong) NSDate *expiresTime;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
