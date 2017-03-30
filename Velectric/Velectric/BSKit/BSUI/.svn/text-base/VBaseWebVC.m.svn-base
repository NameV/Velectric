//
//  VBaseWebVC.m
//  Velectric
//
//  Created by LYL on 2017/2/27.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VBaseWebVC.h"
#import <WebKit/WebKit.h>
#import "OrderListVC.h"

@interface VBaseWebVC ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) UIBarButtonItem *leftItem;

@end

@implementation VBaseWebVC{
    NSString *_urlString;
    NSString *_title;
}

- (instancetype)initWithUrlString:(NSString *)urlString title:(NSString *)title{
    self = [super init];
    if (self) {
        _title = title;
        _urlString = urlString;
    }
    return self;
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
    
    self.navTitle = _title;
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    [self.view addSubview:webView];
    webView.navigationDelegate = self;
    self.webview = webView;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [VJDProgressHUD showProgressHUD:nil];
    
    //首页
    if ([webView.URL.absoluteString containsString:@"index/index.html"] ) {
        self.tabBarController.selectedIndex = 0;
        
        dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [self.navigationController popToRootViewControllerAnimated:NO];
        });
    }
    
    //订单中心
    if ([webView.URL.absoluteString containsString:@"orderCenter/orderCenter.html"] ) {
        OrderListVC * vc = [[OrderListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [VJDProgressHUD showSuccessHUD:nil];
    
    
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
