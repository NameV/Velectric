//
//  USPopView.m
//  Sales
//
//  Created by liuyulei on 16/7/15.
//  Copyright © 2016年 XiaoYang. All rights reserved.
//

#import "USPopView.h"

@interface USPopView ()

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *kTitleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *certenButton;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) UIView *midLine;

@end

@implementation USPopView {
    BOOL _icon;
    NSString *_title;
    NSString *_desc;
    NSString *_buttonTitle;
    NSString *_cancelTitle;
}

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static id sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[USPopView alloc] init];
    });
    return sharedInstance;
}

- (instancetype)initWithIcon:(BOOL)icon
                       title:(NSString *)title
                  descripton:(NSString *)desc
                 buttonTitle:(NSString *)buttonTitle
                 certenBlock:(USPopViewCertenBlock)certenBlock {
    self = [super init];
    if (self) {
        _icon = icon;
        _title = title;
        _desc = desc;
        _buttonTitle = buttonTitle;
        _certenBlcok = certenBlock;
        [self configParamters];
        [self configSubviews];
        [self configSubviewLayout];
    }
    return self;
}

- (instancetype)initWithDescripton:(NSString *)desc
                       certenBlock:(USPopViewCertenBlock)certenBlock {
    self = [super init];
    if (self) {
        _icon = NO;
        _title = @"温馨提示";
        _desc = desc;
        _buttonTitle = @"知道了";
        _certenBlcok = certenBlock;
        [self configParamters];
        [self configSubviews];
        [self configSubviewLayout];
    }
    return self;
}


- (instancetype)initWithIcon:(BOOL)icon
                       title:(NSString *)title
                  descripton:(NSString *)desc
                 certenTitle:(NSString *)certenTitle
                 cancelTitle:(NSString *)cancelTitle
                 certenBlock:(USPopViewCertenBlock)certenBlock {
    self = [super init];
    if (self) {
        _icon = icon;
        _title = title;
        _desc = desc;
        _buttonTitle = certenTitle;
        _cancelTitle = cancelTitle;
        _certenBlcok = certenBlock;
        [self configParamters];
        [self configSubviews];
//        [self configSubviewLayout];
        [self updateViews];
    }
    return self;
}

- (instancetype)initTitle:(NSString *)title
               descripton:(NSString *)desc
              certenBlock:(USPopViewCertenBlock)certenBlock {
    self = [super init];
    if (self) {
        _icon = NO;
        _title = title;
        _desc = desc;
        _buttonTitle = @"确定";
        _cancelTitle = @"取消";
        _certenBlcok = certenBlock;
        [self configParamters];
        [self configSubviews];
        [self updateViews];
    }
    return self;
}

- (void)configParamters {
    self.type = MMPopupTypeAlert;
    self.backgroundColor = [UIColor whiteColor];
    self.withKeyboard = NO;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 2.0;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_lessThanOrEqualTo(400);
    }];
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
}

- (void)configSubviews {
    [self addSubview:self.iconImage];
    [self addSubview:self.kTitleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.certenButton];
    [self addSubview:self.cancelBtn];
}

- (void)configSubviewLayout {
    
    static CGFloat kPadding = 17.0f;

    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(kPadding);
    }];
    
    [self.kTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_icon ? self.iconImage.mas_bottom : self.mas_top).offset(kPadding);//没有图片从顶部算
    }];
    
    [self addSubview:self.leftLine];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.kTitleLabel.mas_centerY);
        make.right.equalTo(self.kTitleLabel.mas_left).offset(-10);
        make.height.mas_equalTo(0.6);
    }];
    
    [self addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kTitleLabel.mas_right).offset(10);
        make.centerY.equalTo(self.leftLine.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(self.leftLine.mas_height);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.mas_left).offset(kPadding);
        make.right.equalTo(self.mas_right).offset(-kPadding);
        make.top.equalTo(_title ? self.kTitleLabel.mas_bottom : _icon ? self.iconImage.mas_bottom : self.mas_top).offset(kPadding);
    }];
    
    [self.certenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_desc ? self.descLabel.mas_bottom : self.kTitleLabel.mas_bottom).offset(kPadding);
        make.height.mas_equalTo(45);
        make.left.right.equalTo(self);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.certenButton.mas_bottom);
    }];
}

