//
//  CommitOrderVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/14.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "CommitOrderVC.h"
#import "OrderPaySuccessVC.h"
#import "QuickPayVC.h"                  //快捷支付
#import "OrderListVC.h"                 //订单中心
#import "PayTypeModel.h"                //支付方式
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "RSADataSigner.h"
#import "InternetPayVC.h"
#import "WXApi.h"
#import "AlertView.h"                   //提示框

@interface CommitOrderVC ()<WXApiDelegate,AlertViewDelegate>

//订单金额
@property (assign,nonatomic) CGFloat totalAmount;
@property (nonatomic, copy) NSString *payWay;                   //支付方式
@property (nonatomic, copy) NSString *orderNum;                 //流水单号

//支付方式list
@property (strong,nonatomic) NSMutableArray <PayTypeModel *>* payTypeList;

@end

@implementation CommitOrderVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.navTitle];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goPaySuccessVC) name:PAY_SUCCESS object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.navTitle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"订单提交";
    [self setRightBarButtonWithTitle:@"订单中心" withImage:nil withAction:@selector(goOrderCenter:)];
    [self setLeftBarButtonWithAction:@selector(backToRootController)];
    _payTypeList = [NSMutableArray array];
    
    //请求数据
    [self requestMergePaymentId];
}

#pragma mark - 请求数据
-(void)requestMergePaymentId
{
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"mergePaymentId":_mergePaymentId,
                                    };
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetMergePaymentIdURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showSuccessHUD:nil];
            self.totalAmount = [[responseObject objectForKey:@"totalAmount"] floatValue];
            self.orderNum = responseObject[@"mergePaymentId"];
            NSArray * payModes = [responseObject objectForKey:@"payModes"];
            for (NSDictionary * dic in payModes) {
                PayTypeModel * model = [[PayTypeModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [weakSelf.payTypeList addObject:model];
            }
            //创建UI
            [weakSelf creatUI];
        }else{
            [VJDProgressHUD showErrorHUD:nil];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - 创建UI
-(void)creatUI
{
    //白色背景
    UIView * bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 168)];
    bgView1.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:bgView1];
    
    //提交成功图片
    UIImage * image = [UIImage imageNamed:@"tijiaodingdan"];
    UIImageView * successImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - image.size.width)/2, 30, image.size.width, image.size.height)];
    successImage.image = image;
    [self.view addSubview:successImage];
    
    //订单提交成功
    UILabel * successLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, successImage.bottom + 9, 200, 20)];
    successLab.font = Font_1_F16;
    successLab.textColor = COLOR_666666;
    successLab.text = @"订单提交成功";
    successLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:successLab];
    
    //提示label
    UILabel * alertLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 250)/2, successLab.bottom + 15, 250, 20)];
    alertLab.font = Font_1_F13;
    alertLab.textColor = COLOR_999999;
    alertLab.text = @"请您在提交订单后1小时内完成支付";
    alertLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:alertLab];
    
    //灰色线条
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, bgView1.bottom - 0.5, SCREEN_WIDTH, 0.5)];
    lineView1.backgroundColor = COLOR_DDDDDD;
    [self.view addSubview:lineView1];
    
    //订单金额
    UILabel * orderMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(18, bgView1.bottom, 80, 40)];
    orderMoneyLab.font = Font_1_F15;
    orderMoneyLab.textColor = COLOR_333333;
    orderMoneyLab.text = @"订单金额";
    [self.view addSubview:orderMoneyLab];
    
    //金额
    UILabel * moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150, orderMoneyLab.top, 132, orderMoneyLab.height)];
    moneyLab.font = Font_1_F15;
    moneyLab.textColor = COLOR_F44336;
    moneyLab.text = [NSString stringWithFormat:@"¥%.2f",_totalAmount];
    moneyLab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:moneyLab];
    
    //白色背景
    UIView * bgView2 = [[UIView alloc]initWithFrame:CGRectMake(0, orderMoneyLab.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - orderMoneyLab.bottom)];
    bgView2.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:bgView2];
    
    //灰色线条
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, bgView2.top, SCREEN_WIDTH, 0.5)];
    lineView2.backgroundColor = COLOR_DDDDDD;
    [self.view addSubview:lineView2];
    
    for (int i=0; i<4; i++) {
        PayTypeModel * model = [_payTypeList objectAtIndex:i];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, bgView2.top + i*50, SCREEN_WIDTH, 50)];
        [btn addTarget:self action:@selector(doPayOrder:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.view addSubview:btn];
        
        //支付logo
        UIImage * logo;
        if ([model.Id integerValue] ==1) {
            logo = [UIImage imageNamed:@"wangguan"];
        }else if ([model.Id integerValue] ==2) {
            logo = [UIImage imageNamed:@"yinlian"];
        }else if ([model.Id integerValue] ==3) {
            logo = [UIImage imageNamed:@"zhifubao"];
        }else if ([model.Id integerValue] ==4) {
            logo = [UIImage imageNamed:@"weixin"];
        }

        UIImageView * logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(18, btn.top + (50-logo.size.height)/2, logo.size.width, logo.size.height)];
        logoImage.image = logo;
        [self.view addSubview:logoImage];
        
        //支付方式
        UILabel * payTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(logoImage.right + 20, btn.top, 100, btn.height)];
        payTypeLab.font = Font_1_F16;
        payTypeLab.textColor = COLOR_333333;
        payTypeLab.text = model.descript;
        [self.view addSubview:payTypeLab];
        
        //右边箭头
        UIImage * goImg = [UIImage imageNamed:@"youjiantou"];
        UIImageView * rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - goImg.size.width - 18, btn.top + (50-goImg.size.height)/2, goImg.size.width, goImg.size.height)];
        rightImage.image = goImg;
        [self.view addSubview:rightImage];
        
        UIView * lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, btn.bottom - 0.5, SCREEN_WIDTH, 0.5)];
        lineView3.backgroundColor = COLOR_DDDDDD;
        [self.view addSubview:lineView3];
    }
}

