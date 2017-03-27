//
//  BaseWebView.h
//  WiFi
//
//  Created by redHeart on 15/7/6.
//  Copyright (c) 2015年 &#32418;&#24515;&#22825;&#32536;&#32593;&#32476;&#31185;&#25216;&#26377;&#38480;&#20844;&#21496;. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface BaseWebView : UIViewController

//在ios8 之前用webView , ios8 之后用wkWebView
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)WKWebView *wkWebView;
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *token;
- (void)loadWebPage:(NSString *)url;

- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
- (BOOL)validateRequestURL:(NSURL *)requestURL;
@end
