//
//  VProductDetailCell.m
//  Velectric
//
//  Created by LYL on 2017/2/28.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VProductDetailCell.h"

@interface VProductDetailCell ()

@property (nonatomic, strong) UIImageView *iconImage;//图片
@property (nonatomic, strong) UILabel *titleLabel;  //标题
@property (nonatomic, strong) UILabel *countLable;  //收藏数
@property (nonatomic, strong) UILabel *priceLabel;  //价格
@property (nonatomic, strong) UIView *topLine;  //价格

@end

@implementation VProductDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    static CGFloat kPadding = 8.0f;
    
    [self.contentView addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [self.contentView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kPadding);
        make.top.equalTo(self.contentView.mas_top).offset(kPadding);
        make.size.mas_equalTo(CGSizeMake(115, 100));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(kPadding);
        make.right.equalTo(self.contentView.mas_right).offset(-kPadding);
        make.top.equalTo(self.iconImage.mas_top);
    }];
    
    [self.contentView addSubview:self.countLable];
    [self.countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kPadding);
    }];
    
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countLable.mas_left);
        make.bottom.equalTo(self.iconImage.mas_bottom);
    }];
    
}

#pragma mark - action


#pragma mark - setter

- (void)setModel:(VProductDetailCellModel *)model {
    _model = model;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLabel.text = model.name;
    self.countLable.text = [NSString stringWithFormat:@"规格：%@",model.text];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.dealPrice];
}

#pragma mark - getter

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [UIView new];
        _topLine.backgroundColor = [UIColor ylColorWithHexString:@"#ebebeb"];
    }
    return _topLine;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelShortWithColor:[UIColor blackColor] font:15];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)countLable {
    if (!_countLable) {
        _countLable = [UILabel labelShortWithColor:[UIColor lightGrayColor] font:14];
    }
    return _countLable;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel labelShortWithColor:[UIColor redColor] font:16];
    }
    return _priceLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