#pragma mark - 支付订单
-(void)doPayOrder:(UIButton *)sender
{
    PayTypeModel * model = [_payTypeList objectAtIndex:sender.tag];
    self.payWay = model.descript;//支付方式
    //网关支付
    if ([model.Id integerValue] ==1) {
        InternetPayVC * vc = [[InternetPayVC alloc]init];
        vc.mergePaymentId = _mergePaymentId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //快捷支付
    else if ([model.Id integerValue] ==2) {
        QuickPayVC * vc = [[QuickPayVC alloc]init];
        vc.mergePaymentId = _mergePaymentId;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    //支付宝
    else if ([model.Id integerValue] ==3) {
        [self zhifubaoPayWithPartner:nil withSeller:nil withPrivateKey:nil];
        return;
    }
    //微信支付
    else if ([model.Id integerValue] ==4) {
        //是否安装微信
//        if (![WXApi isWXAppInstalled]) {
//            [VJDProgressHUD showTextHUD:@"亲，您还没有安装微信"];
//            return;
//        }
//        //是否支持微信支付
//        if (![WXApi isWXAppSupportApi]) {
//            [VJDProgressHUD showTextHUD:@"不支持微信支付"];
//            return;
//        }
        //调用接口，请求参数
        [self weiChatPay];
    }
}

#pragma mark - 支付宝支付
-(void)zhifubaoPayWithPartner:(NSString * )partner withSeller:(NSString *)seller withPrivateKey:(NSString *)privateKey
{
    
//    NSString * partner1 = @"2088221444391149";
//    NSString * seller1 = @"xiamenshouhong@foxmail.com";
    NSString * rsa2PrivateKey = @"";
    
    NSString *rsaPrivateKey = @"MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCnES4DEgY2pvHKthbunYoQIzvo7yMhKZ9l2xQc+XL5R7qubPSmW/45dgoQjKETLnb8UI+8eeyW5dP+Qr7Lfznz2yUP6YbGdhi7c0HlURICLcu58opXC+c09gxiKATSWZbMifzYZYnk6eNzVepYew4OKxz3a1obo+B99nodyDXHa7ijpLPn5TomXW9uyj41Wdb1HC7Csv2xvfNAiig58Dbw5KvScyNMLVcQFcTt9vS90Yl/wsphTy7rnkZuyJe86X1r2MuYp5hw6m0GrIudtSooVI8mCbN+uKK+0GeYAVXYAHxeZdQtSBd0Y8t+BzZAIylcaMVNQkZEHDDQF/xg6C4VAgMBAAECggEAMuJ3qjW+ML0uXfiSCYFwQLQKlkrn3zznMMXGXYDYtPZU9LV42oagau356Mp8cPQxB26eKODV36wGoqW/qQmKJCz2H9+XzjDAHa/gPTExE/rQ10T5P8P/WtEqOmdH+K2S0Z+hpGNg2ZknTsS3SNXKFSSqgO1wl4SVZqhAz3tgbelya73PfgNw2hgooW7AyvPqQ2HaAJwm40YcmdDVjLWfJ9yIbHr0FQi2kLgP6M6BieG43xwRki/YDoDzOEp0CiIRwF8yj+NJOzATaZeK6xgNU0S54k1wIpnDCn28qJ01Z6OMrnARL0N+N/SS2bYYK6U0PAIheAZE81hg+YglUrgvQQKBgQDPDytkpmd3a7glov15P5YFqJss53/ueNmql5YKTYtJBqiecmIgFNiz52GztLvSxrZztt2c181Dcvt0RnW/WBMgjCBfHquqhabU9fJxrSMNO+Bs6bBcimaOs5jtKsmkiPQlmYpKDHa9rEQAUlaXSPvGeM0l/FRPfvW4SRbl2UDUUQKBgQDOjiXuZArtYNG0ba9fHtJOm7JnfQ/ZMqVdrlwzMXEgrtiQo5kd/rKwMk0gLeAigwKuqTfdY/AOz//49oCteVFHdpt3OQcCNwR2LFBqrYWg/dFrv5IB/PqT7nqNFR/P7I1+2OgCo/u35hLAyqTPhjZHFO2ei22CTF95T5KxM4PghQKBgQCALLrG5n+cHFF08u2HtgXvYM0WQgQeoi7T/FxD6nazcOzGkLYPd/ghfbUsYk/2jU36WZPb+Ha3LyFbfBZ9qU7F0hhj6X+I4o1AvTMkjXHqSkuGAC9NSdtssN6Uyezi7mh8Mgy6A/cpOM8rh8zUf7hjxvnvbsDeKRCA0LXc+Ny50QKBgQCj7ZSU+bjiY7CKbXJ9H0zxLggMseheDB/JlZN+3YJW2ezt/aiLcZQG2iTzoPT87tS2IX5Aqgve9ZzEzX2aL2oeOTdxC0VQsLFNyCWaRFSFTGtkBAmwokGMHfwM8/LnZWl2flbDobkoXeQMNcdPG8j/6NAcv7MNcedjs49MKwJCsQKBgQCpxBDwxCSZqMnLYquR7fwksdNqPx9cf2wQh7lv1geP/1BajLvdk6+3QbqlnZVHnz3CKZlzEkJThfBwTON6/iEK9vDkF1gT/fepaOOKS27eHKys+VPKPvnACHmINZdRowo0WxN2xLhrwKjJwMt7hlQwd5bx9W5LbcjE2WLjCts5MA==";
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = @"2017010404832447";
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: 回调URL
    order.notify_url = AlipayNotifyInterfaceURL;
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = _mergePaymentId; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", _totalAmount]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"VJDAliPay";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            ELog(@"reslut = %@",resultDic);
        }];
    }
}

