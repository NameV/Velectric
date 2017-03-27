//
//  VFactoryCollectCell.m
//  Velectric
//
//  Created by LYL on 2017/2/16.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VFactoryCollectCell.h"
#import "VFactoryCollectModel.h"

@interface VFactoryCollectCell ()

@property (nonatomic, strong) UILabel *titleLabel;  //标题
@property (nonatomic, strong) UILabel *countLable;  //收藏数
@property (nonatomic, strong) UIButton *cancelButton;//取消收藏

@end

@implementation VFactoryCollectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    static CGFloat maxkPadding =18.0f;
    static CGFloat minkPadding =10.0f;
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(minkPadding);
        make.top.equalTo(self.contentView.mas_top).offset(maxkPadding);
    }];
    
    [self.contentView addSubview:self.countLable];
    [self.countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-maxkPadding);
    }];
    
    [self.contentView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-minkPadding);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(80);
    }];
}

#pragma mark - action

//取消收藏
- (void)cancelCollect:(UIButton *)btn {
    self.block(self.index);
}

#pragma mark - setter

- (void)setModel:(VCollectionManuacturerModel *)model {
    _model = model;
    self.titleLabel.text = model.name;
    self.countLable.text = [NSString stringWithFormat:@"已被%@人收藏",model.times];
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelShortWithColor:[UIColor blackColor] font:15];
    }
    return _titleLabel;
}

- (UILabel *)countLable {
    if (!_countLable) {
        _countLable = [UILabel labelShortWithColor:[UIColor lightGrayColor] font:13];
    }
    return _countLable;
}

-(UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = RGBColor(245, 245, 245);
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 2;
        [button setTitle:@"取消收藏" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:RGBColor(97, 97, 97) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelCollect:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = button;
    }
    return _cancelButton;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
