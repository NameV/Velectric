//
//  VPopView.m
//  Velectric
//
//  Created by LYL on 2017/2/28.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VPopView.h"

#define Vpalcehoder @"请输入异常原因"
static NSInteger maxTextNum = 200;

@interface VPopView ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *kTitleLabel;
@property (nonatomic, strong) UIButton *certenButton;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) UIView *midLine;

@property (nonatomic, strong) UIImageView *starImageView;//星星
@property (nonatomic, strong) UILabel *reasonTypeLabel;//问题类型
@property (nonatomic, strong) UIButton *qualityProblemBtn;//质量问题
@property (nonatomic, strong) UIButton *missingPartsBtn;//缺少配件
@property (nonatomic, strong) UIView *seporateView;//分割线
@property (nonatomic, strong) UILabel *reasonLabel;//原因描述
@property (nonatomic, strong) UITextView *textView;//原因描述textview
@property (nonatomic, strong) UILabel *wordNumberLabel;//剩余字数label

@property (nonatomic, copy) NSString *contentString;//输入的内容

@end

@implementation VPopView{
    BOOL _icon;
    NSString *_title;
    NSString *_desc;
    NSString *_buttonTitle;
    NSString *_cancelTitle;
}

- (instancetype)initTitle:(NSString *)title
              certenBlock:(VPopViewBlock)block {
    self = [super init];
    if (self) {
        _icon = NO;
        _title = title;
        _buttonTitle = @"提交";
        _cancelTitle = @"取消";
        _block = block;
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
    [self addSubview:self.kTitleLabel];
    [self addSubview:self.certenButton];
    [self addSubview:self.cancelBtn];
}

- (void)updateViews {
    
    static CGFloat kPadding = 17.0f;
    
    [self.kTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(kPadding);//没有图片从顶部算
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
    

#pragma mark ------------------中间view
    static CGFloat kPadding0 = 5;
    static CGFloat kPadding1 = 10;
    static CGFloat kPadding2 = 15;
    
    [self addSubview:self.starImageView];
    [self.starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kPadding1);
        make.top.equalTo(self.kTitleLabel.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.reasonTypeLabel];
    [self.reasonTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starImageView.mas_right).offset(kPadding0);
        make.centerY.equalTo(self.starImageView.mas_centerY);
    }];
    
    [self addSubview:self.qualityProblemBtn];
    [self.qualityProblemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.reasonTypeLabel.mas_bottom).offset(kPadding2);
    }];
    
    [self addSubview:self.missingPartsBtn];
    [self.missingPartsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.qualityProblemBtn.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-kPadding2);
    }];
    
    [self addSubview:self.seporateView];
    [self.seporateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.qualityProblemBtn.mas_bottom).offset(kPadding2);
        make.height.mas_equalTo(12);
    }];
    
    [self addSubview:self.reasonLabel];
    [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reasonTypeLabel.mas_left);
        make.top.equalTo(self.seporateView.mas_bottom).offset(kPadding2);
    }];
    
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kPadding1);
        make.right.equalTo(self.mas_right).offset(-kPadding1);
        make.top.equalTo(self.reasonLabel.mas_bottom).offset(kPadding1);
        make.height.mas_equalTo(140);
    }];
    
    [self.textView addSubview:self.wordNumberLabel];
    [self.wordNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView.mas_left).offset(SCREEN_WIDTH-20-90);
        make.top.equalTo(self.textView.mas_top).offset(120);
    }];
    
#pragma mark - ---- -- - - - - 确定取消
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(kPadding);
        make.height.mas_equalTo(45);
        make.right.equalTo(self);
        make.left.equalTo(self.certenButton.mas_right);
    }];
    
    
    [self.certenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( self.textView.mas_bottom).offset(kPadding);
        make.height.mas_equalTo(45);
        make.left.equalTo(self);
        make.right.equalTo(self.cancelBtn.mas_left);
        make.width.equalTo(self.cancelBtn.mas_width);
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

- (void)missingPartsBtnAction:(UIButton *)btn {
//    if (!self.missingPartsBtn.selected == YES && self.qualityProblemBtn.selected == YES) {
//        self.qualityProblemBtn.selected = NO;;
//    }
    if (btn.selected == YES) {
        return;
    }
    self.missingPartsBtn.selected = !self.missingPartsBtn.selected;
    self.qualityProblemBtn.selected = !self.missingPartsBtn.selected;
    
}

- (void)qualityProblemBtnAction:(UIButton *)btn {
//    if (!self.qualityProblemBtn.selected == YES && self.missingPartsBtn.selected == YES) {
//        self.missingPartsBtn.selected = NO;
//    }
    if (btn.selected == YES) {
        return;
    }
    self.qualityProblemBtn.selected = !self.qualityProblemBtn.selected;
    self.missingPartsBtn.selected = !self.qualityProblemBtn.selected;
}


#pragma mark - action

- (void)certenButtonAction:(id)sender {
    
    NSString *contentStr ;
    if ([self.wordNumberLabel.text isEqualToString:@"200/200"]) {
        contentStr = @"";
    }else {
        contentStr = self.textView.text;
    }
    [self hide];//隐藏
    
    NSInteger reasonType = 0;//2:质量问题  3:缺少配件
    if (self.qualityProblemBtn.selected == YES) {
        reasonType = 2;
    }else if (self.missingPartsBtn.selected == YES) {
        reasonType = 3;
    }
    if (_block) {
        _block(contentStr,reasonType);
    }
}

- (void)cancelButtonAction:(id)sender {
    [self hide];//隐藏
}

#pragma mark - textview delegate

//placeholder
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = Vpalcehoder;
        _textView.textColor = COLOR_999999;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:Vpalcehoder]){
        textView.text=@"";
        textView.textColor= COLOR_3E3A39;
    }
}