-(void)requestAlipayParam
{
    NSString *totalAmountStr = [NSString stringWithFormat:@"%f",self.totalAmount];
    NSDictionary * parameterDic = @{
                                    @"loginName" : GET_USER_INFO.loginName,
                                    @"mergePaymentId" :  _mergePaymentId ? _mergePaymentId : @"",
                                    @"total_amount" :  totalAmountStr ? totalAmountStr : @""
                                    };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:AlipayParamURL
                                    parameters:parameterDic
                                       success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showSuccessHUD:nil];
        }else{
            [VJDProgressHUD showErrorHUD:nil];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - 微信支付
-(void)weiChatPay
{
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"mergePaymentId":_mergePaymentId,//支付订单号
                                    @"tradeType":@"APP",//微信交易类型：JSAPI--公众号支付、APP--app支付
                                    };
//    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    NSString * string = @"http://192.168.1.134:8092/payWeixin/paywxH"; //GetPaywxHURL
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetPaywxHURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showSuccessHUD:nil];
            NSDictionary * unified = [responseObject objectForKey:@"unified"];
            NSString * openID = [unified objectForKey:@"appid"];
            NSString * nonceStr = [unified objectForKey:@"noncestr"];
            NSString * package = [unified objectForKey:@"packageStr"];
            NSString * partnerId = [unified objectForKey:@"partnerid"];
            NSString * prepayId = [unified objectForKey:@"prepayid"];
            NSString * sign = [unified objectForKey:@"sign"];
            NSString * timeStamp = [unified objectForKey:@"timestamp"];
            //调起微信支付
            PayReq * req            = [[PayReq alloc] init];
            req.openID              = openID;
            req.nonceStr            = nonceStr;
            req.package             = package;
            req.partnerId           = partnerId;
            req.sign                = sign;
            req.prepayId            = prepayId;
            req.timeStamp           = [timeStamp intValue];
            [WXApi sendReq:req];
        }else{
            NSString * msg = [responseObject objectForKey:@"msg"];
            [VJDProgressHUD showErrorHUD:msg];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark 微信支付回调
-(void) onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp *)resp;
        switch (response.errCode){
            case WXSuccess:
            {
                //服务器端查询支付通知或查询API返回的结果再提示成功
                ELog(@"支付成功");
            }
                break;
            default:
            {
                ELog(@"支付失败， retcode=%d",response.errCode);
            }
                break;
        }
    }
}

