//
//  VMyAccountView.m
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VMyAccountView.h"
#import "VMyCardModel.h"

@interface VMyAccountView ()

@property (nonatomic, strong) UILabel *accountLabel;            //余额
@property (nonatomic, strong) UILabel *moneyIconLabel;          //￥
@property (nonatomic, strong) UIView *line;                     //横线

@end

@implementation VMyAccountView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

#pragma mark - setupViews

- (void)setupViews {
    [self addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(40);
    }];
    
    [self addSubview:self.accountNumLabel];
    [self.accountNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.accountLabel.mas_centerX);
        make.top.equalTo(self.accountLabel.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.moneyIconLabel];
    [self.moneyIconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.accountNumLabel.mas_left).offset(-5);
        make.bottom.equalTo(self.accountNumLabel.mas_bottom).offset(-2);
    }];
    
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(18);
        make.right.equalTo(self.mas_right).offset(-18);
        make.top.equalTo(self.accountNumLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(1.0);
    }];
    
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.line.mas_bottom).offset(32);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-36,126.0));
    }];
    
    [self.bgImageView addSubview:self.bankIcon];
    [self.bankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView.mas_left).offset(19);
        make.centerY.equalTo(self.bgImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
//-------------------------------有银行icon的时候的布局代码 begin------------------------------
    
//    [self.bgImageView addSubview:self.bankNameLabel];
//    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.bankIcon.mas_right).offset(20);
//        make.top.equalTo(self.bgImageView.mas_top).offset(44);
//    }];
    
//    [self.bgImageView addSubview:self.bankTypeLabel];
//    [self.bankTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.bankNameLabel.mas_right).offset(13);
//        make.centerY.equalTo(self.bankNameLabel.mas_centerY);
//    }];
    
//    [self.bgImageView addSubview:self.bankNumLabel];
//    [self.bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.bankNameLabel.mas_left);
//        make.bottom.equalTo(self.bgImageView.mas_bottom).offset(-44);
//    }];
    
//-------------------------------有银行icon的时候的布局代码 end------------------------------
    

//-------------------------------没有银行icon的时候的布局代码 begin------------------------------
    
    [self.bgImageView addSubview:self.bankNameLabel];
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_top).offset(40);
        make.centerX.equalTo(self.bgImageView.mas_centerX);
    }];
    
    [self.bgImageView addSubview:self.bankNumLabel];
    [self.bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bankNameLabel.mas_centerX);
        make.bottom.equalTo(self.bgImageView.mas_bottom).offset(-40);
    }];
    
//-------------------------------没有银行icon的时候的布局代码 end------------------------------
    
    [self addSubview:self.getMoneyBtn];
    [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView.mas_left);
        make.right.equalTo(self.bgImageView.mas_right);
        make.top.equalTo(self.bgImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [self addSubview:self.bindCardBtn];
    [self.bindCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    //默认隐藏
    self.bgImageView.hidden = YES;
    self.getMoneyBtn.hidden = YES;
    
    //现在没有银行图片，将银行icon隐藏
    self.bankIcon.hidden = YES;
}

#pragma mark - setter

- (void)setCardModel:(VMyCardModel *)cardModel {
    _cardModel = cardModel;
    
    if (cardModel.binded) {
        
        self.bgImageView.hidden = NO;
        self.getMoneyBtn.hidden = NO;
        [self.bindCardBtn setTitle:@"解除绑定银行卡" forState:UIControlStateNormal];
        
        self.bankNameLabel.text = cardModel.bankName;
        self.bankNumLabel.text = [NSString stringWithFormat:@"尾号 %@",cardModel.account];
        
    }else{
        self.bgImageView.hidden = YES;
        self.getMoneyBtn.hidden = YES;
        [self.bindCardBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
    }
}

#pragma mark - getter

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [UILabel labelShortWithColor:[UIColor lightGrayColor] font:17];
        _accountLabel.text = @"余额";
        _accountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _accountLabel;
}

- (UILabel *)accountNumLabel {
    if (!_accountNumLabel) {
        _accountNumLabel = [UILabel labelShortWithColor:[UIColor ylColorWithHexString:@"#f44336"] font:23];
        _accountNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _accountNumLabel;
}

- (UILabel *)moneyIconLabel {
    if (!_moneyIconLabel) {
        _moneyIconLabel = [UILabel labelShortWithColor:[UIColor lightGrayColor] font:12];
        _moneyIconLabel.textAlignment = NSTextAlignmentCenter;
        _moneyIconLabel.text = @"￥";
    }
    return _moneyIconLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor ylColorWithHexString:@"#dddddd"];
    }
    return _line;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.clipsToBounds = YES;
        _bgImageView.layer.cornerRadius = 3;
//        _bgImageView.backgroundColor = [UIColor ylColorWithHexString:@"#f2b602"];
        _bgImageView.image = [UIImage imageNamed:@"圆角矩形-2"];
    }
    return _bgImageView;
}

- (UIImageView *)bankIcon {
    if (!_bankIcon) {
        _bankIcon = [[UIImageView alloc]init];
        _bankIcon.clipsToBounds = YES;
        _bankIcon.layer.cornerRadius = 30;
        _bankIcon.backgroundColor = [UIColor whiteColor];
    }
    return _bankIcon;
}

- (UILabel *)bankNameLabel {
    if (!_bankNameLabel) {
        _bankNameLabel = [UILabel labelShortWithColor:[UIColor whiteColor] font:18];
    }
    return _bankNameLabel;
}

- (UILabel *)bankTypeLabel {
    if (!_bankTypeLabel) {
        _bankTypeLabel = [UILabel labelShortWithColor:[UIColor whiteColor] font:12];
    }
    return _bankTypeLabel;
}

- (UILabel *)bankNumLabel {
    if (!_bankNumLabel) {
        _bankNumLabel = [UILabel labelShortWithColor:[UIColor whiteColor] font:12];
    }
    return _bankNumLabel;
}

-(UIButton *)getMoneyBtn {
    if (!_getMoneyBtn) {
        _getMoneyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _getMoneyBtn.clipsToBounds = YES;
        _getMoneyBtn.layer.cornerRadius = 3;
        _getMoneyBtn.layer.borderColor = [UIColor ylColorWithHexString:@"#f2b602"].CGColor;
        _getMoneyBtn.layer.borderWidth = 1;
        [_getMoneyBtn setTitleColor:[UIColor ylColorWithHexString:@"#f2b602"] forState:UIControlStateNormal];
        [_getMoneyBtn setTitle:@"提现" forState:UIControlStateNormal];
    }
    return _getMoneyBtn;
}

-(UIButton *)bindCardBtn {
    if (!_bindCardBtn) {
        _bindCardBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_bindCardBtn setBackgroundColor:[UIColor ylColorWithHexString:@"#f2b602"]];
        [_bindCardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _bindCardBtn;
}


@end
