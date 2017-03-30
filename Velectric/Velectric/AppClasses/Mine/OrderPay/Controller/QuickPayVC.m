//
//  QuickPayVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/16.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "QuickPayVC.h"
#import "QuickPayCell.h"
#import "BankInfoModel.h"
#import "ChooseBankVC.h"
#import "AddBankCardVC.h"


#define PayUrl @"http://192.168.1.8:8089/views/my/order/binding_bankcard.html?mergePaymentId="

@interface QuickPayVC ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (strong,nonatomic) BaseTableView * tableView;

@property (strong,nonatomic) UIWebView * webView;

/* 总价格 */
@property (nonatomic, copy) NSString *totalAmount;

@end

@implementation QuickPayVC

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
    self.navTitle = @"快捷支付";
    [self setRightBarButtonWithTitle:nil withImage:[UIImage imageNamed:@"tianjiacard"] withAction:@selector(addQuickPay)];
    
    //创建UI
    [self creatUI];
    
//    NSString * payUrlString = [NSString stringWithFormat:@"%@%@",PayUrl,_mergePaymentId];
//    NSURL * url = [NSURL URLWithString:payUrlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
}

#pragma mark - 创建UI
-(void)creatUI
{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView addHeaderWithTarget:self action:@selector(refreshNetData)];
    [_tableView headerBeginRefreshing];
    [self.view addSubview:_tableView];

//    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
//    //禁止检测 数字链接问题
//    _webView.dataDetectorTypes = UIDataDetectorTypeNone;
//    _webView.delegate = self;
//    [self.view addSubview:_webView];
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

#pragma mark - FreshHeader
- (void)refreshNetData
{
    [self requestBankListInfo];
}

#pragma mark - 请求数据
-(void)requestBankListInfo
{
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"mergePaymentId":_mergePaymentId,
                                    @"paymentModeId":@"2",
                                    @"plantBankId":@"",
                                    };
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetMergeKJURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            NSArray * bankList = [responseObject objectForKey:@"bankList"];
            for (NSDictionary * dic in bankList) {
                BankInfoModel * model = [[BankInfoModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [weakSelf.tableView.dataArray addObject:model];
                _totalAmount = responseObject[@"totalAmount"];
            }
            if (bankList.count) {
                [weakSelf.tableView reloadData];
            }else{
                //没有绑定银行卡 进入绑卡界面
                ChooseBankVC * vc = [[ChooseBankVC alloc]init];
                vc.mergePaymentId = _mergePaymentId;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }else{
            
        }
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableView.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indentifer=@"indentifer";
    QuickPayCell * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
    if (!cell)
    {
        cell=[[QuickPayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    BankInfoModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankInfoModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
    AddBankCardVC *VC = [[AddBankCardVC alloc]init];
    VC.bankModel = model;
    VC.totalAmount = _totalAmount;
    VC.mergePaymentId = _mergePaymentId;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 添加快捷支付
-(void)addQuickPay
{
    ChooseBankVC * vc = [[ChooseBankVC alloc]init];
    vc.mergePaymentId = _mergePaymentId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
