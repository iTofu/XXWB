//
//  XXNewfeatureViewController.m
//  XXWB
//
//  Created by 刘超 on 14/12/16.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXNewfeatureViewController.h"
#import "XXCheckbox.h"
#import "XXTabBarController.h"

#define XXNewfeatureImageCount 4

@interface XXNewfeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation XXNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化scrollView
    [self setupScrollView];
    
    // 初始化pageControl
    [self setupPageControl];
}

/**
 *  初始化scrollView
 */
- (void)setupScrollView
{
    // 添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    CGFloat contentW = scrollView.bounds.size.width * XXNewfeatureImageCount;
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(contentW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // 添加图片
    CGFloat imageW = scrollView.bounds.size.width;
    CGFloat imageH = scrollView.bounds.size.height;
    for (int index = 0; index < XXNewfeatureImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        imageView.image = [UIImage imageNamed:imageName];
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        
        // 最后一页图
        if (index == XXNewfeatureImageCount - 1) {
            imageView.userInteractionEnabled = YES;
            
            // 添加跳转按钮
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *bg = [UIImage imageNamed:@"new_feature_finish_button"];
            [button setBackgroundImage:bg forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            [button setTitle:@"进入小小微博" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
            
            CGFloat centerX = imageView.bounds.size.width * 0.5;
            CGFloat centerY = imageView.bounds.size.height - 88;
            button.center = CGPointMake(centerX, centerY);
            button.bounds = (CGRect){CGPointZero, bg.size};
            [imageView addSubview:button];
            
            // 添加checkbox
            XXCheckbox *checkbox = [XXCheckbox checkboxWithTitle:@"分享到我的微博"];
            checkbox.selected = YES;
            [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
            
            CGFloat checkX = imageView.bounds.size.width * 0.5;
            CGFloat checkY = centerY + 40;
            checkbox.center = CGPointMake(checkX, checkY);
            [imageView addSubview:checkbox];
        }
    }
}

- (void)checkboxClick:(XXCheckbox *)checkbox
{
    checkbox.selected = !checkbox.selected;
}

/**
 *  跳转控制器
 */
- (void)start
{
#warning 帮用户分享一条新特性微博
    
    [UIView animateWithDuration:0.7 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        self.view.window.rootViewController = [[XXTabBarController alloc] init];
    }];
}

/**
 *  初始化pageControl
 */
- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = XXNewfeatureImageCount;
    pageControl.pageIndicatorTintColor = XXColor(189, 189, 189);
    pageControl.currentPageIndicatorTintColor = XXColor(241, 99, 43);
    
    CGFloat centerX = self.view.bounds.size.width * 0.5;
    CGFloat centerY = self.view.bounds.size.height - 20;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    self.pageControl.currentPage = page;
}

@end
