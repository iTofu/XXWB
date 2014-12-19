//
//  XXSearBar.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXSearBar.h"

@implementation XXSearBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        UIImage *searchImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:searchImage];
        imageView.bounds = CGRectMake(0, 0, 30, searchImage.size.height);
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.font = [UIFont systemFontOfSize:14.0];
        
        NSMutableDictionary *attributed = [NSMutableDictionary dictionary];
        attributed[NSForegroundColorAttributeName] = [UIColor grayColor];
        attributed[NSFontAttributeName] = [UIFont systemFontOfSize:14.0];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attributed];
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

@end
