//
//  VSearchHeaderView.m
//  Velectric
//
//  Created by LYL on 2017/3/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VSearchHeaderView.h"

@implementation VSearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    static CGFloat kPadding = 8.0f;
    
    [self.contentView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kPadding);
        make.centerY.equalTo(self.contentView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(kPadding);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.moreBtn setImage:[UIImage imageNamed:@"choosexia"] forState:UIControlStateNormal];
    [self.moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
}

#pragma mark - setter



#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelShortWithColor:V_BLACK_COLOR font:16];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:V_GRAY_COLOR forState:UIControlStateNormal];
        
    }
    return _moreBtn;
}

@end
