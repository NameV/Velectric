//
//  VGetMoneyRecordCell.m
//  Velectric
//
//  Created by LYL on 2017/2/25.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VGetMoneyRecordCell.h"

@interface VGetMoneyRecordCell ()

@property (nonatomic, strong) UILabel *timeLabel;           //时间
@property (nonatomic, strong) UILabel *recordIDLabel;       //流水号
@property (nonatomic, strong) UILabel *accountLabel;        //金额
@property (nonatomic, strong) UILabel *accountValueLabel;        //金额value
@property (nonatomic, strong) UIView *bottomLine;           //底部横线

@end

@implementation VGetMoneyRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - setupViews

- (void)setupViews {
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(20);
    }];
    
    [self.contentView addSubview:self.recordIDLabel];
    [self.recordIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_left);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
    }];
    
    [self.contentView addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_left);
        make.top.equalTo(self.recordIDLabel.mas_bottom).offset(15);
    }];
    
    [self.contentView addSubview:self.accountValueLabel];
    [self.accountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountLabel.mas_right);
        make.top.equalTo(self.accountLabel.mas_top);
    }];
    
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

#pragma mark - setter

- (void)setModel:(VGetMoneyRecordmsgModel *)model {
    _model = model;
    self.timeLabel.text = model.time;
    self.recordIDLabel.text = model.recordId;
    self.accountValueLabel.text = model.account;
}

#pragma mark - getter

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelShortWithColor:V_BLACK_COLOR font:12];
    }
    return _timeLabel;
}

-(UILabel *)recordIDLabel {
    if (!_recordIDLabel) {
        _recordIDLabel = [UILabel labelShortWithColor:V_BLACK_COLOR font:12];
    }
    return _recordIDLabel;
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [UILabel labelShortWithColor:V_WHITEGRAY_COLOR font:15];
        _accountLabel.text = @"提现金额";
    }
    return _accountLabel;
}

- (UILabel *)accountValueLabel {
    if (!_accountValueLabel) {
        _accountValueLabel = [UILabel labelShortWithColor:COLOR_F44336 font:15];
    }
    return _accountValueLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = V_BACKGROUND_COLOR;
    }
    return _bottomLine;
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
