//
//  XXSendStatusViewController.m
//  XXWB
//
//  Created by 刘超 on 14/12/19.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXSendStatusViewController.h"
#import "AFNetworking.h"
#import "XXAccountTool.h"
#import "XXAccount.h"
#import "MBProgressHUD+LC.h"

@interface XXSendStatusViewController () <UITextViewDelegate>

/** 新微博输入框 */
@property (nonatomic, weak) UITextView *inputView;
/** 发送按钮 */
@property (nonatomic, weak) UIBarButtonItem *rightBtn;

@end

@implementation XXSendStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏按钮
    [self setupBarButtonItem];
    
    // 设置文本框
    [self setupInputView];
}

/**
 *  设置文本框
 */
- (void)setupInputView
{
    UITextView *inputView = [[UITextView alloc] init];
    inputView.delegate = self;
    inputView.frame = self.view.bounds;
    inputView.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:inputView];
    self.inputView = inputView;
    
    [self textViewDidChange:inputView];
}

/**
 *  设置导航栏按钮
 */
- (void)setupBarButtonItem
{
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem = right;
    self.rightBtn = right;
}

/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送
 */
- (void)send
{
    // HUD
    [MBProgressHUD showMessage:@"正在发送中...."];
    
    // [self.inputView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    NSString *newStatus = self.inputView.text;
    
    // 发微博
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *pars = [NSMutableDictionary dictionary];
    pars[@"access_token"] = [XXAccountTool account].access_token;
    pars[@"status"] = newStatus;
    
    [manager POST:XXUpdateStatus
       parameters:pars
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              dispatch_async(dispatch_get_main_queue(), ^{
                  [MBProgressHUD hideHUD];
                  [MBProgressHUD showSuccess:@"发送成功"];
              });
              
              [self dismissViewControllerAnimated:YES completion:nil];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [MBProgressHUD hideHUD];
              [MBProgressHUD showSuccess:@"发送失败"];
              
              XXLog(@"error: %@", error.localizedDescription);
          }];
}

#pragma mark - UITextViewDelegate method

- (void)textViewDidChange:(UITextView *)textView
{
    self.rightBtn.enabled = textView.text.length > 0;
}

@end
