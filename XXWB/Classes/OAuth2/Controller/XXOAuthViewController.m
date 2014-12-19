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
#import "MBProgressHUD+LC.h"

#define XXOAuthAuthorizeURL @"https://api.weibo.com/oauth2/authorize?client_id=3041370356&redirect_uri=http://www.baidu.com"
#define XXOAuthAccessTokenURL @"https://api.weibo.com/oauth2/access_token"

@interface XXOAuthViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation XXOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加webView
    [self setupWebView];
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
}

#pragma mark - UIWebViewDelegate method

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在努力加载中...."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showSuccess:@"加载成功"];
    
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
    [MBProgressHUD hideHUD];
    [MBProgressHUD showError:@"加载失败"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    XXLog(@"当前请求网址: %@", request.URL);
    
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
              // 账号模型
              XXAccount *account = [XXAccount accountWithDict:responseObject];
              
              // 存储账号模型
              [XXAccountTool saveAccount:account];
              
              // 切换控制器: 新特征\首页
              [MBProgressHUD hideHUD];
              [MBProgressHUD showSuccess:@"登录成功"];
              
              [XXWeiboTool chooseRootViewController];
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              XXLog(@"请求失败: %@", error);
    }];
}

@end
