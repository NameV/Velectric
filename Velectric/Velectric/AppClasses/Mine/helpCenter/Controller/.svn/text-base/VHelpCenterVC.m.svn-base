//
//  VHelpCenterVC.m
//  Velectric
//
//  Created by LYL on 2017/2/27.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VHelpCenterVC.h"
#import <WebKit/WebKit.h>
@interface VHelpCenterVC ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) UIBarButtonItem *leftItem;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation VHelpCenterVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [VJDProgressHUD dismissHUD];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"帮助中心";
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
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    self.webView = webView;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:HelpCenterUrl]]];
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
            NSString *title = [webView.URL.absoluteString componentsSeparatedByString:@"title="][1];
            self.navTitle = [title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }else{
        self.navigationItem.leftBarButtonItem = nil;
        self.navTitle = @"帮助中心";
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
