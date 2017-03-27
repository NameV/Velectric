//
//  ChooseBankVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/16.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "ChooseBankVC.h"
#import "QuickPayCell.h"
#import "BankInfoModel.h"
#import "AddBankCardVC.h"
#import "BindingBankWebViewVC.h"

@interface ChooseBankVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) BaseTableView * tableView;

@end

@implementation ChooseBankVC

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
    self.navTitle = @"绑定银行卡并支付";
    
    //创建UI
    [self creatUI];
    //请求数据
    [self requestBankListInfo];
}

#pragma mark - 创建UI
-(void)creatUI
{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - 请求数据
-(void)requestBankListInfo
{
    NSArray * keyList = @[@"ICBC-D",
                          @"ICBC-C",
                          @"CEB-D",
                          @"CEB-C",
                          @"HXB-D",
                          @"HXB-C",
                          @"CCB-D",
                          @"CCB-C",
                          @"BOCOM-D",
                          @"CMBC-D",
                          @"CMBC-C",
                          @"PAB-D",
                          @"PAB-C",
                          @"SPDB-D",
                          @"SPDB-C",
                          @"BOS-D",
                          @"BOS-C",
                          @"CIB-D",
                          @"CIB-C",
                          @"BOC-D",
                          @"BOC-C",
                          @"PSBC-D",
                          @"CNCB-D",
                          @"CNCB-C",
                          @"GDRCU-D",
                          @"HZCB-D",
                          @"HZCB-C",
                          @"JSBK-D",
                          @"JSBK-C",
                          @"SZRCU-D",
                          @"CBHB-D",
                          @"CBHB-C",
                          @"BCCB-C",
                          @"GDB-C",
                          @"HSCB-C",
                          @"JSBK-C",
                          @"BRCB-C",
                          @"CQCBANK-C",];
    NSArray * nameList = @[@"工商银行   借记卡",
                           @"工商银行   贷记卡",
                           @"光大银行   借记卡",
                           @"光大银行   贷记卡",
                           @"华夏银行   借记卡",
                           @"华夏银行   贷记卡",
                           @"建设银行   借记卡",
                           @"建设银行   贷记卡",
                           @"交通银行   借记卡",
                           @"民生银行   借记卡",
                           @"民生银行   贷记卡",
                           @"平安银行   借记卡",
                           @"平安银行   贷记卡",
                           @"浦发银行   借记卡",
                           @"浦发银行   贷记卡",
                           @"上海银行   借记卡",
                           @"上海银行   贷记卡",
                           @"兴业银行   借记卡",
                           @"兴业银行   贷记卡",
                           @"中国银行   借记卡",
                           @"中国银行   贷记卡",
                           @"中国邮政储蓄银行   借记卡",
                           @"中信银行   借记卡",
                           @"中信银行   贷记卡",
                           @"广东农村信用社   借记卡",
                           @"杭州银行   借记卡",
                           @"杭州银行   贷记卡",
                           @"江苏银行   借记卡",
                           @"江苏银行   贷记卡",
                           @"深圳农村商业银行   借记卡",
                           @"渤海银行   借记卡",
                           @"渤海银行   贷记卡",
                           @"北京银行   贷记卡",
                           @"广发银行   贷记卡",
                           @"徽商银行   贷记卡",
                           @"上海农商行   贷记卡",
                           @"北京农商行   贷记卡",
                           @"重庆银行   贷记卡",];
    for (int i=0; i<keyList.count; i++) {
        BankInfoModel * model = [[BankInfoModel alloc]init];
        model.plantBankId = [keyList objectAtIndex:i];
        model.plantBankName = [nameList objectAtIndex:i];
        model.logoUrl = @"yinlian";
        [_tableView.dataArray addObject:model];
    }
    [_tableView reloadData];
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
    cell.infoModel = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankInfoModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
    BindingBankWebViewVC * vc = [[BindingBankWebViewVC alloc]init];
    vc.mergePaymentId = _mergePaymentId;
    vc.plantBankId = model.plantBankId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
