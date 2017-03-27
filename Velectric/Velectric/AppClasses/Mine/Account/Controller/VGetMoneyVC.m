//
//  VGetMoneyVC.m
//  Velectric
//
//  Created by LYL on 2017/2/24.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VGetMoneyVC.h"
#import "VGetMoneyView.h"
#import "VGetMoneyModel.h"


@interface VGetMoneyVC ()<UITextFieldDelegate>

@property (nonatomic, strong) VGetMoneyView *mainView;      //主界面
@property (nonatomic, copy) NSString *getMoneyString;       //提现金额
@property (nonatomic, copy) NSString *verifyCodeString;     //验证码

@end

@implementation VGetMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfig];
    [self showGetMoneyRequest];
    [self listRequest];
}

#pragma mark - baseMethod

- (void)baseConfig {
    self.navTitle = @"提现";
    self.view = self.mainView;
    
    [self.mainView.getVerifyCodeBtn addTarget:self action:@selector(getVerifyCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.getMoneyBtn addTarget:self action:@selector(getMoneyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - https

//提现界面接口
- (void)listRequest {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"beginDate" : @"2016-11-11",
                               @"endDate" :  @"2017-11-11",
                               @"currentPage"   : @1
                               };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:WithdrawRecordURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//提现界面接口
- (void)showGetMoneyRequest {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName
                               };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:GetShowWithdrawPATHURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               VGetMoneyModel *model = [VGetMoneyModel yy_modelWithDictionary:responseObject];
                                               self.mainView.model = model;
                                               
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//提现接口
- (void)getMoneyRequest {
    
    if ([self.getMoneyString intValue] > [self.mainView.model.totalAmount intValue]) {
        [VJDProgressHUD showTextHUD:@"您的余额不足"];
        return;
    }
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"captcha"   :   self.verifyCodeString ? self.verifyCodeString : @"",
                               @"tranAmount"    :  self.getMoneyString ? self.getMoneyString : @"",
                               @"mobilePhone"    :  self.mainView.model.mobile ? self.mainView.model.mobile : @""
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:WithdrawURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               
                                               [self.navigationController popViewControllerAnimated:YES];
                                               
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//获取短信验证码接口
- (void)getVerifyCodeRequest {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"mobilePhone"   : @"",
                               };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:SendMobileVerifyCodeURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

#pragma mark - action

//获取验证码
- (void)getVerifyCodeBtnAction:(UIButton *)btn {
    [self getVerifyCodeRequest];
}

//提现
- (void)getMoneyBtnAction:(UIButton *)btn {
    [self getMoneyRequest];
}

#pragma mark - textfield delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger wordLenght = [textField.text length] + [string length] - range.length;
    if (textField == self.mainView.getMoneyView.textField) {
        if (wordLenght > 15) {
            return NO;
        }
    }else if (textField == self.mainView.verifyCodeView.textField) {
        if (wordLenght > 10) {
            return NO;
        }
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.mainView.getMoneyView.textField) {
        self.getMoneyString = textField.text;
    }else if (textField == self.mainView.verifyCodeView.textField) {
        self.verifyCodeString = textField.text;
    }
}

#pragma mark -getter

- (VGetMoneyView *)mainView {
    if (!_mainView) {
        _mainView = [[VGetMoneyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mainView.getMoneyView.textField.delegate = self;
        _mainView.verifyCodeView.textField.delegate = self;
    }
    return _mainView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
