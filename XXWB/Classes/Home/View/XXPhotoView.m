//
//  XXPhotoView.m
//  XXWB
//
//  Created by Leo on 14-12-31.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXPhotoView.h"
#import "XXPhoto.h"
#import "UIImageView+WebCache.h"

@interface XXPhotoView ()

/** gif */
@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation XXPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *gif = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:gif];
        [self addSubview:gifView];
        
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(XXPhoto *)photo
{
    _photo = photo;
    
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@".gif"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic]
            placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.bounds.size.width, self.bounds.size.height);
}

@end
