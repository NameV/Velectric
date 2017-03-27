//
//  BaseWebView.m
//  WiFi
//
//  Created by redHeart on 15/7/6.
//  Copyright (c) 2015年 &#32418;&#24515;&#22825;&#32536;&#32593;&#32476;&#31185;&#25216;&#26377;&#38480;&#20844;&#21496;. All rights reserved.
//

#import "BaseWebView.h"
#import "SVProgressHUD.h"
@interface BaseWebView ()<UIWebViewDelegate,WKNavigationDelegate>
{
    UIImageView *imageView;
    UILabel *label;
    CGFloat count;
    NSURLRequest *request;
    bool isGoToLogin;
    bool loadFail;
    CGFloat height;
}
@property (strong,nonatomic)UIView *loadProgress;
@property (strong,nonatomic)NSTimer *timer;
@end

@implementation BaseWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self initWebView];
    height = 0;
    [self loadWebPage:self.url];
    loadFail = false;
}
- (void)reloadWebView:(NSString *)token{
    self.token = token;
    [self loadWebPage:self.url];
}
- (void)postInformation:(NSNotification *)note
{
    NSLog(@"Login success!!");
    self.token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    [self loadWebPage:self.url];
}

- (UIView *)loadProgress{
    
    if (!_loadProgress) {
        self.loadProgress = [[UIView alloc] initWithFrame:CGRectMake(0, height,0,3)];
        self.loadProgress.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_loadProgress];
    }
    return _loadProgress;
}

- (void)updateLoadProgressFrame{
    self.loadProgress.alpha = 1;
    if (self.loadProgress.frame.size.width < 0.9 * self.view.frame.size.width) {
        [UIView animateWithDuration:0.01 animations:^{
            count = count + 0.05;
            self.loadProgress.frame = CGRectMake(0, height, count * self.view.frame.size.width, 3);
        }];
    }else{
        [_timer invalidate];
        [UIView animateWithDuration:0.5 animations:^{
            self.loadProgress.frame = CGRectMake(0, height, 0.95 * self.view.frame.size.width, 3);
            
        }];
    }
    
}

- (void)loadFail{
    loadFail = true;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    imageView.center = CGPointMake(self.view.frame.size.width / 2, self.view.center.y / 1.5);
    imageView.image = [UIImage imageNamed:@"iconfont-shibaizhuanhuan"];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 60)];
    label.numberOfLines = 0;
    label.center = CGPointMake(self.view.frame.size.width / 2, self.view.center.y / 1.5 + 70);
    label.text = @"网络加载失败,轻触表情重新加载";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    self.loadProgress.alpha = 0;
    self.loadProgress.frame = CGRectMake(0, 0, 0, 0);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadWebView)];
    imageView.userInteractionEnabled = YES;
    
    [imageView addGestureRecognizer:tap];
    
    if (IOS8_OR_LATER) {
        //[_wkWebView loadHTMLString:@" " baseURL:nil];
        //[_wkWebView removeFromSuperview];
        [_wkWebView evaluateJavaScript:@"document.body.innerHTML='';" completionHandler:nil];
        [_wkWebView addSubview:imageView];
        [_wkWebView addSubview:label];
    } else {
        //[_webView removeFromSuperview];
        [_webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML='';"];
        [_webView addSubview:imageView];
        [_webView addSubview:label];
    }
    //[self.view addSubview:imageView];
    //[self.view addSubview:label];
}

- (void)reloadWebView{
    if (IOS8_OR_LATER) {
        [_wkWebView loadRequest:request];
    } else {
        [_webView loadRequest:request];
    }
    [imageView removeFromSuperview];
    [label removeFromSuperview];
    
}

//处理URL
-(NSString *)getCompleteURL:(NSString *)url{
    NSMutableString *result = [NSMutableString stringWithString:url];
    if (![url hasPrefix:@"http"]) {
//        [result setString:[NSString stringWithFormat:@"%@%@", Web_Base_Api, url]];
    }
    if (self.token) {
        [result setString:[self appendURL:result withToken:self.token]];
    }
    
    return result;
}

-(NSString *)appendURL:(NSString *)url withToken:(NSString *)token {
    if (token.length > 0) {
        return [NSString stringWithFormat:@"%@&token=%@",url,token];
    }else{
        return url;
    }
}

