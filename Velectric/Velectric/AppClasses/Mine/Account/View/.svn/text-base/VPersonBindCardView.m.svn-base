//
//  VPersonBindCardView.m
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VPersonBindCardView.h"
#import "VInputCellView.h"
#import "VSelectCellView.h"

@interface VPersonBindCardView ()

@end

@implementation VPersonBindCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - setupViews

- (void)setupViews {
    
    static CGFloat kHeight = 50.0f;
    
    [self addSubview:self.nameView];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(kHeight);
    }];
    
    [self.nameView.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameView.mas_left).offset(125);
        make.centerY.equalTo(self.nameView.label.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH-125-30);
    }];
    
    [self.nameView addSubview:self.explainBtn];//持卡人说明
    [self.explainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nameView.mas_right).offset(-10);
        make.centerY.equalTo(self.nameView.mas_centerY);
    }];
    
    [self addSubview:self.idCardTypeView];
    [self.idCardTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.nameView);
        make.top.equalTo(self.nameView.mas_bottom);
    }];
    
    [self addSubview:self.idCardNumView];
    [self.idCardNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.nameView);
        make.top.equalTo(self.idCardTypeView.mas_bottom);
    }];
    
    [self addSubview:self.openBankView];
    [self.openBankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.nameView);
        make.top.equalTo(self.idCardNumView.mas_bottom);
    }];
    
    [self addSubview:self.cardNumView];
    [self.cardNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.nameView);
        make.top.equalTo(self.openBankView.mas_bottom);
    }];
    
    [self addSubview:self.phoneNumView];
    [self.phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self.nameView);
        make.top.equalTo(self.cardNumView.mas_bottom);
    }];
    
    [self.phoneNumView.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.phoneNumView);
        make.height.mas_equalTo(1);
    }];
    
    //持卡人说明
    [self addSubview:self.warningTitleLabel];
    [self.warningTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.phoneNumView.mas_bottom).offset(15);
    }];
    
    [self addSubview:self.warningContentLabel];
    [self.warningContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.warningTitleLabel.mas_left);
        make.top.equalTo(self.warningTitleLabel.mas_bottom).offset(22);
        make.width.mas_equalTo(SCREEN_WIDTH-20);
    }];
    
}



#pragma mark - getter

- (VInputCellView *)nameView {
    if (!_nameView) {
        _nameView = [[VInputCellView alloc]initWithTitle:@"姓名" placeholder:@"请输入姓名"];
    }
    return _nameView;
}

- (VSelectCellView *)idCardTypeView {
    if (!_idCardTypeView) {
        _idCardTypeView = [[VSelectCellView alloc]initWithTitle:@"证件类型"];
    }
    return _idCardTypeView;
}

- (VInputCellView *)idCardNumView {
    if (!_idCardNumView) {
        _idCardNumView = [[VInputCellView alloc]initWithTitle:@"证件号码" placeholder:@"请输入证件号码"];
    }
    return _idCardNumView;
}

- (VSelectCellView *)openBankView {
    if (!_openBankView) {
        _openBankView = [[VSelectCellView alloc]initWithTitle:@"开户银行"];
    }
    return _openBankView;
}

- (VInputCellView *)cardNumView {
    if (!_cardNumView) {
        _cardNumView = [[VInputCellView alloc]initWithTitle:@"储蓄卡号" placeholder:@"请输入储蓄卡号"];
        _cardNumView.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _cardNumView;
}

- (VInputCellView *)phoneNumView {
    if (!_phoneNumView) {
        _phoneNumView = [[VInputCellView alloc]initWithTitle:@"预留手机" placeholder:@"请输入手机号"];
        _phoneNumView.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneNumView;
}


- (UIButton *)explainBtn {
    if (!_explainBtn) {
        _explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_explainBtn setBackgroundImage:[UIImage imageNamed:@"叹号"] forState:UIControlStateNormal];
    }
    return _explainBtn;
}

- (UILabel *)warningTitleLabel {
    if (!_warningTitleLabel) {
        _warningTitleLabel = [UILabel labelShortWithColor:V_BLACK_COLOR font:15];
        _warningTitleLabel.text = @"《个人账户》绑卡须知：";
    }
    return _warningTitleLabel;
}

- (UILabel *)warningContentLabel {
    if (!_warningContentLabel) {
        _warningContentLabel = [UILabel labelLongWithColor:V_GRAY_COLOR font:14];
        _warningContentLabel.text = @"1.请仔细核对并录入账号、开户银行、姓名等信息；确保录入信息无误；\n2.在录入过程中避免出现空格、字符、少字、错字等问题；务必仔细检查核对；\n3.确保填写的手机号为本人持有并且为可用状态；";
    }
    return _warningContentLabel;
}

@end
