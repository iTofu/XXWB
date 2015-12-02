//
//  XXStatusToolBar.m
//  XXWB
//
//  Created by Leo on 14-12-31.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXStatusToolBar.h"
#import "XXStatus.h"

@interface XXStatusToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, weak) UIButton *retweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *unlikeBtn;

@end

@implementation XXStatusToolBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [[NSMutableArray alloc] init];
    }
    return _btns;
}

- (NSMutableArray *)lines
{
    if (_lines == nil) {
        _lines = [[NSMutableArray alloc] init];
    }
    return _lines;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        // 初始化工具条
        [self setupStatusToolBar];
        
        // 添加三个按钮
        [self setupBtns];
        
        // 添加两根线条
        [self setupLines];
    }
    return self;
}

/**
 *  初始化工具条
 */
- (void)setupStatusToolBar
{
    self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
    self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
}

/**
 *  添加三个按钮
 */
- (void)setupBtns
{
    self.retweetBtn = [self setupBtnWithTitle:@"转发" imageName:@"timeline_icon_retweet"];
    self.commentBtn = [self setupBtnWithTitle:@"评论" imageName:@"timeline_icon_comment"];
    self.unlikeBtn = [self setupBtnWithTitle:@"赞" imageName:@"timeline_icon_unlike"];
}

/**
 *  添加按钮
 */
- (UIButton *)setupBtnWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:XXColor(133, 133, 133) forState:UIControlStateNormal];
    [btn setImage:[UIImage resizedImageWithName:imageName] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

/**
 *  添加两根线条
 */
- (void)setupLines
{
    [self addLine];
    [self addLine];
}

/**
 *  添加线条
 */
- (void)addLine
{
    UIImageView *line = [[UIImageView alloc] init];
    line.image = [UIImage resizedImageWithName:@"timeline_card_bottom_line"];
    line.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_line_highlighted"];
    [self addSubview:line];
    
    [self.lines addObject:line];
}

#pragma mark - 设置frame

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    CGFloat btnY = 0;
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnW = self.bounds.size.width / self.btns.count;
    for (int index = 0; index < self.btns.count; index++) {
        CGFloat btnX = index * btnW;
        UIButton *btn = self.btns[index];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 设置线条的frame
    CGFloat lineY = 0;
    CGFloat lineW = 2;
    CGFloat lineH = self.bounds.size.height;
    for (int index = 0; index < self.lines.count; index++) {
        CGFloat lineX = (index + 1) * btnW;
        UIImageView *line = self.lines[index];
        line.frame = CGRectMake(lineX, lineY, lineW, lineH);
    }
}

#pragma mark - 设置数据

- (void)setStatus:(XXStatus *)status
{
    _status = status;
    
    [self setupBtn:self.retweetBtn count:status.reposts_count];
    [self setupBtn:self.commentBtn count:status.comments_count];
    [self setupBtn:self.unlikeBtn count:status.attitudes_count];
}

/**
 *  设置转发数 评论数 点赞数
 *
 *  @param btn   需要设置的按钮
 *  @param count 显示的个数
 */
- (void)setupBtn:(UIButton *)btn count:(int)count
{
    NSString *title = nil;
    if (count < 10000) {
        title = [NSString stringWithFormat:@"%d", count];
    } else {
        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
