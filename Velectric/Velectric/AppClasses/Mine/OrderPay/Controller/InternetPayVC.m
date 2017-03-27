//
//  InternetPayVC.m
//  Velectric
//
//  Created by hongzhou on 2017/1/11.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "InternetPayVC.h"

@interface InternetPayVC ()<UIWebViewDelegate>

@property (strong,nonatomic) UIWebView * webView;

@end

@implementation InternetPayVC

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
    self.navTitle = @"网关支付";
    
    //创建UI
    [self creatUI];
    //请求报文
    [self requestToPay];
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
-(void)requestToPay
{
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"mergePaymentId":_mergePaymentId,
                                    @"paymentModeId":@"1",
                                    @"plantBankId":@"",
                                    };
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetToPayURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        [VJDProgressHUD dismissHUD];
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showSuccessHUD:nil];
            NSString * baseUrl = @"http://192.168.1.8:8089/views/my/order/toPay.html";
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

#pragma mark - UIWebViewDelegate 代理
//获取它加载的网页上面的事件，比如单击了图片，单击了按钮等等。
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL * url = [request URL];
    NSString * stringUrl = [url absoluteString];
    NSString * baseUrl = [[stringUrl componentsSeparatedByString:@"?"] firstObject];
    ELog(@"%@\n%@",stringUrl,baseUrl);
    
    //触击了一个链接
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        
    }
    //提交了一个表单
    else if (navigationType == UIWebViewNavigationTypeFormSubmitted)
    {
        
    }
    //触击前进或返回按钮
    else if (navigationType == UIWebViewNavigationTypeBackForward)
    {
        
    }
    //触击重新加载的按钮
    else if (navigationType == UIWebViewNavigationTypeReload)
    {
        
    }
    //重复提交表单
    else if (navigationType == UIWebViewNavigationTypeFormResubmitted)
    {
        
    }
    //发生其它行为
    else if (navigationType == UIWebViewNavigationTypeOther)
    {
        
        
    }
    return YES;
}

//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSString * string = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    ELog(@"%@",string);
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    NSString * string = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    NSString * url = [[string componentsSeparatedByString:@"?"] firstObject];
    
    ELog(@"%@",url);
}

//加载出错
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    ELog(@"faild");
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
