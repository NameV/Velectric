//
//  ReceiptEditVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/14.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "ReceiptEditVC.h"

@interface ReceiptEditVC ()

//顶部白色背景
@property (strong,nonatomic) UIView * topBgView;

//中间白色背景
@property (strong,nonatomic) UIView * middleBgView;

//公司名称输入框
@property (strong,nonatomic) UITextField * companyNameTextF;

//底部白色背景
@property (strong,nonatomic) UIView * bottomBgView;

//发票类型 （3=不需要，1=专票 2=普票)
@property (strong,nonatomic) NSNumber * invoiceStatus;

//发票内容类型 (1个人  2单位)
@property (strong,nonatomic) NSNumber * invoiceType;

//发票内容（string）(明细  办公用品)
@property (strong,nonatomic) NSString * invoiceContent;

@end

@implementation ReceiptEditVC

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
    self.navTitle = @"发票信息";
    _invoiceStatus = [NSNumber numberWithInteger:3];//默认为3 不开票
    _invoiceType = @1;//默认为1
    _invoiceContent = @"明细";
    //创建UI
    [self creatUI];
}

#pragma mark - 创建UI
-(void)creatUI
{
    //顶部白色背景
    _topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    _topBgView.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:_topBgView];
    
    //不需要按钮
    UIButton * anNeedBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 80, 30)];
    [anNeedBtn setTitle:@"不需要" forState:UIControlStateNormal];
    [anNeedBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
    [anNeedBtn addTarget:self action:@selector(chooseNeedOrNOReceipt:) forControlEvents:UIControlEventTouchUpInside];
    anNeedBtn.titleLabel.font = Font_1_F13;
    anNeedBtn.layer.borderWidth = 0.5;
    anNeedBtn.layer.borderColor = COLOR_F2B602.CGColor;
    anNeedBtn.tag = 1;
    [_topBgView addSubview:anNeedBtn];
    
    //普票按钮
    UIButton * commonBtn = [[UIButton alloc]initWithFrame:CGRectMake(anNeedBtn.right + 10, anNeedBtn.top, anNeedBtn.width, anNeedBtn.height)];
    [commonBtn setTitle:@"普票" forState:UIControlStateNormal];
    [commonBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    [commonBtn addTarget:self action:@selector(chooseNeedOrNOReceipt:) forControlEvents:UIControlEventTouchUpInside];
    commonBtn.titleLabel.font = Font_1_F13;
    commonBtn.layer.borderWidth = 0;
    commonBtn.tag = 2;
    commonBtn.backgroundColor = COLOR_F7F7F7;
    [_topBgView addSubview:commonBtn];
    
    //中间白色背景
    _middleBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _topBgView.bottom + 10, SCREEN_WIDTH, 105)];
    _middleBgView.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:_middleBgView];
    
    //发票抬头
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(anNeedBtn.left, 0, 70, 49.5)];
    titleLab.font = Font_1_F16;
    titleLab.textColor = COLOR_333333;
    titleLab.text = @"发票抬头";
    [_middleBgView addSubview:titleLab];
    
    //灰色线条
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, titleLab.bottom, SCREEN_WIDTH, 0.5)];
    lineView1.backgroundColor = COLOR_DDDDDD;
    [_middleBgView addSubview:lineView1];
    
    //个人按钮
    UIButton * selfBtn = [[UIButton alloc]initWithFrame:CGRectMake(anNeedBtn.left, lineView1.bottom + 10, anNeedBtn.width, anNeedBtn.height)];
    [selfBtn setTitle:@"个人" forState:UIControlStateNormal];
    [selfBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    selfBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    selfBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [selfBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
    [selfBtn addTarget:self action:@selector(chooseReceiptHeader:) forControlEvents:UIControlEventTouchUpInside];
    selfBtn.titleLabel.font = Font_1_F15;
    selfBtn.tag = 1;
    [_middleBgView addSubview:selfBtn];
    
    //单位按钮
    UIButton * companyBtn = [[UIButton alloc]initWithFrame:CGRectMake(selfBtn.right + 20, selfBtn.top, selfBtn.width, selfBtn.height)];
    [companyBtn setTitle:@"单位" forState:UIControlStateNormal];
    [companyBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    [companyBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    companyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    companyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [companyBtn addTarget:self action:@selector(chooseReceiptHeader:) forControlEvents:UIControlEventTouchUpInside];
    companyBtn.titleLabel.font = Font_1_F15;
    companyBtn.tag = 2;
    [_middleBgView addSubview:companyBtn];
    
    //公司名称输入框
    _companyNameTextF = [[UITextField alloc]initWithFrame:CGRectMake(10, selfBtn.bottom + 10, SCREEN_WIDTH - 20, 25)];
    _companyNameTextF.placeholder = @"请输入单位名称";
    _companyNameTextF.font = Font_1_F15;
    _companyNameTextF.textColor = COLOR_333333;
    _companyNameTextF.hidden = YES;
    [_middleBgView addSubview:_companyNameTextF];
    
    //输入框底部线条
    UIView * textFLine = [[UIView alloc]initWithFrame:CGRectMake(0, _companyNameTextF.height - 0.5, _companyNameTextF.width, 0.5)];
    textFLine.backgroundColor = COLOR_DDDDDD;
    [_companyNameTextF addSubview:textFLine];
    
    //底部白色背景
    _bottomBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _middleBgView.bottom + 10, SCREEN_WIDTH, 135)];
    _bottomBgView.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:_bottomBgView];
    
    //发票内容
    UILabel * contentLab = [[UILabel alloc]initWithFrame:CGRectMake(anNeedBtn.left, 0, 70, 49.5)];
    contentLab.font = Font_1_F16;
    contentLab.textColor = COLOR_333333;
    contentLab.text = @"发票内容";
    [_bottomBgView addSubview:contentLab];
    
    //灰色线条
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, contentLab.bottom, SCREEN_WIDTH, 0.5)];
    lineView2.backgroundColor = COLOR_DDDDDD;
    [_bottomBgView addSubview:lineView2];
    
    //明细
    UIButton * detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(anNeedBtn.left, lineView2.bottom + 10, 100, anNeedBtn.height)];
    [detailBtn setTitle:@"明细" forState:UIControlStateNormal];
    [detailBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    [detailBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
    detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    detailBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [detailBtn addTarget:self action:@selector(chooseReceiptContent:) forControlEvents:UIControlEventTouchUpInside];
    detailBtn.titleLabel.font = Font_1_F15;
    detailBtn.tag = 1;
    [_bottomBgView addSubview:detailBtn];
    
    //办公用品
    UIButton * officeBtn = [[UIButton alloc]initWithFrame:CGRectMake(detailBtn.left, detailBtn.bottom + 5, 100, selfBtn.height)];
    [officeBtn setTitle:@"办公用品" forState:UIControlStateNormal];
    [officeBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    [officeBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    officeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    officeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [officeBtn addTarget:self action:@selector(chooseReceiptContent:) forControlEvents:UIControlEventTouchUpInside];
    officeBtn.titleLabel.font = Font_1_F15;
    officeBtn.tag = 2;
    [_bottomBgView addSubview:officeBtn];
    
    _middleBgView.hidden = YES;
    _bottomBgView.hidden = YES;
    
    //确定
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 - 64, SCREEN_WIDTH, 50)];
    sureBtn.backgroundColor = COLOR_F2B602;
    [sureBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = Font_1_F19;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
}

#pragma mark - 选择是否需要发票
-(void)chooseNeedOrNOReceipt:(UIButton *)sender
{
    UIButton * anNeedBtn = [_topBgView viewWithTag:1];
    UIButton * commonBtn = [_topBgView viewWithTag:2];
    if (sender.tag == 1) {
        anNeedBtn.layer.borderWidth = 0.5;
        anNeedBtn.layer.borderColor = COLOR_F2B602.CGColor;
        anNeedBtn.backgroundColor = CLEAR_COLOR;
        [anNeedBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        
        commonBtn.layer.borderWidth = 0;
        commonBtn.backgroundColor = COLOR_F7F7F7;
        [commonBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        
        _middleBgView.hidden = YES;
        _bottomBgView.hidden = YES;
        _invoiceStatus = [NSNumber numberWithInteger:3];
    }else{
        commonBtn.layer.borderWidth = 0.5;
        commonBtn.layer.borderColor = COLOR_F2B602.CGColor;
        commonBtn.backgroundColor = CLEAR_COLOR;
        [commonBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        
        anNeedBtn.layer.borderWidth = 0;
        anNeedBtn.backgroundColor = COLOR_F7F7F7;
        [anNeedBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        
        _middleBgView.hidden = NO;
        _bottomBgView.hidden = NO;
        _invoiceStatus = [NSNumber numberWithInteger:2];
    }
}

#pragma mark - 选择发票抬头
-(void)chooseReceiptHeader:(UIButton *)sender
{
    UIButton * selfBtn = [_middleBgView viewWithTag:1];
    UIButton * companyBtn = [_middleBgView viewWithTag:2];
    _invoiceType = [NSNumber numberWithInteger:sender.tag];
    if (sender.tag == 1) {
        [selfBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
        [companyBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
        
        _companyNameTextF.hidden = YES;
        _middleBgView.frame = CGRectMake(0, _middleBgView.top, _middleBgView.width, 105);
        _bottomBgView.frame = CGRectMake(0, _middleBgView.bottom + 10, _bottomBgView.width, _bottomBgView.height);
    }else{
        [selfBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
        [companyBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
        _companyNameTextF.hidden = NO;
        _middleBgView.frame = CGRectMake(0, _middleBgView.top, _middleBgView.width, 145);
        _bottomBgView.frame = CGRectMake(0, _middleBgView.bottom + 10, _bottomBgView.width, _bottomBgView.height);
    }
}

#pragma mark - 选择发票内容
-(void)chooseReceiptContent:(UIButton *)sender
{
    UIButton * detailBtn = [_bottomBgView viewWithTag:1];
    UIButton * officeBtn = [_bottomBgView viewWithTag:2];
    _invoiceContent = sender.titleLabel.text;
    if (sender.tag == 1) {
        [detailBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
        [officeBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    }else{
        [detailBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
        [officeBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
    }
}

#pragma mark - 确定
-(void)sureAction
{
    if ([_invoiceType intValue] == 2) {
        if ([_companyNameTextF.text stringValidateSpaceAndNULL]) {
            [VJDProgressHUD showTextHUD:_companyNameTextF.placeholder];
            return;
        }
    }
    if (_receiptBlock) {
        _receiptBlock(_invoiceStatus,_invoiceType,_invoiceContent,_companyNameTextF.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
