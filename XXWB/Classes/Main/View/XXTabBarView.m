//
//  XXTabBarView.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXTabBarView.h"
#import "XXTabBarButton.h"

@interface XXTabBarView ()

@property (nonatomic, strong) XXTabBarButton *selectedButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@end

@implementation XXTabBarView

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [[NSMutableArray alloc] init];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加加号按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        button.bounds = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
        [self addSubview:button];
        self.addButton = button;
    }
    return self;
}

/**
 *  添加内部按钮
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    XXTabBarButton *button = [XXTabBarButton buttonWithType:UIButtonTypeCustom];
    
    // 设置数据
    button.item = item;
    
    // 添加点击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:button];
    [self.tabBarButtons addObject:button];
    
    // 默认选中第0个按钮
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(XXTabBarButton *)button
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarView:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBarView:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
    // 修改选中状态
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    self.selectedButton.selected = YES;
}

/**
 *  设置frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.addButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    int count = (int)self.tabBarButtons.count;
    CGFloat buttonY = 0;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonH = h;
    for (int index = 0; index < count; index++) {
        XXTabBarButton *button = self.tabBarButtons[index];
        button.tag = index;
        
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

@end
