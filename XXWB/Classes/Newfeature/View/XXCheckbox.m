//
//  XXCheckbox.m
//  XXWB
//
//  Created by 刘超 on 14/12/16.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXCheckbox.h"

#define XXCheckboxTitleSize 13.0

@implementation XXCheckbox

+ (instancetype)checkboxWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        UIImage *image = [UIImage imageNamed:@"new_feature_share_false"];
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:XXColor(92, 98, 103) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:XXCheckboxTitleSize];
        
        CGFloat padding = 5;
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue" size:XXCheckboxTitleSize];
        CGSize titleSize = [title sizeWithAttributes:attributes];
        CGFloat checkW = titleSize.width + image.size.width + padding * 2;
        self.bounds = (CGRect){CGPointZero, checkW, image.size.height};
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, padding);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
