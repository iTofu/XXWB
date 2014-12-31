//
//  XXPhotosView.m
//  XXWB
//
//  Created by Leo on 14-12-31.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXPhotosView.h"
#import "XXPhotoView.h"
#import "XXPhoto.h"

#define XXPhotoW 70
#define XXPhotoH 70
#define XXPhotoMargin 10

@implementation XXPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化9个子控件
        for (int index = 0; index < 9; index++) {
            XXPhotoView *photoView = [[XXPhotoView alloc] init];
            photoView.tag = index; // tag
            photoView.userInteractionEnabled = YES;
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for (int index = 0; index < self.subviews.count; index++) {
        XXPhotoView *photoView = self.subviews[index];
        
        if (index < photos.count) {
            photoView.hidden = NO;
            
            // 传递模型
            photoView.photo = photos[index];
            
            // 设置frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = index % maxColumns;
            int row = index / maxColumns;
            CGFloat photoX = col * (XXPhotoW + XXPhotoMargin);
            CGFloat photoY = row * (XXPhotoH + XXPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, XXPhotoW, XXPhotoH);
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else {
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)sizeWithPhotosCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    // 总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * XXPhotoH + (rows - 1) * XXPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * XXPhotoW + (cols - 1) * XXPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    /**
     一共60条数据 == count
     一页10条 == size
     总页数 == pages
     pages = (count + size - 1)/size;
     */
}

@end
