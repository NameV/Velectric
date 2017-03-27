//
//  VInputCellView.m
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VInputCellView.h"

@implementation VInputCellView{
    NSString *_title;
    NSString *_placeholder;
}


- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder  {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _title = title;
        _placeholder = placeholder;
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
    
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(125);
        make.centerY.equalTo(self.label.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH-125-10);
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

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = [UIColor blackColor];
        _textField.placeholder = _placeholder;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor ylColorWithHexString:@"#e8e8e8"];
    }
    return _bottomLine;
}

@end
