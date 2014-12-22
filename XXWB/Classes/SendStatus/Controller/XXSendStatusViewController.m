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

@property (nonatomic, weak) UITextView *inputView;

@end

@implementation XXSendStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置文本框
    [self setupInputView];
    
    // 设置导航栏按钮
    [self setupBarButtonItem];
}

/**
 *  设置文本框
 */
- (void)setupInputView
{
    UITextView *inputView = [[UITextView alloc] init];
    inputView.delegate = self;
    inputView.frame = self.view.bounds;
    [self.view addSubview:inputView];
    self.inputView = inputView;
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
              [MBProgressHUD hideHUD];
              [MBProgressHUD showSuccess:@"发送成功"];
              [self dismissViewControllerAnimated:YES completion:nil];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              XXLog(@"error: %@", error.localizedDescription);
              
              [MBProgressHUD hideHUD];
              [MBProgressHUD showError:@"发送失败"];
          }];
}

@end
