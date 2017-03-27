//
//  VMyAccoutVC.m
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VMyAccoutVC.h"
#import "VMyAccountView.h"
#import "VBindCardVC.h"
#import "VMyCardModel.h"
#import "MMAlertView.h"
#import "VGetMoneyVC.h"
#import "VGetMoneyRecordVC.h"       //提现记录

@interface VMyAccoutVC ()

//主界面view
@property (nonatomic, strong) VMyAccountView *mainView;

//提现记录 按钮
@property (nonatomic, strong) UIBarButtonItem *rightBtnItem;

@end

@implementation VMyAccoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfig];          //基本配置
    [self requestMyAccount];    //个人账户
    [self requestMyCard];       //银行卡
}

#pragma mark config 

- (void)baseConfig {
    self.navTitle = @"我的账户";
    self.view = self.mainView;
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
}

#pragma mark - https

//个人账户余额 请求
- (void)requestMyAccount {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName
                               };

    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:MyAccAmountURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [VJDProgressHUD showSuccessHUD:nil];
                                           if ([responseObject.allKeys containsObject:@"totalAmount"]) {
                                               if ([responseObject[@"totalAmount"] isKindOfClass:[NSString class]]) {
                                                   self.mainView.accountNumLabel.text = responseObject[@"totalAmount"];
                                               }
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
    
}

//绑定的银行卡 请求
- (void)requestMyCard {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:MyCardURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [VJDProgressHUD showSuccessHUD:nil];
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               VMyCardModel *model = [VMyCardModel yy_modelWithDictionary:responseObject];
                                               self.mainView.cardModel = model;
                                               self.mainView.bindCardBtn.userInteractionEnabled = YES;
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                           self.mainView.bindCardBtn.userInteractionEnabled = NO;
                                       }];
}

//解绑银行卡 短信请求
- (void)unbindCardSendMessageRequest {
    
    NSDictionary *paramDic = @{
                               @"mobilePhone" : self.mainView.cardModel.mobile ? self.mainView.cardModel.mobile : @""
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

//解绑银行卡 请求
- (void)unbindCardRequestWithCode:(NSString *)code {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"captcha"   :   code ? code : @""
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:UnbindCardURL
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

#pragma - mark action

//提现
- (void)getMoneyAction:(UIButton *)btn { 
    VGetMoneyVC *getMoneyVC = [[VGetMoneyVC alloc]init];
    [self.navigationController pushViewController:getMoneyVC animated:YES];
}

//绑卡、解绑
- (void)bindCardAction:(UIButton *)btn {
    
    //解除绑定银行卡
    if ([btn.titleLabel.text isEqualToString:@"解除绑定银行卡"]) {
        MMAlertView *alertView = [[MMAlertView alloc]initWithInputTitle:@"解绑银行卡" detail:@"" placeholder:@"" handler:^(NSString *text) {
            if ([text isEmpty]) {
            //                    [VJDProgressHUD showTextHUD:@"请输入"];
        }else{
            [self unbindCardRequestWithCode:text];
        }
        }];
        [alertView show];
        
    //绑定银行卡界面
    }else{
        VBindCardVC *bindVC = [[VBindCardVC alloc]init];
        [self.navigationController pushViewController:bindVC animated:YES];
    }
}

//提现记录
- (void)getMoneyRecordAction:(id)sender {
    VGetMoneyRecordVC *recordVC = [[VGetMoneyRecordVC alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

#pragma mark - getter

-(VMyAccountView *)mainView {
    if (!_mainView) {
        _mainView = [[VMyAccountView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mainView.bindCardBtn.userInteractionEnabled = NO;
        [_mainView.getMoneyBtn addTarget:self action:@selector(getMoneyAction:) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.bindCardBtn addTarget:self action:@selector(bindCardAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainView;
}

- (UIBarButtonItem *)rightBtnItem {
    if (!_rightBtnItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"提现记录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 80, 20);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(getMoneyRecordAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:button];
//        _rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(getMoneyRecordAction:)];
    }
    return _rightBtnItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
