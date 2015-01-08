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
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

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
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

/**
 *  监听图片点击
 */
- (void)photoTap:(UITapGestureRecognizer *)tap
{
    int count = (int)self.photos.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        // 图片路径
        // 替换为中等尺寸图片
        NSString *url = [[self.photos[i] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        photo.url = [NSURL URLWithString:url];
        
        // 来源于哪个UIImageView
        photo.srcImageView = self.subviews[i];
        
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
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
    // 一行最多3列
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
}

@end
