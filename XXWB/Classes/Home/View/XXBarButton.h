//
//  XXBarButton.h
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXBarButton : UIButton

/**
 *  返回一个带图片的buttonItem
 */
+ (instancetype)barButtonWithImageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName;
- (instancetype)initWithImageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName;

@end