//限制200字符
- (void)textViewDidChange:(UITextView *)textView {
    
    self.wordNumberLabel.text = [NSString stringWithFormat:@"%lu/%lu",(maxTextNum - (textView.text.length < maxTextNum ? textView.text.length : maxTextNum)),maxTextNum];
    
    NSInteger number = [textView.text length];
    if (number >= 201) {
        textView.text = [textView.text substringToIndex:200];
        number = 201;
    }
}


#pragma mark - getter


- (UILabel *)kTitleLabel {
    if (!_kTitleLabel) {
        _kTitleLabel = [UILabel labelLongWithColor:COLOR_F2B602 font:18];
        _kTitleLabel.text = _title;
    }
    return _kTitleLabel;
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
        [_cancelBtn setBackgroundColor:COLOR_DDDDDD];
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
        _midLine.backgroundColor = V_WHITE_COLOR;
    }
    return _midLine;
}

- (UIImageView *)starImageView {
    if (!_starImageView) {
        _starImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"星"]];
    }
    return _starImageView;
}

- (UILabel *)reasonTypeLabel {
    if (!_reasonTypeLabel) {
        _reasonTypeLabel = [UILabel labelShortWithColor:V_BLACK_COLOR font:15];
        _reasonTypeLabel.text = @"原因类型";
    }
    return _reasonTypeLabel;
}

- (UIButton *)qualityProblemBtn {
    if (!_qualityProblemBtn) {
        _qualityProblemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qualityProblemBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [_qualityProblemBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_qualityProblemBtn setTitle:@"质量问题" forState:UIControlStateNormal];
        [_qualityProblemBtn setTitleColor:V_BLACK_COLOR forState:UIControlStateNormal];
        [_qualityProblemBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_qualityProblemBtn addTarget:self action:@selector(qualityProblemBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _qualityProblemBtn.selected = YES;
    }
    return _qualityProblemBtn;
}

- (UIButton *)missingPartsBtn {
    if (!_missingPartsBtn) {
        _missingPartsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_missingPartsBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        [_missingPartsBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_missingPartsBtn setTitle:@"缺少配件" forState:UIControlStateNormal];
        [_missingPartsBtn setTitleColor:V_BLACK_COLOR forState:UIControlStateNormal];
        [_missingPartsBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [_missingPartsBtn addTarget:self action:@selector(missingPartsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _missingPartsBtn.selected = NO;
    }
    return _missingPartsBtn;
}

- (UIView *)seporateView {
    if (!_seporateView) {
        _seporateView = [[UIView alloc]init];
        _seporateView.backgroundColor = [UIColor ylColorWithHexString:@"#f2f2f2"];
    }
    return _seporateView;
}

- (UILabel *)reasonLabel {
    if (!_reasonLabel) {
        _reasonLabel = [UILabel labelShortWithColor:V_BLACK_COLOR font:15];
        _reasonLabel.text = @"异常原因";
    }
    return _reasonLabel;
}

-(UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.clipsToBounds = YES;
        _textView.layer.cornerRadius = 1;
        _textView.layer.borderWidth = 1;
        _textView.delegate = self;
        _textView.text = Vpalcehoder;
        _textView.textColor = COLOR_999999;
        _textView.layer.borderColor = [UIColor ylColorWithHexString:@"#f2f2f2"].CGColor;
    }
    return _textView;
}

- (UILabel *)wordNumberLabel {
    if (!_wordNumberLabel) {
        _wordNumberLabel = [[UILabel alloc]init];
        _wordNumberLabel.textAlignment = NSTextAlignmentRight;
        _wordNumberLabel.textColor = COLOR_999999;
        _wordNumberLabel.text = @"200/200";
        _wordNumberLabel.font = [UIFont systemFontOfSize:10];
    }
    return _wordNumberLabel;
}


@end
