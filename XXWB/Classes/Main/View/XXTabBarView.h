//
//  XXTabBarView.h
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXTabBarView;

@protocol XXTabBarViewDelegate <NSObject>

@optional

- (void)tabBarView:(XXTabBarView *)tabBarView didSelectedButtonFrom:(int)from to:(int)to;

- (void)tabBarViewSendStatus:(XXTabBarView *)tabBarView;

@end

@interface XXTabBarView : UIView

@property (nonatomic, weak) id<XXTabBarViewDelegate> delegate;

/**
 *  添加按钮
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
