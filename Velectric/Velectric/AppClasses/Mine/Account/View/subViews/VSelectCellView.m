//
//  VSelectCellView.m
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VSelectCellView.h"

@implementation VSelectCellView{
    NSString *_title;
}


- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _title = title;
        [self setupViews];
    }
    return self;
}

#pragma mark - setupViews

- (void)setupViews {
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self addSubview:self.valueLabel];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(125);
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self addSubview:self.rightImage];
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.label.mas_centerY);
    }];
    
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - getter

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel labelShortWithColor:[UIColor ylColorWithHexString:@"#666666"] font:15];
        _label.text = _title;
    }
    return _label;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [UILabel labelShortWithColor:[UIColor blackColor] font:15];
    }
    return _valueLabel;
}

- (UIImageView *)rightImage {
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"youjiantou"]];
    }
    return _rightImage;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor ylColorWithHexString:@"#e8e8e8"];
    }
    return _bottomLine;
}
@end
