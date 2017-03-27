//
//  VGetMoneyView.m
//  Velectric
//
//  Created by LYL on 2017/2/24.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VGetMoneyView.h"

@implementation VGetMoneyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = V_BACKGROUND_COLOR;
        [self setupViews];
    }
    return self;
}

#pragma mark - setupview

- (void)setupViews {
    [self addSubview:self.AccountNumView];
    [self.AccountNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    [self addSubview:self.canGetMoneyView];
    [self.canGetMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.AccountNumView.mas_bottom);
        make.height.equalTo(self.AccountNumView.mas_height);
    }];
    
    [self addSubview:self.getMoneyView];
    [self.getMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.AccountNumView.mas_height);
        make.top.equalTo(self.canGetMoneyView.mas_bottom);
    }];
    
    [self addSubview:self.verifyCodeView];
    [self.verifyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.AccountNumView.mas_height);
        make.top.equalTo(self.getMoneyView.mas_bottom);
    }];
    
    [self addSubview:self.getVerifyCodeBtn];
    [self.getVerifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.verifyCodeView.mas_centerY);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.getMoneyBtn];
    [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - setter

- (void)setModel:(VGetMoneyModel *)model {
    _model = model;
    if (![model.acctId isEmpty]) {
        NSString *string = [model.acctId substringToIndex:model.acctId.length-4];
        self.AccountNumView.textField.text = [NSString stringWithFormat:@"%@****",string];
    }
    self.canGetMoneyView.textField.text = model.totalAmount;
}

#pragma mark - getter

- (VInputCellView *)AccountNumView {
    if (!_AccountNumView) {
        _AccountNumView = [[VInputCellView alloc]initWithTitle:@"提现账号" placeholder:@""];
        _AccountNumView.textField.userInteractionEnabled = NO;
        _AccountNumView.textField.textColor = V_GRAY_COLOR;
    }
    return _AccountNumView;
}

- (VInputCellView *)canGetMoneyView {
    if (!_canGetMoneyView) {
        _canGetMoneyView = [[VInputCellView alloc]initWithTitle:@"可提余额" placeholder:@""];
        _canGetMoneyView.textField.userInteractionEnabled = NO;
        _canGetMoneyView.textField.textColor = V_ORANGE_COLOR;
    }
    return _canGetMoneyView;
}

- (VInputCellView *)getMoneyView {
    if (!_getMoneyView) {
        _getMoneyView = [[VInputCellView alloc]initWithTitle:@"提现余额" placeholder:@"请输入金额"];
        _getMoneyView.textField.textColor = [UIColor ylColorWithHexString:@"#999999"];
        _getMoneyView.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _getMoneyView;
}

- (VInputCellView *)verifyCodeView {
    if (!_verifyCodeView) {
        _verifyCodeView = [[VInputCellView alloc]initWithTitle:@"验证码" placeholder:@"请输入验证码"];
        _verifyCodeView.textField.keyboardType = UIKeyboardTypeNumberPad;
        _verifyCodeView.textField.textColor = V_GRAY_COLOR;
    }
    return _verifyCodeView;
}

- (UIButton *)getVerifyCodeBtn {
    if (!_getVerifyCodeBtn) {
        _getVerifyCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_getVerifyCodeBtn setBackgroundColor:V_ORANGE_COLOR];
        [_getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerifyCodeBtn setTitleColor:V_WHITE_COLOR forState:UIControlStateNormal];
        _getVerifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _getVerifyCodeBtn.clipsToBounds = YES;
        _getVerifyCodeBtn.layer.cornerRadius = 3;
    }
    return _getVerifyCodeBtn;
}

- (UIButton *)getMoneyBtn {
    if (!_getMoneyBtn) {
        _getMoneyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_getMoneyBtn setBackgroundColor:V_ORANGE_COLOR];
        [_getMoneyBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_getMoneyBtn setTitleColor:V_WHITE_COLOR forState:UIControlStateNormal];
    }
    return _getMoneyBtn;
}

@end
