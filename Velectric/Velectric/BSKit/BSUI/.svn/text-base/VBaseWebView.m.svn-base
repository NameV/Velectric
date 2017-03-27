//
//  VBaseWebView.m
//  Velectric
//
//  Created by LYL on 2017/3/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VBaseWebView.h"

@implementation VBaseWebView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
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
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
}


@end
