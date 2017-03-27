//
//  SectionView.m
//  Velectric
//
//  Created by hongzhou on 2017/1/16.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "SectionView.h"
#import "HomeCategoryModel.h"

@implementation SectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        CGFloat alphaWidth = SCREEN_WIDTH*(5.0/32.0);
        //姓名
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - alphaWidth - 50, 20)];
        _nameLab.textColor = COLOR_666666;
        _nameLab.font = Font_1_F15;
        _nameLab.numberOfLines = 0;
        [self addSubview:_nameLab];
        
        //灰色线条
        _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH - alphaWidth, 0.5)];
        _lineView.backgroundColor = COLOR_DDDDDD;
        [self addSubview:_lineView];
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:_button];
        
        UIImage * image = [UIImage imageNamed:@"choosexia"];
        _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(_lineView.width - image.size.width - 10, (40-image.size.height)/2, image.size.width, image.size.height)];
        _rightImage.image = image;
        [self addSubview:_rightImage];
    }
    return self;
}

-(void)setModel:(HomeCategoryModel *)model
{
    _model = model;
    _nameLab.text = model.name;
    if (self.fromFactoryFlage) {
        if (model.isSelect) {
            _nameLab.textColor = COLOR_F2B602;
            _rightImage.image = [UIImage imageNamed:@""];
        }else{
            _nameLab.textColor = COLOR_666666;
            _rightImage.image = [UIImage imageNamed:@""];
        }
    }else{
        if (model.isSelect) {
            _nameLab.textColor = COLOR_F2B602;
            _rightImage.image = [UIImage imageNamed:@"chooseshang"];
        }else{
            _nameLab.textColor = COLOR_666666;
            _rightImage.image = [UIImage imageNamed:@"choosexia"];
        }
    }
    
}

@end
