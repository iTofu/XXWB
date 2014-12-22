//
//  XXStatusFrame.h
//  XXWB
//
//  Created by 刘超 on 14/12/19.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

// 间距
#define XXStatusPadding 10
// 昵称字体
#define XXStatusNameFont 15
// 时间字体
#define XXStatusTimeFont 10
// 来源字体
#define XXStatusSourceFont XXStatusTimeFont
// 正文字体
#define XXStatusContentFont 14

@class XXStatus;

@interface XXStatusFrame : NSObject

/** 原创微博父控件 */
@property (nonatomic, assign, readonly) CGRect originalViewF;
/** 原创微博头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 原创微博昵称 */
@property (nonatomic, assign, readonly) CGRect nameBtnF;
/** 原创微博vip */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 原创微博时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 原创微博来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 原创微博正文 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
/** 原创微博配图 */
@property (nonatomic, assign, readonly) CGRect photoViewF;

/** 转发微博父控件 */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 转发微博昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameBtnF;
/** 转发微博正文 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 转发微博配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;

/** 微博工具条父控件 */
@property (nonatomic, assign, readonly) CGRect statusToolBarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) XXStatus *status;

@end
