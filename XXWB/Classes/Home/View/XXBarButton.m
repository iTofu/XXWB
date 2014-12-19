//
//  XXBarButton.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXBarButton.h"

@implementation XXBarButton

+ (instancetype)barButtonWithImageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    return [[self alloc] initWithImageName:imageName selectedImage:selectedImageName];
}

- (instancetype)initWithImageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    if (self = [super init]) {
        self.imageView.image = [UIImage imageNamed:@"draft"];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end
