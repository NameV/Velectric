//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "VUpdateManager.h"//检查更新
#import "VPalceHolderViewController.h"//程序加载时默认的控制器

@interface AppDelegate ()<WXApiDelegate>

//引导页
@property (strong,nonatomic) UIScrollView * guideView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //添加切换登录页面的通知
    [self changRootViewController];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //************************检查用户状态*****************************
    
    //****之前代码
    /*if (![UserDefaults boolForKey:DEFINE_STRING_LOGIN]){
        [self creatLoginView];
    }else{
        VelectricTabbarController * tabbar = [[VelectricTabbarController alloc]init];
        self.window.rootViewController =tabbar;
        [self.window makeKeyAndVisible];
    }*/
    //***
    
    //默认控制器
    VPalceHolderViewController *placeHolderCon = [[VPalceHolderViewController alloc]init];
    self.window.rootViewController = placeHolderCon;
    [self.window makeKeyAndVisible];
    
    //检查用户状态
    [[VUpdateManager shareManager]checkUserNameState];

    //************************检查用户状态*****************************
    
    /******** 微信注册 *******/
    [WXApi registerApp:@"wx58e030f56f357e85" withDescription:@"V机电1.0"];
    
    /******** 友盟统计 *******/
    UMConfigInstance.appKey = @"586b6309f5ade429500016f5";
    UMConfigInstance.channelId = @"App Store";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    //设置是否开启background模式, 默认YES
    [MobClick setBackgroundTaskEnabled:NO];
    //配置以上参数后调用此方法初始化SDK！
    [MobClick startWithConfigure:UMConfigInstance];
    
//    //首次安装
//    if (!FIRST_INSTALL) {
//        //创建引导页
//        [self creatGuideView];
//    }
    
    //检测网络状态
    [self AFNetWorking];
    
    return YES;
}

#pragma mark - 创建引导页
-(void)creatGuideView
{
    NSArray *array = nil;
    if (SCREEN_WIDTH == 480)
        array = [[NSArray alloc] initWithObjects:@"guide1_1", @"guide1_2", @"guide1_3", nil];
    else
        array = [[NSArray alloc] initWithObjects:@"guide2_1", @"guide2_2", @"guide2_3", nil];
    
    _guideView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _guideView.contentSize = CGSizeMake(SCREEN_WIDTH * [array count], SCREEN_HEIGHT);
    _guideView.showsHorizontalScrollIndicator = NO;
    _guideView.pagingEnabled = YES;
    _guideView.bounces = NO;
    [self.window addSubview:_guideView];
    
    for (int i = 0; i < [array count]; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.image = [UIImage imageNamed:[array objectAtIndex:i]];
        imageView.userInteractionEnabled = YES;
        [_guideView addSubview:imageView];
        
        if (i==array.count-1) {
            //立即体验
            UIImage * image = [UIImage imageNamed:@"quickExperience"];
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - image.size.width)/2, SCREEN_HEIGHT - 50 - image.size.height, image.size.width, image.size.height)];
            [button setImage:image forState:UIControlStateNormal];
            [button addTarget:self action:@selector(removeGuideView) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }else{
            //跳过
            UIImage * image = [UIImage imageNamed:@"jumpOver"];
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - image.size.width - 30, SCREEN_HEIGHT - 30 - image.size.height, image.size.width, image.size.height)];
            [button setImage:image forState:UIControlStateNormal];
            [button addTarget:self action:@selector(removeGuideView) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
    }
}

#pragma mark - 移除引导页
- (void)removeGuideView
{
    [UIView animateWithDuration:2 animations:^{
        _guideView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_guideView removeFromSuperview];
        _guideView = nil;
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"First_Install"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}

#pragma mark - 改变rootviewcontroller
-(void)changRootViewController
{               
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(creatLoginView) name:@"changRootViewController" object:nil];
}

