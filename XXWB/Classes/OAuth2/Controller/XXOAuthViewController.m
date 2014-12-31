//
//  XXOAuthViewController.m
//  XXWB
//
//  Created by 刘超 on 14/12/18.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXOAuthViewController.h"
#import "AFNetworking.h"
#import "XXAccount.h"
#import "XXWeiboTool.h"
#import "XXAccountTool.h"
#import "SVProgressHUD.h"
#import "XXFailLoadBtn.h"

@interface XXOAuthViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) XXFailLoadBtn *failLoadBtn;

@end

@implementation XXOAuthViewController

- (XXFailLoadBtn *)failLoadBtn
{
    if (_failLoadBtn == nil) {
        XXFailLoadBtn *failLoadBtn = [[XXFailLoadBtn alloc] init];
        failLoadBtn.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
        [self.view addSubview:failLoadBtn];
        [self.view bringSubviewToFront:failLoadBtn];
        self.failLoadBtn = failLoadBtn;
        XXLog(@"%@", NSStringFromCGRect(failLoadBtn.frame));
    }
    return _failLoadBtn;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"新浪账号授权";
    
    // 添加webView
    [self setupWebView];
    
    // 添加刷新按钮
    [self setupRefreshBtn];
}

/**
 *  添加刷新按钮
 */
- (void)setupRefreshBtn
{
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleBordered target:self action:@selector(refresh)];
    self.navigationItem.leftBarButtonItem = refreshBtn;
}

/**
 *  刷新webView
 */
- (void)refresh
{
    [self.webView reload];
}

/**
 *  添加webView
 */
- (void)setupWebView
{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    
    // 发送授权请求
    [self shouquan];
}

/**
 *  发送授权请求
 */
- (void)shouquan
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:XXOAuthAuthorizeURL]];
    [self.webView loadRequest:request];
    XXLog(@"--%@", request.URL);
}

#pragma mark - UIWebViewDelegate method

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // HUD
    [SVProgressHUD showWithStatus:@"正在连接" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:XXColor(246, 246, 246)];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // HUD
    [SVProgressHUD showSuccessWithStatus:@"连接成功"];
    
    self.failLoadBtn.hidden = YES;
    self.webView.hidden = NO;
    
    NSString *urlString = webView.request.URL.absoluteString;
    
    if ([urlString isEqualToString:XXOAuthAuthorizeURL]) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        // 添加一个返回授权按钮
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回授权" style:UIBarButtonItemStyleBordered target:self action:@selector(shouquan)];
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // HUD
    [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
    
    self.failLoadBtn.hidden = NO;
    self.webView.hidden = YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    XXLog(@"RequestURL: %@", request.URL);
    
    // 获取code后
    NSString *urlString = request.URL.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    
    if (range.length) {
        [self.webView removeFromSuperview];
        
        NSString *code = [urlString substringFromIndex:(range.location + range.length)];
        
        // 给新浪发送POST请求获取access_token
        [self accessTokenWithCode:code];
    }
    
    return YES;
}

#pragma mark - send POST request

/**
 *  给新浪发送POST请求获取access_token
 */
- (void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *paramenters = [NSMutableDictionary dictionary];
    paramenters[@"client_id"] = @"3041370356";
    paramenters[@"client_secret"] = @"e588195b5e977c36bb7e820b10b0318e";
    paramenters[@"grant_type"] = @"authorization_code";
    paramenters[@"code"] = code;
    paramenters[@"redirect_uri"] = @"http://www.baidu.com";
    
    // 发送POST请求
    [manager POST:XXOAuthAccessTokenURL
       parameters:paramenters
          success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
              // HUD
              [SVProgressHUD showSuccessWithStatus:@"登录成功"];
              
              // 账号模型
              XXAccount *account = [XXAccount accountWithDict:responseObject];
              
              // 存储账号模型
              [XXAccountTool saveAccount:account];
              
              // 切换控制器: 新特征\首页
              [XXWeiboTool chooseRootViewController];
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [SVProgressHUD showErrorWithStatus:@"登录失败"];
              XXLog(@"请求失败: %@", error);
    }];
}

@end
