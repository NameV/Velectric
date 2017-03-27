//
//  VEmptyView.m
//  Velectric
//
//  Created by LYL on 2017/2/27.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VEmptyView.h"

@interface VEmptyView ()

@end

@implementation VEmptyView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(100);
//        make.bottom.equalTo(self.mas_bottom).offset(-283);
    }];
    
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView.mas_centerX);
        make.top.equalTo(self.imageView.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.toMainBtn];
    [self.toMainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).offset(30);
        make.centerX.equalTo(self.mas_centerX);
    }];
    self.toMainBtn.hidden = YES;
}


#pragma mark - getter

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"emptyIcon"];
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel labelShortWithColor:[UIColor ylColorWithHexString:@"#999999"] font:16];
        _label.text = @"暂无数据";
    }
    return _label;
}

- (UIButton *)toMainBtn {
    if (!_toMainBtn) {
        _toMainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toMainBtn setImage:[UIImage imageNamed:@"quguangguang"] forState:UIControlStateNormal];
    }
    return _toMainBtn;
}

@end
