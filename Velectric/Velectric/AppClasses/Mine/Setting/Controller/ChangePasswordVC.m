//
//  ChangePasswordVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/20.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()<UITextFieldDelegate>

//定时器
@property (strong,nonatomic) NSTimer * timer;
//时长 60秒
@property (assign,nonatomic) NSInteger timeLong;

@end

@implementation ChangePasswordVC

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navTitle = @"修改密码";
    //创建UI
    [self creatUI];
}

#pragma mark - 创建UI
-(void)creatUI
{
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, scrollView.height+1);
    [self.view addSubview:scrollView];
    
    NSArray * imageList = @[@"vjdPhone",@"vjdCode",@"newPassword",@"sureImage",];
    NSArray * placeholderList = @[@"输入手机号",@"输入验证码",@"设置新密码",@"确认新密码",];
    
    for (int i=0; i<imageList.count; i++) {
        UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(0, i*50, 200, 50)];
        textField.font = Font_1_F15;
        textField.textColor = COLOR_333333;
        textField.tag = i+1;
        textField.placeholder = [placeholderList objectAtIndex:i];
        textField.delegate = self;
        [scrollView addSubview:textField];
        
        if (i<2) {
            //手机号 显示数字键盘
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        UIImage * img = [UIImage imageNamed:[imageList objectAtIndex:i]];
        UIImageView * leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width + 20, img.size.height)];
        leftImage.image = img;
        leftImage.contentMode = UIViewContentModeScaleAspectFit;
        textField.leftView = leftImage;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        //灰色线条
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, textField.bottom-0.5, SCREEN_WIDTH - 20, 0.5)];
        lineView.backgroundColor = COLOR_DDDDDD;
        [scrollView addSubview:lineView];
        
        if (i==1) {
            UIButton * codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            codeBtn.frame = CGRectMake(SCREEN_WIDTH - 85, textField.top + 10, 75, 30);
            [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            codeBtn.titleLabel.font = Font_1_F12;
            codeBtn.backgroundColor = COLOR_F2B602;
            codeBtn.layer.cornerRadius = 2;
            codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [codeBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
            [codeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
            codeBtn.tag = 10;
            [scrollView addSubview:codeBtn];
        }
        if (i>1) {
            textField.secureTextEntry = YES;
        }
    }
    
    UIButton * loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginOutBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - 50, SCREEN_WIDTH, 50);
    [loginOutBtn setTitle:@"提交" forState:UIControlStateNormal];
    loginOutBtn.titleLabel.font = Font_1_F17;
    loginOutBtn.backgroundColor = COLOR_F2B602;
    [loginOutBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
    [loginOutBtn addTarget:self action:@selector(doCommitInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginOutBtn];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length>=11) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - 获取验证码
-(void)getVerificationCode
{
    _timeLong = 60;
    //初始化
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
    //加入主循环池中
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    //开始
    [_timer fire];
    
    UITextField * phoneTextF = [self.view viewWithTag:1];
    if ([phoneTextF.text stringValidateSpaceAndNULL]) {
        [VJDProgressHUD showTextHUD:phoneTextF.placeholder];
        return;
    }
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                    @"sign":@"1",
                                    };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGetsmsVerifyCodeURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            
        }else{
            
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:error.domain];
    }];
}

#pragma mark - 倒计时
-(void)timeCountdown
{
    _timeLong --;
    UIButton * code = [self.view viewWithTag:10];
    if (_timeLong == 0) {
        code.enabled = YES;
        code.backgroundColor = COLOR_F2B602;
        [code setTitle:@"获取验证码" forState:UIControlStateNormal];
        //取消定时器
        [_timer invalidate];
        _timer = nil;
    }else{
        code.enabled = NO;
        code.backgroundColor = COLOR_E6AD02;
        NSString *strTime = [NSString stringWithFormat:@"%ld秒后再获取", _timeLong];
        [code setTitle:strTime forState:UIControlStateNormal];
    }
}

#pragma mark - 参数验证
-(BOOL)doParamsValidate
{
    UITextField * phoneTextF = [self.view viewWithTag:1];
    UITextField * codeTextF = [self.view viewWithTag:2];
    UITextField * newPassTextF = [self.view viewWithTag:3];
    UITextField * oldPassTextF = [self.view viewWithTag:4];
    
    if ([phoneTextF.text stringValidateSpaceAndNULL]) {
        [VJDProgressHUD showTextHUD:phoneTextF.placeholder];
        return NO;
    }
    if ([codeTextF.text stringValidateSpaceAndNULL]){
        [VJDProgressHUD showTextHUD:codeTextF.placeholder];
        return NO;
    }
    if ([newPassTextF.text stringValidateSpaceAndNULL]){
        [VJDProgressHUD showTextHUD:newPassTextF.placeholder];
        return NO;
    }
    if ([oldPassTextF.text stringValidateSpaceAndNULL]){
        [VJDProgressHUD showTextHUD:oldPassTextF.placeholder];
        return NO;
    }
    if (![newPassTextF.text isEqualToString:oldPassTextF.text]) {
        return NO;
    }
    return YES;
}

#pragma mark - 提交事件
-(void)doCommitInfo
{
    //参数验证
    if ([self doParamsValidate]) {
        UITextField * phoneTextF = [self.view viewWithTag:1];
        UITextField * codeTextF = [self.view viewWithTag:2];
        UITextField * newPassTextF = [self.view viewWithTag:3];
        NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,
                                        @"mobile":phoneTextF.text,
                                        @"verifyCode":codeTextF.text,
                                        @"loginPassword":newPassTextF.text,
                                        };
        VJDWeakSelf;
        [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetChangePasswordURL parameters:parameterDic success:^(NSDictionary *responseObject) {
            NSString * code = [responseObject objectForKey:@"code"];
            if ([code isEqualToString:@"RS200"]){
                [VJDProgressHUD showSuccessHUD:@"修改密码成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [VJDProgressHUD showErrorHUD:[responseObject objectForKey:@"msg"]];
            }
        } failure:^(NSError *error) {
            [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
