//
//  VGetMoneyView.h
//  Velectric
//
//  Created by LYL on 2017/2/24.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VInputCellView.h"
#import "VGetMoneyModel.h"

@interface VGetMoneyView : UIView

@property (nonatomic, strong) VInputCellView *AccountNumView;   //提现卡号
@property (nonatomic, strong) VInputCellView *canGetMoneyView;  //可提余额
@property (nonatomic, strong) VInputCellView *getMoneyView;     //提现金额
@property (nonatomic, strong) VInputCellView *verifyCodeView;   //验证码
@property (nonatomic, strong) UIButton *getVerifyCodeBtn;       //获取验证码
@property (nonatomic, strong) UIButton *getMoneyBtn;            //提现button

@property (nonatomic, strong) VGetMoneyModel *model;


@end
