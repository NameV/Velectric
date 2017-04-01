//
//  VSubDetailView.m
//  Velectric
//
//  Created by LYL on 2017/3/23.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VSubDetailView.h"

@interface VSubDetailView ()


@property (nonatomic, strong)UILabel *paramLabel;//规格/参数label

@property (nonatomic, strong)UIView *topLine;//第一条横线
@property (nonatomic, strong)UIView *firstLine;//第一条横线
@property (nonatomic, strong)UIView *leftLine;//左边的横线
@property (nonatomic, strong)UIView *rightLine;//右边的横线

/* 规格背景图 */
@property (nonatomic, strong) UIScrollView *BgView;

@end

@implementation VSubDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configViews];
    }
    return self;
}

- (void)configViews {
    
    static CGFloat kPadding = 10;
    
    [self addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kPadding);
        make.top.equalTo(self.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [self addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-18);
        make.top.equalTo(self.mas_top).offset(18);
    }];
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(14);
        make.top.equalTo(self.mas_top).offset(20);
    }];
    
    [self addSubview:self.productTypeKeyLabel];
    [self.productTypeKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_left);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
    }];
    
    [self addSubview:self.productTypeValueLabel];
    [self.productTypeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productTypeKeyLabel.mas_top);
        make.left.equalTo(self.productTypeKeyLabel.mas_right);
    }];
    
    [self addSubview:self.firstLine];
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.productTypeValueLabel.mas_bottom).offset(21);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.minKeyLabel];
    [self.minKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kPadding);
        make.top.equalTo(self.firstLine.mas_bottom).offset(27);
    }];
    
    [self addSubview:self.minValueLabel];
    [self.minValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.minKeyLabel.mas_right);
        make.top.equalTo(self.minKeyLabel.mas_top);
    }];
    
    [self addSubview:self.paramLabel];
    [self.paramLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.minKeyLabel.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.leftLine];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kPadding);
        make.right.equalTo(self.paramLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.paramLabel.mas_centerY);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.paramLabel.mas_right).offset(5);
        make.height.equalTo(self.leftLine.mas_height);
        make.centerY.equalTo(self.paramLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-kPadding);
    }];
    
    [self addSubview:self.BgView];
    [self.BgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.leftLine.mas_bottom).offset(10);
    }];
    
}

#pragma mark - setter

- (void)setGuigeString:(NSString *)guigeString {
    _guigeString = guigeString;
    [self.BgView removeAllSubviews];
    if (guigeString.length == 0 || [guigeString isEmptyString]) {
        UILabel *label = [UILabel labelShortWithColor:V_GRAY_COLOR font:14];
        label.text = @"无";
    }else{
        CGFloat height = 0 ;
        NSArray *array = [guigeString componentsSeparatedByString:@","];
        for (int i = 0; i < array.count; i++) {
            UILabel *label = [UILabel labelShortWithColor:V_GRAY_COLOR font:12];
//            label.backgroundColor = [UIColor blueColor];
            CGFloat kWidth = (SCREEN_WIDTH - 40)/3 ;
            CGFloat kHeight = 30;
            CGFloat x = i % 3 ;
            CGFloat y = i/3 ;
            label.frame = CGRectMake((kWidth + 10) * x + 10, kHeight * y , kWidth, kHeight);
            label.text = array[i];
            [self.BgView addSubview:label];
            
            height = label.frame.origin.y ;
        }
        
        self.BgView.contentSize = CGSizeMake(SCREEN_WIDTH,height + 30 * 3);
    }
}

#pragma mark - getter

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        _iconImage.backgroundColor = [UIColor orangeColor];
    }
    return _iconImage;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel labelShortWithColor:[UIColor redColor] font:18];
    }
    return _priceLabel;
}

- (UILabel *)productTypeKeyLabel {
    if (!_productTypeKeyLabel) {
        _productTypeKeyLabel = [UILabel labelShortWithColor:[UIColor ylColorWithHexString:@"#adadad"] font:12];
        _productTypeKeyLabel.text = @"产品规格/型号：";
    }
    return _productTypeKeyLabel;
}

- (UILabel *)productTypeValueLabel {
    if (!_productTypeValueLabel) {
        _productTypeValueLabel = [UILabel labelShortWithColor:[UIColor blackColor] font:12];
    }
    return _productTypeValueLabel;
}

- (UILabel *)minKeyLabel {
    if (!_minKeyLabel) {
        _minKeyLabel = [UILabel labelShortWithColor:[UIColor ylColorWithHexString:@"#adadad"] font:12];
        _minKeyLabel.text = @"最小起订量：";
    }
    return _minKeyLabel;
}

- (UILabel *)minValueLabel {
    if (!_minValueLabel) {
        _minValueLabel = [UILabel labelShortWithColor:[UIColor blackColor] font:12];
    }
    return _minValueLabel;
}

- (UILabel *)paramLabel {
    if (!_paramLabel) {
        _paramLabel = [UILabel labelShortWithColor:[UIColor ylColorWithHexString:@"#adadad"] font:12];
        _paramLabel.text = @"规格/参数";
    }
    return _paramLabel;
}

- (UIView *)firstLine {
    if (!_firstLine) {
        _firstLine = [UIView new];
        _firstLine.backgroundColor = [UIColor ylColorWithHexString:@"#adadad"];
    }
    return _firstLine;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [UIView new];
        _topLine.backgroundColor = [UIColor ylColorWithHexString:@"#adadad"];
    }
    return _topLine;
}

- (UIView *)leftLine {
    if (!_leftLine) {
        _leftLine = [UIView new];
        _leftLine.backgroundColor = [UIColor ylColorWithHexString:@"#F2B602"];
    }
    return _leftLine;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        _rightLine = [UIView new];
        _rightLine.backgroundColor = [UIColor ylColorWithHexString:@"#F2B602"];
    }
    return _rightLine;
}

- (UIScrollView *)BgView {
    if (!_BgView) {
        _BgView = [UIScrollView new];
    }
    return _BgView;
}


@end
