//
//  VSearchFootPrintCell.m
//  Velectric
//
//  Created by LYL on 2017/3/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VSearchFootPrintCell.h"

@interface VSearchFootPrintCell ()




@end

@implementation VSearchFootPrintCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    static CGFloat kPadding = 8.0f;
    
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(kPadding);
        make.right.equalTo(self.timeLabel.mas_left).offset(-kPadding);
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-kPadding);
        make.width.mas_equalTo(90);
    }];
    
}


#pragma mark - setter

- (void)setModel:(VScanHistoryModel *)model {
    _model = model;
    self.titleLabel.text = model.name;
    self.timeLabel.text = model.createTimeStr;
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelShortWithColor:V_GRAY_COLOR font:15];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelShortWithColor:V_GRAY_COLOR font:14];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}


@end
