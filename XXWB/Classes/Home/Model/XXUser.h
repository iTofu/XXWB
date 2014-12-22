//
//  XXUser.h
//  XXWB
//
//  Created by 刘超 on 14/12/18.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXUser : NSObject

/** 用户id */
@property (nonatomic, copy) NSString *idstr;
/** 用户头像 */
@property (nonatomic, copy) NSString *profile_image_url;
/** 用户昵称 */
@property (nonatomic, copy) NSString *name;
/** 用户是否vip */
@property (nonatomic, assign, getter = isVip) BOOL vip;

@end