#pragma mark 创建登录页面
-(void)creatLoginView
{
    LoginViewController * login = [[LoginViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:login];
    [loginNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"barBg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [loginNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [loginNav.navigationBar setShadowImage:[UIImage new]];
    UIImage *image = [UIImage imageNamed:@"backJianTou-1"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    loginNav.navigationBar.backIndicatorImage = image;
    loginNav.navigationBar.backIndicatorTransitionMaskImage = image;
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    loginNav.navigationItem.backBarButtonItem = backBtn;
    [self.window makeKeyAndVisible];
    self.window.rootViewController =loginNav;
}

//授权后回调 WXApiDelegate
-(void)onResp:(BaseReq *)resp
{
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp *)resp;
        switch (response.errCode){
            case WXSuccess:
            {
                //服务器端查询支付通知或查询API返回的结果再提示成功
                ELog(@"支付成功");
                //发通知，跳转支付成功界面
                
                [[NSNotificationCenter defaultCenter] postNotificationName:PAY_SUCCESS object:nil];
            }
                break;
            default:
            {
                ELog(@"支付失败， retcode=%d,retstr = %@",response.errCode,response.errStr);
            }
                break;
        }
    }
}

#pragma mark 微信支付代理
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSString * resultStatus = [resultDic objectForKey:@"resultStatus"];
            //订单支付成功
            if ([resultStatus integerValue] == 9000)
            {
                [VJDProgressHUD showSuccessHUD:@"支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:PAY_SUCCESS object:nil];
            }else{
                [VJDProgressHUD showErrorHUD:@"支付失败"];
            }
            
//            NSString * result = [resultDic objectForKey:@"result"];
//            NSDictionary * dic = [result getDictionaryFromJosnString];
//            NSDictionary * alipay_trade_app_pay_response = [dic objectForKey:@"alipay_trade_app_pay_response"];
//            
//            //后台 订单号
//            NSString * mergePaymentId = [alipay_trade_app_pay_response objectForKey:@"out_trade_no"];
//            //支付宝 交易号
//            NSString * trade_no = [alipay_trade_app_pay_response objectForKey:@"trade_no"];
//            
//            //后台支付需要的参数
//            NSMutableDictionary * payDic = [NSMutableDictionary dictionary];
//            [payDic setObject:mergePaymentId forKey:@"mergePaymentId"];
//            [payDic setObject:trade_no forKey:@"trade_no"];
//            
//            NSString * resultStatus = [resultDic objectForKey:@"resultStatus"];
//            //订单支付成功
//            if ([resultStatus integerValue] == 9000)
//            {
//                [payDic setObject:@"success" forKey:@"trade_status"];
//                [self requstPayService:payDic];
//            }
//            //正在处理中
//            else if ([resultStatus integerValue] == 8000)
//            {
//                [payDic setObject:@"fail" forKey:@"trade_status"];
//                [self requstPayService:payDic];
//            }
//            //订单支付失败
//            else if ([resultStatus integerValue] == 4000)
//            {
//                [payDic setObject:@"fail" forKey:@"trade_status"];
//                [self requstPayService:payDic];
//            }
//            //用户中途取消
//            else if ([resultStatus integerValue] == 6001)
//            {
//                [payDic setObject:@"fail" forKey:@"trade_status"];
//                [self requstPayService:payDic];
//            }
//            //网络连接出错
//            else if ([resultStatus integerValue] == 6002)
//            {
//                [payDic setObject:@"fail" forKey:@"trade_status"];
//                [self requstPayService:payDic];
//            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            ELog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            ELog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    else{
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    ELog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            ELog(@"result = %@",resultDic);
            NSString * resultStatus = [resultDic objectForKey:@"resultStatus"];
            //订单支付成功
            if ([resultStatus integerValue] == 9000)
            {
                
            }
            //正在处理中
            else if ([resultStatus integerValue] == 8000)
            {
                
            }
            //订单支付失败
            else if ([resultStatus integerValue] == 4000)
            {
                
            }
            //用户中途取消
            else if ([resultStatus integerValue] == 6001)
            {
                
            }
            //网络连接出错
            else if ([resultStatus integerValue] == 6002)
            {
                
            }
        }];
    }
    //支付宝钱包快登授权返回authCode
    if ([url.host isEqualToString:@"platformapi"]){
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            ELog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            ELog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    //微信支付
    if ([url.host isEqualToString:@"pay"]){
        return  [WXApi handleOpenURL:url delegate:self];
    }

    return YES;
}

#pragma mark - 支付宝 回调
//-(void)requstPayService:(NSDictionary *)dic
//{
//    [SYNetworkingManager GetOrPostWithHttpType:1 WithURLString:GetAlipayRetifyInterfaceURL parameters:dic success:^(NSDictionary *responseObject) {
//        
//            [VJDProgressHUD showSuccessHUD:nil];
//            //发通知，跳转支付成功界面
//            [[NSNotificationCenter defaultCenter] postNotificationName:PAY_SUCCESS object:dic];
//    } failure:^(NSError *error) {
//        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
//    }];
//}

#pragma mark - 检测网络状态

/**
 *  检测网络状态
 */
- (void)AFNetWorking {
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                [VJDProgressHUD showTextHUD:@"网络异常"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                [VJDProgressHUD showTextHUD:@"网络异常"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                [VJDProgressHUD showTextHUD:@"移动网络"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                [VJDProgressHUD showTextHUD:@"WIFI网络"];
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
