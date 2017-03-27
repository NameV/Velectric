//
//  VDiscoverViewController.m
//  Velectric
//
//  Created by MacPro04967 on 2017/2/14.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VDiscoverViewController.h"
#import <WebKit/WebKit.h>
#import "VBatchShopViewController.h"

@interface VDiscoverViewController ()<WKNavigationDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) UIBarButtonItem *leftItem;

@end

@implementation VDiscoverViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [VJDProgressHUD dismissHUD];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webViewConfig];
}


- (void)webViewConfig {
    
    self.navigationController.delegate = self;
    
    //设置状态栏颜色
    UIView *statusBarView = [[UIView alloc]   initWithFrame:CGRectMake(0, 0,    self.view.bounds.size.width, 20)];
    statusBarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:statusBarView];

    //frame的H要给20
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    NSString *urlString = [NSString stringWithFormat:@"%@?uid=%@",DiscoverH5Url,GET_USER_INFO.loginName];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [self.view addSubview:webView];
    webView.navigationDelegate = self;
    self.webview = webView;
}

#pragma mark - action

- (void)didBack:(id)sender {
    if ([self.webview canGoBack]) {
        [self.webview goBack];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - webview delegate

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [VJDProgressHUD showProgressHUD:nil];
    if ([webView.URL.absoluteString containsString:@"http://vjd/pljh"]) {
        VBatchShopViewController *VC = [[VBatchShopViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
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
        self.navTitle = @"发现";
    }
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
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
