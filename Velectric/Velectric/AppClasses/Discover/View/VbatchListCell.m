//
//  VbatchListCell.m
//  Velectric
//
//  Created by MacPro04967 on 2017/2/14.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VbatchListCell.h"

@interface VbatchListCell ()

@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UILabel *contentLabel;//内容
//@property (nonatomic, strong) UIView *topLine;//上面那条线
//@property (nonatomic, strong) UIView *bottomLine;//下面那条线
//@property (nonatomic, strong) UIView *footerView;//中间的空白区域

@end

@implementation VbatchListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    static CGFloat kPadding = 15.0f;
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kPadding);
        make.top.equalTo(self.contentView.mas_top).offset(kPadding);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_left);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(kPadding);
        make.right.equalTo(self.contentView.mas_right).offset(-kPadding);
    }];
    
    [self.contentView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentLabel.mas_right);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kPadding);
    }];
    
    [self.contentView addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deleteBtn.mas_left).offset(-kPadding);
        make.centerY.equalTo(self.deleteBtn.mas_centerY);
    }];
    
//    [self.contentView addSubview:self.topLine];
//    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left);
//        make.right.equalTo(self.contentView.mas_right);
//        make.height.equalTo(@1);
//        make.top.equalTo(self.contentLabel.mas_bottom).offset(kPadding);
//    }];
//
//    [self.contentView addSubview:self.footerView];
//    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left);
//        make.right.equalTo(self.contentView.mas_right);
//        make.top.equalTo(self.topLine.mas_bottom);
//        make.height.equalTo(@10);
//    }];
//
//    [self.contentView addSubview:self.bottomLine];
//    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left);
//        make.right.equalTo(self.contentView.mas_right);
//        make.height.equalTo(@1);
//        make.top.equalTo(self.footerView.mas_bottom);
//    }];
    
}

#pragma mark - setter

- (void)setModel:(VBatchCellModel *)model {
    _model = model;
    
    self.timeLabel.text = model.createDate;
    self.contentLabel.text = model.context;
}

#pragma mark - getter

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel  = [UILabel labelShortWithColor:[UIColor blackColor] font:10];
        _timeLabel.userInteractionEnabled = YES;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelLongWithColor:[UIColor blackColor] font:15];
        _contentLabel.userInteractionEnabled = YES;
    }
    return _contentLabel;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setBackgroundImage:[UIImage imageNamed:@"addressedit"] forState:UIControlStateNormal];
    }
    return _editBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"addressdelete"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

//- (UIView *)topLine {
//    if (!_topLine) {
//        _topLine = [[UIView alloc]init];
//        _topLine.backgroundColor = [UIColor blackColor];
//    }
//    return _topLine;
//}
//
//- (UIView *)bottomLine {
//    if (!_bottomLine) {
//        _bottomLine = [[UIView alloc]init];
//        _bottomLine.backgroundColor = [UIColor blackColor];
//    }
//    return _bottomLine;
//}
//
//- (UIView *)footerView {
//    if (!_footerView) {
//        _footerView = [UIView new];
//        _footerView.backgroundColor = [UIColor orangeColor];
//    }
//    return _footerView;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
