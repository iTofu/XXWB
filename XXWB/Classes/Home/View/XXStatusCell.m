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

// 微博工具条按钮个数
#define XXToolBarBtnCount 3

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

#pragma mark - 重写setFrame:方法

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = XXStatusPadding * 0.5;
    frame.size.width -= XXStatusPadding;
    frame.origin.y += XXStatusPadding * 0.5;
    frame.size.height -= XXStatusPadding * 0.5;
    
    [super setFrame:frame];
}

#pragma mark -

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = [[UIView alloc] init];
        
        // 初始化原创微博控件
        [self setupOriginalStatus];
        
        // 初始化转发微博控件
        [self setRetweetStatus];
        
        // 初始化微博工具条
        [self setupToolBar];
    }
    return self;
}

#pragma mark - 初始化

/**
 *  初始化原创微博控件
 */
- (void)setupOriginalStatus
{
    // 0. 原创微博父控件
    UIImageView *originalView = [[UIImageView alloc] init];
    originalView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    originalView.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    // 1. 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.originalView addSubview:iconView];
    self.iconView = iconView;
    
    // 2. 昵称
    UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:XXStatusNameFont];
    
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
    timeLabel.textColor = XXColor(135, 135, 135);
    [self.originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 5. 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = [UIFont systemFontOfSize:XXStatusSourceFont];
    sourceLabel.textColor = XXColor(135, 135, 135);
    [self.originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    // 6. 正文
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont systemFontOfSize:XXStatusContentFont];
    contentLabel.textColor = XXColor(35, 35, 35);
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
    retweetView.image = [UIImage resizedImageWithName:@"timeline_retweet_background" width:0.9 height:0.5];
    retweetView.highlightedImage = [UIImage resizedImageWithName:@"timeline_retweet_background_highlighted"];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    // 1. 昵称
    UIButton *retweetNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    retweetNameBtn.titleLabel.font = [UIFont systemFontOfSize:XXStatusNameFont];
    [retweetNameBtn setTitleColor:XXColor(67, 107, 163) forState:UIControlStateNormal];
    [self.retweetView addSubview:retweetNameBtn];
    self.retweetNameBtn = retweetNameBtn;
    
    // 2. 正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = [UIFont systemFontOfSize:XXStatusContentFont];
    retweetContentLabel.textColor = XXColor(90, 90, 90);
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
- (void)setupToolBar
{
    // 微博工具条父控件
    UIImageView *statusToolBar = [[UIImageView alloc] init];
    statusToolBar.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
    statusToolBar.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
    
    // 转发 评论 表态
    NSArray *btnImageName = @[@"timeline_icon_retweet", @"timeline_icon_comment", @"timeline_icon_unlike"];
    NSArray *btnTitleName = @[@"转发", @"评论", @"赞"];
    for (int index = 0; index < XXToolBarBtnCount; index++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index; // tag
        NSString *imageName = btnImageName[index];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setTitle:btnTitleName[index] forState:UIControlStateNormal];
        [btn setTitleColor:XXColor(133, 133, 133) forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.statusToolBar addSubview:btn];
    }
    
    for (int index = 0; index < XXToolBarBtnCount - 1; index++) {
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"] highlightedImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
        lineView.tag = index + 10; // tag
        [self.statusToolBar addSubview:lineView];
    }
}

#pragma mark - 处理传递数据

- (void)setStatusFrame:(XXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 设置原创微博数据和frame
    [self setupOriginalData];
    
    // 设置转发微博数据和frame
    [self setupRetweetData];
    
    // 设置微博工具条数据和frame
    [self setupToolBarData];
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
    if (status.user.mbtype > 0) {
        self.vipView.hidden = NO;
        NSString *name = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
        self.vipView.image = [UIImage imageNamed:name];
        self.vipView.frame = statusFrame.vipViewF;
        
        [self.nameBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    } else {
        self.vipView.hidden = YES;
        
        [self.nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    // 时间
    self.timeLabel.text = status.created_at;
    CGFloat timeX = self.statusFrame.nameBtnF.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.statusFrame.nameBtnF) + XXStatusPadding * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:[UIFont systemFontOfSize:XXStatusTimeFont]];
    self.timeLabel.frame = (CGRect){timeX, timeY, timeSize};
    
    // 来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + XXStatusPadding * 0.5;
    CGFloat sourceY = self.statusFrame.timeLabelF.origin.y;
    CGSize sourceSize = [status.source sizeWithFont:[UIFont systemFontOfSize:XXStatusSourceFont]];
    self.sourceLabel.frame = (CGRect){sourceX, sourceY, sourceSize};
    
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
    
#warning 测试账号id
    if ([user.idstr isEqualToString:@"5390775469"]) {
        [self.nameBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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

/**
 *  设置微博工具条数据和frame
 */
- (void)setupToolBarData
{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    
    
    CGFloat btnY = 0;
    CGFloat btnH = self.statusToolBar.bounds.size.height;
    CGFloat btnW = self.statusToolBar.bounds.size.width / XXToolBarBtnCount;
    for (UIButton *btn in self.statusToolBar.subviews) {
        CGFloat btnX = btn.tag * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 两根线
    CGFloat lineW = 1;
    CGFloat lineH = self.statusToolBar.bounds.size.height;
    CGFloat lineY = 0;
    for (UIView *lineView in self.statusToolBar.subviews) {
        if (lineView.tag >= 10 && lineView.tag <= XXToolBarBtnCount + 9) {
            CGFloat lineX = (lineView.tag - 9) * (self.statusToolBar.bounds.size.width / XXToolBarBtnCount);
            lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
        }
    }
}

/*
 测试账号信息:
 
     user =         {
     "allow_all_act_msg" = 0;
     "allow_all_comment" = 1;
     "avatar_hd" = "http://ww3.sinaimg.cn/crop.0.0.179.179.1024/005SP8Xrgw1enbp0abi32j3050050dg1.jpg";
     "avatar_large" = "http://tp2.sinaimg.cn/5390775469/180/40073431024/1";
     "bi_followers_count" = 0;
     "block_app" = 0;
     "block_word" = 0;
     city = 8;
     class = 1;
     "created_at" = "Thu Nov 27 21:24:46 +0800 2014";
     "credit_score" = 80;
     description = "\U6b22\U8fce\U652f\U6301\U548c\U8bd5\U7528\U5c0f\U5c0f\U5fae\U535a2~";
     domain = "";
     "favourites_count" = 3;
     "follow_me" = 0;
     "followers_count" = 2;
     following = 0;
     "friends_count" = 29;
     gender = m;
     "geo_enabled" = 1;
     id = 5390775469;
     idstr = 5390775469;
     lang = "zh-cn";
     location = "\U5317\U4eac \U6d77\U6dc0\U533a";
     mbrank = 0;
     mbtype = 0;
     name = "\U5c0f\U5c0f\U68a6\U60f3\U5bb6\U54df";
     "online_status" = 1;
     "pagefriends_count" = 1;
     "profile_image_url" = "http://tp2.sinaimg.cn/5390775469/50/40073431024/1";
     "profile_url" = "u/5390775469";
     province = 11;
     ptype = 0;
     remark = "";
     "screen_name" = "\U5c0f\U5c0f\U68a6\U60f3\U5bb6\U54df";
     star = 0;
     "statuses_count" = 14;
     urank = 0;
     url = "";
     verified = 0;
     "verified_reason" = "";
     "verified_reason_url" = "";
     "verified_source" = "";
     "verified_source_url" = "";
     "verified_trade" = "";
     "verified_type" = "-1";
     weihao = "";
     }
 */

@end
