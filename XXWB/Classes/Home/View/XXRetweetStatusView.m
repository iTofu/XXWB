//
//  XXRetweetStatusView.m
//  XXWB
//
//  Created by Leo on 14-12-31.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXRetweetStatusView.h"
#import "XXStatus.h"
#import "XXStatusFrame.h"
#import "XXUser.h"
#import "UIImageView+WebCache.h"
#import "XXPhoto.h"

@interface XXRetweetStatusView ()

/** 转发微博昵称 */
@property (nonatomic, weak) UIButton *retweetNameBtn;
/** 转发微博正文 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发微博配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

@end

@implementation XXRetweetStatusView

#pragma mark - 初始化

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" width:0.9 height:0.5];
        
        // 1. 昵称
        UIButton *retweetNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        retweetNameBtn.titleLabel.font = [UIFont systemFontOfSize:XXStatusNameFont];
        [retweetNameBtn setTitleColor:XXColor(67, 107, 163) forState:UIControlStateNormal];
        [self addSubview:retweetNameBtn];
        self.retweetNameBtn = retweetNameBtn;
        
        // 2. 正文
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = [UIFont systemFontOfSize:XXStatusContentFont];
        retweetContentLabel.textColor = XXColor(90, 90, 90);
        retweetContentLabel.numberOfLines = 0;
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        // 3. 配图
        UIImageView *retweetPhotoView = [[UIImageView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}

#pragma mark - 设置数据

- (void)setStatusFrame:(XXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    XXStatus *retweetStatus = statusFrame.status.retweeted_status;
    
    // 昵称
    NSString *name = [NSString stringWithFormat:@"@%@", retweetStatus.user.name];
    [self.retweetNameBtn setTitle:name forState:UIControlStateNormal];
    self.retweetNameBtn.frame = statusFrame.retweetNameBtnF;
    
    // 正文
    [self.retweetContentLabel setText:retweetStatus.text];
    self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
    
    // 配图
    if (retweetStatus.pic_urls.count) {
        self.retweetPhotoView.hidden = NO;
        
        [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:[retweetStatus.pic_urls[0] thumbnail_pic]]
                                 placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
    } else {
        self.retweetPhotoView.hidden = YES;
    }
}

@end
