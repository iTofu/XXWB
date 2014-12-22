//
//  XXStatusCell.m
//  XXWB
//
//  Created by 刘超 on 14/12/19.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXStatusCell.h"
#import "XXStatus.h"
#import "XXStatusFrame.h"
#import "XXUser.h"
#import "UIImageView+WebCache.h"

@interface XXStatusCell ()

/** 原创微博父控件 */
@property (nonatomic, weak) UIImageView *originalView;
/** 原创微博头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 原创微博昵称 */
@property (nonatomic, weak) UIButton *nameBtn;
/** 原创微博vip */
@property (nonatomic, weak) UIImageView *vipView;
/** 原创微博时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 原创微博来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 原创微博正文 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 原创微博配图 */
@property (nonatomic, weak) UIImageView *photoView;

/** 转发微博父控件 */
@property (nonatomic, weak) UIImageView *retweetView;
/** 转发微博昵称 */
@property (nonatomic, weak) UIButton *retweetNameBtn;
/** 转发微博正文 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发微博配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/** 微博工具条父控件 */
@property (nonatomic, weak) UIImageView *statusToolBar;

@end

@implementation XXStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    XXStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XXStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化原创微博控件
        [self setupOriginalStatus];
        
        // 初始化转发微博控件
        [self setRetweetStatus];
        
        // 初始化微博工具条
        [self setupStautsToolBar];
    }
    return self;
}

/**
 *  初始化原创微博控件
 */
- (void)setupOriginalStatus
{
    // 0. 原创微博父控件
    UIImageView *originalView = [[UIImageView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    // 1. 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.originalView addSubview:iconView];
    self.iconView = iconView;
    
    // 2. 昵称
    UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:XXStatusNameFont];
    [nameBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.originalView addSubview:nameBtn];
    self.nameBtn = nameBtn;
    
    // 3. 会员图标
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [self.originalView addSubview:vipView];
    self.vipView = vipView;
    
    // 4. 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:XXStatusTimeFont];
    [self.originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 5. 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = [UIFont systemFontOfSize:XXStatusSourceFont];
    [self.originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    // 6. 正文
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont systemFontOfSize:XXStatusContentFont];
    contentLabel.numberOfLines = 0;
    [self.originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    // 7. 配图
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.originalView addSubview:photoView];
    self.photoView = photoView;
}

/**
 *  初始化转发微博控件
 */
- (void)setRetweetStatus
{
    // 0. 转发微博父控件
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    // 1. 昵称
    UIButton *retweetNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    retweetNameBtn.titleLabel.font = [UIFont systemFontOfSize:XXStatusNameFont];
    [retweetNameBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.retweetView addSubview:retweetNameBtn];
    self.retweetNameBtn = retweetNameBtn;
    
    // 2. 正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = [UIFont systemFontOfSize:XXStatusContentFont];
    retweetContentLabel.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    // 3. 配图
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 *  初始化微博工具条
 */
- (void)setupStautsToolBar
{
    // 0. 微博工具条父控件
    UIImageView *statusToolBar = [[UIImageView alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
    
    // 1. 转发
    
    // 2. 评论
    
    // 3. 表态
}

- (void)setStatusFrame:(XXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 设置原创微博数据和frame
    [self setupOriginalData];
    
    // 设置转发微博数据和frame
    [self setupRetweetData];
}

/**
 *  设置原创微博数据和frame
 */
- (void)setupOriginalData
{
    XXStatusFrame *statusFrame = self.statusFrame;
    XXStatus *status = statusFrame.status;
    XXUser *user = status.user;
    
    // 传递数据和布局
    self.originalView.frame = statusFrame.originalViewF;
    
    // 头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]
                     placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = statusFrame.iconViewF;
    
    // 昵称
    [self.nameBtn setTitle:status.user.name forState:UIControlStateNormal];
    self.nameBtn.frame = statusFrame.nameBtnF;
    
    // vip
    if (status.user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
        self.vipView.frame = statusFrame.vipViewF;
    } else {
        self.vipView.hidden = YES;
    }
    
    // 时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    // 来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    // 正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    // 配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic]
                          placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.frame = statusFrame.photoViewF;
    } else {
        self.photoView.hidden = YES;
    }
}

/**
 *  设置转发微博数据和frame
 */
- (void)setupRetweetData
{
    XXStatusFrame *statusFrame = self.statusFrame;
    XXStatus *status = statusFrame.status;
    
    // 转发微博
    if (status.retweeted_status) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        // 昵称
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        [self.retweetNameBtn setTitle:name forState:UIControlStateNormal];
        self.retweetNameBtn.frame = statusFrame.retweetNameBtnF;
        
        // 正文
        [self.retweetContentLabel setText:status.retweeted_status.text];
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        // 配图
        [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:status.retweeted_status.thumbnail_pic]
                                 placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
        
    } else {
        self.retweetView.hidden = YES;
    }
}

@end
