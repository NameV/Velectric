//
//  VScanHistoryCell.m
//  Velectric
//
//  Created by LYL on 2017/3/2.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VScanHistoryCell.h"
#import "VScanHistoryModel.h"

@interface VScanHistoryCell ()

@property (nonatomic, strong) UIImageView *selectImage;//选中图片
@property (nonatomic, strong) UIImageView *iconImage;//图片
@property (nonatomic, strong) UILabel *titleLabel;  //标题
@property (nonatomic, strong) UILabel *countLable;  //收藏数
@property (nonatomic, strong) UILabel *priceLabel;  //价格
@property (nonatomic, strong) UIButton *cancelButton;//取消收藏

@end

@implementation VScanHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    static CGFloat kPadding = 8.0f;
    
    [self.contentView addSubview:self.selectImage];
    [self.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kPadding);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    
    [self.contentView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectImage.mas_right).offset(kPadding);
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
    
    [self.contentView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.priceLabel.mas_bottom);
        make.width.mas_equalTo(80);
    }];
}


#pragma mark - setter

- (void)setModel:(VScanHistoryModel *)model {
    _model = model;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLabel.text = model.name;
    self.countLable.text = [NSString stringWithFormat:@"规格%@",model.code ? model.code : @""];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.price floatValue]];
}

//图片是否隐藏
- (void)setImageHidden:(BOOL )imageHidden {
    _imageHidden = imageHidden;
    if (_imageHidden == YES) {
        self.selectImage.hidden = YES;
        
    }else{
        self.selectImage.hidden = NO;
    }
}

//图片显示什么图片
- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.selectImage.image = [UIImage imageNamed:@"选中"];
    }else{
        self.selectImage.image = [UIImage imageNamed:@"未选中"];
    }
}


#pragma mark - getter

- (UIImageView *)selectImage {
    if (!_selectImage) {
        _selectImage = [[UIImageView alloc]init];
    }
    return _selectImage;
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

    // Configure the view for the selected state
}

@end
