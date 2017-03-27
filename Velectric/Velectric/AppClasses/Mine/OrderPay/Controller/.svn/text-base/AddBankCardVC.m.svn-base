//
//  AddBankCardVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/16.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "AddBankCardVC.h"

@interface AddBankCardVC ()

//验证码
@property (strong,nonatomic) UITextField * codeTextF;

@end

@implementation AddBankCardVC

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
}
#pragma mark - 创建UI
-(void)creatUI
{
    NSString * bankName = @"招商银行";
    NSString * cardType = @"借记卡";
    
    //顶部背景view
    UIView * topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    topBgView.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:topBgView];
    
    //银行logo
    UIImageView * logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(18, 18, 54, 54)];
    logoImage.backgroundColor = COLOR_F2B602;
    [self.view addSubview:logoImage];
    
    //银行名称
    UILabel * backNameLab = [[UILabel alloc]initWithFrame:CGRectMake(logoImage.right + 24, 20, 200, 25)];
    backNameLab.textColor = COLOR_666666;
    backNameLab.font = Font_1_F18;
    NSString * labText = [NSString stringWithFormat:@"%@  %@",bankName,cardType];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:labText];
    [attrString addAttribute:NSFontAttributeName value:Font_1_F12 range:[labText rangeOfString:cardType]];
    [attrString addAttribute:NSForegroundColorAttributeName value:COLOR_666666 range:[labText rangeOfString:cardType]];
    backNameLab.attributedText = attrString;
    [self.view addSubview:backNameLab];
    
    //尾号
    UILabel * numberLab = [[UILabel alloc]initWithFrame:CGRectMake(backNameLab.left, backNameLab.bottom, 100, backNameLab.height)];
    numberLab.textColor = COLOR_999999;
    numberLab.font = Font_1_F15;
    numberLab.text = [NSString stringWithFormat:@"尾号  %@",@"1021"];
    [self.view addSubview:numberLab];
    
    //输入框背景view
    UIView * inputBgView = [[UIView alloc]initWithFrame:CGRectMake(0, topBgView.bottom + 10, SCREEN_WIDTH, 70)];
    inputBgView.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:inputBgView];
    
    //获取按钮
    UIButton * getCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 18 - 85, 20, 85, 30)];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:COLOR_3E3A39 forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    getCodeBtn.titleLabel.font = Font_1_F14;
    getCodeBtn.layer.borderWidth = 0.3;
    getCodeBtn.layer.borderColor = COLOR_DDDDDD.CGColor;
    [inputBgView addSubview:getCodeBtn];
    
    //验证码
    _codeTextF = [[UITextField alloc]initWithFrame:CGRectMake(logoImage.left, 14, getCodeBtn.left - 18 - 29, 42)];
    _codeTextF.placeholder = @"请输入验证码";
    _codeTextF.font = Font_1_F15;
    _codeTextF.textColor = COLOR_333333;
    _codeTextF.textAlignment = NSTextAlignmentCenter;
    _codeTextF.backgroundColor = COLOR_F7F7F7;
    [inputBgView addSubview:_codeTextF];
    
    //立即支付按钮
    UIImage * payImg = [UIImage imageNamed:@"lijizhifu"];
    UIButton * payBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - payImg.size.width)/2, inputBgView.bottom + 110, payImg.size.width, payImg.size.height)];
    [payBtn setImage:payImg forState:UIControlStateNormal];
    [payBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [payBtn addTarget:self action:@selector(doPayNow) forControlEvents:UIControlEventTouchUpInside];
    payBtn.titleLabel.font = Font_1_F14;
    [self.view addSubview:payBtn];
}

#pragma mark - 获取验证码
-(void)getCodeAction
{
    
}

#pragma mark - 立即支付
-(void)doPayNow
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