- (void)loadWebPage:(NSString *)url{
    
    NSURL *requestURL = [NSURL URLWithString: [self getCompleteURL:url]];
    request = [NSURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    if (IOS8_OR_LATER) {
        [self.wkWebView loadRequest:request];
    } else {
        [self.webView loadRequest:request];
    }
    
    
}

- (void)initWebView{
    if (IOS8_OR_LATER) {
        if (!_wkWebView) {
            self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            self.wkWebView.backgroundColor = [UIColor whiteColor];
            self.wkWebView.navigationDelegate = self;
        }
        [self.view addSubview:_wkWebView];
    } else {
        if (!_webView) {
            self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
            self.webView.backgroundColor = [UIColor whiteColor];
            _webView.delegate = self;
            self.webView.frame = self.view.frame;
            [self.view addSubview:_webView];
        }
        [self.view addSubview:_webView];
    }
}
- (BOOL)shouldAutorotate
{
    return YES;
}
//// 解决横屏时调用
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation NS_DEPRECATED_IOS(2_0,8_0) __TVOS_PROHIBITED{
//    
//}
//为了兼容IOS6以前的版本而保留的方法
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    NSLog(@"123");
    //return (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    return YES;//即在IOS6.0以下版本，支持所用方向的旋屏
}

-(void)startLoad{
    NSLog(@"开始加载数据");
    count = 0.00;
    [imageView removeFromSuperview];
    [label removeFromSuperview];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(updateLoadProgressFrame) userInfo:nil repeats:YES];
    
    [_timer setFireDate:[NSDate distantPast]];
}

-(void)finishLoad{
    NSLog(@"加载完数据");
    
    [_timer invalidate];
    [UIView animateWithDuration:0.5 animations:^{
        self.loadProgress.frame = CGRectMake(0, height, self.view.frame.size.width - 5, 3);
        
    } completion:^(BOOL finished) {
        self.loadProgress.alpha = 0;
        self.loadProgress.frame = CGRectMake(0, 0, 0, 0);
        count = 0;
    }];
    [imageView removeFromSuperview];
    [label removeFromSuperview];
    //imageView.userInteractionEnabled = NO;
}

//UIWebView 开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {
    imageView.frame = CGRectMake(0, 0, 0, 0);
    label.frame = CGRectMake(0, 0, 0, 0);
    [self startLoad];
}

// 解决横屏bug；
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    if (IOS8_OR_LATER) {
        self.wkWebView.frame = self.view.frame;
    } else {
        self.webView.frame = self.view.frame;
    }
}
//UIWebView 开始加载时需要做的额外操作，如是否显示加载中
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)req navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *requestURL = [req URL];
    return [self validateRequestURL:requestURL];
}

//UIWebView 加载出错
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败");
    [self performSelector:@selector(loadFail) withObject:nil afterDelay:4];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self performSelector:@selector(loadFail) withObject:nil afterDelay:4];
    
}
//UIWebView 数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"titile is %@", [webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    //    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self finishLoad];
}

// WKNavigationDelegate 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self startLoad];
}

// WKNavigationDelegate 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //navigationAction.request.URL.host
    NSLog(@"WKwebView ... didCommitNavigation ..");
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *requestURL = navigationAction.request.URL;
    
    if ([self validateRequestURL:requestURL]) {//允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
    } else {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

// WKNavigationDelegate 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id a, NSError *e) {
        NSLog(@"title is %@",a);
        NSString *tmpTitle = (NSString *)a;
        self.title = tmpTitle;
        
    }];
    
    [self finishLoad];
}

// WKNavigationDelegate 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载失败!!!!");
    [self performSelector:@selector(loadFail) withObject:nil afterDelay:4];
}

-(BOOL)validateRequestURL:(NSURL *)requestURL{

    return true;
}
-(void)showStoreProductInApp:(NSURL *)appString{
    
    [[UIApplication sharedApplication] openURL:appString];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.loadProgress = nil;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.loadProgress.frame = CGRectMake(0, 0, 0, 0);
    [self.loadProgress removeFromSuperview];
    self.loadProgress = nil;
    //imageView.userInteractionEnabled = NO;
    [SVProgressHUD dismiss];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"supportInterface" object:nil];
    

    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.loadProgress removeFromSuperview];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
