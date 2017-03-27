//
//  BindingBankWebViewVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/24.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "BindingBankWebViewVC.h"

@interface BindingBankWebViewVC ()<UIWebViewDelegate>

@property (strong,nonatomic) UIWebView * webView;

@end

@implementation BindingBankWebViewVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.navTitle];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.navTitle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"快捷支付";
    //创建UI
    [self creatUI];
    //请求报文
    [self requestMessageData];
}

#pragma mark - 创建UI
-(void)creatUI
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    //禁止检测 数字链接问题
    _webView.dataDetectorTypes = UIDataDetectorTypeNone;
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

#pragma mark - 请求报文
-(void)requestMessageData
{
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"mergePaymentId":_mergePaymentId,
                                    @"paymentModeId":@"2",
                                    @"plantBankId":_plantBankId,
                                    };
    [VJDProgressHUD showProgressHUD:nil];
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetToPayURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showSuccessHUD:nil];
            NSString * baseUrl = OrderToPayUrl;
            NSString * urlString = [NSString stringWithFormat:@"%@?action=%@&orig=%@&sign=%@&returnurl=%@&NOTIFYURL=%@",
                                    baseUrl,
                                    [responseObject objectForKey:@"action"],
                                    [responseObject objectForKey:@"orig"],
                                    [responseObject objectForKey:@"sign"],
                                    [responseObject objectForKey:@"returnurl"],
                                    [responseObject objectForKey:@"NOTIFYURL"]];
            NSURL * requestUrl = [NSURL URLWithString:urlString];
            NSURLRequest * request = [NSURLRequest requestWithURL:requestUrl];
            [weakSelf.webView loadRequest:request];
        }else{
            [VJDProgressHUD showErrorHUD:nil];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark UIWebViewDelegate 代理
//获取它加载的网页上面的事件，比如单击了图片，单击了按钮等等。
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

//加载出错
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    ELog(@"faild");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
