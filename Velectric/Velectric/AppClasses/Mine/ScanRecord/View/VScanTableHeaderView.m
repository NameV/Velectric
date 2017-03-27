//
//  VScanTableHeaderView.m
//  Velectric
//
//  Created by LYL on 2017/3/2.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VScanTableHeaderView.h"

@interface VScanTableHeaderView ()



@end

@implementation VScanTableHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor ylColorWithHexString:@"#f7f7f7"];
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
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectImage.mas_right).offset(kPadding);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
}

#pragma mark - setter

- (void)setImageSelected:(BOOL)imageSelected {
    _imageSelected = imageSelected;
    if (imageSelected) {
        self.selectImage.image = [UIImage imageNamed:@"选中"];
    }else {
        self.selectImage.image = [UIImage imageNamed:@"未选中"];
    }
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelShortWithColor:V_BLACK_COLOR font:16];
    }
    return _titleLabel;
}

- (UIImageView *)selectImage {
    if (!_selectImage) {
        _selectImage = [[UIImageView alloc]init];
        _selectImage.image = [UIImage imageNamed:@"未选中"];
    }
    return _selectImage;
}


@end