#pragma mark - 订单中心
-(void)goOrderCenter:(UIButton *)sender
{
    if (self.enterType == EnterType_OrderCenter) {
        [self.navigationController popViewControllerAnimated:NO];
        return;
    }
    OrderListVC * vc = [[OrderListVC alloc]init];
    vc.enterType = OrderCenterEnter_CommitOrder;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 前往，支付成功VC
-(void)goPaySuccessVC
{
    OrderPaySuccessVC * vc = [[OrderPaySuccessVC alloc]init];
    vc.totalAmount = self.totalAmount;//订单金额
    vc.payWay = self.payWay;//订单支付方式
    vc.orderNum = self.orderNum;//订单流水号
    vc.payTime = [NSDate getNowDate];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 返回
-(void)backToRootController
{
    AlertView * alert = [[AlertView alloc]initWithLeftTitle:@"确定" WithRightTitle:@"取消" ContentTitle:@"您支付未完成，确定要离开吗？"];
    alert.delegate = self;
    [[KGModal sharedInstance] showWithContentView:alert];
}

#pragma mark - AlertViewDelegate
- (void)okBtnAction
{
    [[KGModal sharedInstance] hide];
    
    //从订单进入
    if (self.enterType == EnterType_OrderCenter) {
        //返回上一级
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    //如果订单是从商品详情页进入的，OrderCenterEnter_MemberCenter,这样在返回的时候返回到上一个界面。
    if ([[NSUserDefaults standardUserDefaults]integerForKey:OrderFromeProductDetail] == 1) {
        //进入订单列表
        OrderListVC * vc = [[OrderListVC alloc]init];
        vc.enterType = OrderCenterEnter_MemberCenter;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    //从购物车进入，返回的时候返回第三个tabbar
    //进入订单列表
    OrderListVC * vc = [[OrderListVC alloc]init];
    vc.enterType = OrderCenterEnter_CommitOrder;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancleBtnAction
{
    [[KGModal sharedInstance] hide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