- (void)updateViews {
    
    static CGFloat kPadding = 17.0f;
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(kPadding);
    }];
    
    [self.kTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_icon ? self.iconImage.mas_bottom : self.mas_top).offset(kPadding);//没有图片从顶部算
    }];
    
    [self addSubview:self.leftLine];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.kTitleLabel.mas_centerY);
        make.right.equalTo(self.kTitleLabel.mas_left).offset(-10);
        make.height.mas_equalTo(0.6);
    }];
    
    [self addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kTitleLabel.mas_right).offset(10);
        make.centerY.equalTo(self.leftLine.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(self.leftLine.mas_height);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.mas_left).offset(kPadding);
        make.right.equalTo(self.mas_right).offset(-kPadding);
        make.top.equalTo(_title ? self.kTitleLabel.mas_bottom : _icon ? self.iconImage.mas_bottom : self.mas_top).offset(kPadding);
    }];
    
    [self.certenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_desc ? self.descLabel.mas_bottom : self.kTitleLabel.mas_bottom).offset(kPadding);
        make.height.mas_equalTo(45);
        make.right.equalTo(self);
        make.left.equalTo(self.cancelBtn.mas_right);
    }];
    
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_desc ? self.descLabel.mas_bottom : self.kTitleLabel.mas_bottom).offset(kPadding);
        make.height.mas_equalTo(45);
        make.left.equalTo(self);
        make.right.equalTo(self.certenButton.mas_left);
        make.width.equalTo(self.certenButton.mas_width);
    }];
    
    [self addSubview:self.midLine];
    [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.equalTo(self.certenButton.mas_height);
        make.top.equalTo(self.certenButton.mas_top);
        make.width.mas_equalTo(1);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.certenButton.mas_bottom);
    }];
    
}

#pragma mark - action

- (void)certenButtonAction:(id)sender {
    [self hide];//隐藏
    if (_certenBlcok) {
        _certenBlcok();
    }
}

- (void)cancelButtonAction:(id)sender {
    [self hide];//隐藏
}

#pragma mark - getter

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        if (_icon) {
            _iconImage.image = [UIImage imageNamed:@"异常信息"];
        }
    }
    return _iconImage;
}

- (UILabel *)kTitleLabel {
    if (!_kTitleLabel) {
        _kTitleLabel = [UILabel labelLongWithColor:COLOR_F2B602 font:18];
        _kTitleLabel.text = _title;
    }
    return _kTitleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel  = [UILabel labelLongWithColor:V_GRAY_COLOR font:14];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.text = _desc;
    }
    return _descLabel;
}

- (UIButton *)certenButton {
    if (!_certenButton) {
        _certenButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_certenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_certenButton setTitle:_buttonTitle forState:UIControlStateNormal];
        [_certenButton setBackgroundColor:COLOR_F2B602];
        [_certenButton addTarget:self action:@selector(certenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _certenButton;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:V_LIGHTGRAY_COLOR];
        [_cancelBtn addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)leftLine {
    if (!_leftLine) {
        _leftLine = [UIView new];
        _leftLine.backgroundColor = V_LIGHTGRAY_COLOR;
    }
    return _leftLine;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        _rightLine = [UIView new];
        _rightLine.backgroundColor = V_LIGHTGRAY_COLOR;
    }
    return _rightLine;
}

- (UIView *)midLine {
    if (!_midLine) {
        _midLine = [UIView new];
        _midLine.backgroundColor = V_LIGHTGRAY_COLOR;
    }
    return _midLine;
}

@end
