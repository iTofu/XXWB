//
//  XXPhotosView.h
//  XXWB
//
//  Created by Leo on 14-12-31.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXPhotosView : UIView

@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片个数返回photosView大小
 */
+ (CGSize)sizeWithPhotosCount:(int)count;

@end
