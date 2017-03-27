//
//  VBaseWebVC.m
//  Velectric
//
//  Created by LYL on 2017/2/27.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VBaseWebVC.h"
#import <WebKit/WebKit.h>
#import "VBatchListViewController.h"

@interface VBaseWebVC ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) UIBarButtonItem *leftItem;

@end

@implementation VBaseWebVC{
    NSString *_urlString;
}

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _urlString = urlString;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [VJDProgressHUD dismissHUD];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webViewConfig];
}

#pragma mark - action

- (void)didBack:(id)sender {
    if ([self.webview canGoBack]) {
        [self.webview goBack];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)webViewConfig {
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    [self.view addSubview:webView];
    webView.navigationDelegate = self;
    self.webview = webView;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [VJDProgressHUD showProgressHUD:nil];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [VJDProgressHUD showSuccessHUD:nil];
    
    if ([webView canGoBack]) {
        self.navigationItem.leftBarButtonItem = self.leftItem;
        if ([webView.URL.absoluteString containsString:@"title="]) {
            self.navTitle = [webView.URL.absoluteString componentsSeparatedByString:@"title="][1];
        }
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
}

#pragma mark - getter

//左侧返回按钮
- (UIBarButtonItem *)leftItem {
    if (!_leftItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 20, 20);
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
        [button addTarget:self action:@selector(didBack:) forControlEvents:UIControlEventTouchUpInside];
        _leftItem = item;
    }
    return _leftItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
