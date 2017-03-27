//
//  ScreeningCategoryViewCell2.m
//  Velectric
//
//  Created by hongzhou on 2016/12/29.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "ScreeningCategoryViewCell2.h"
#import "HomeCategoryModel.h"

@implementation ScreeningCategoryViewCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        //-----------------之前代码begin--------------------
//        //选中图片
//        UIImage * selectImage = [UIImage imageNamed:@"choosexia"];
//        _selectView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (40-selectImage.size.height)/2, selectImage.size.width, selectImage.size.height)];
//        _selectView.image = selectImage;
//        [self.contentView addSubview:_selectView];
        //-----------------之前代码end--------------------
        
        //姓名
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 20)];
        _nameLab.textColor = COLOR_666666;
        _nameLab.font = Font_1_F15;
        _nameLab.numberOfLines = 0;
        [self.contentView addSubview:_nameLab];
        
        CGFloat alphaWidth = SCREEN_WIDTH*(5.0/32.0);
        
        //灰色线条
        _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH - alphaWidth, 0.5)];
        _lineView.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_lineView];
        
        //修改代码begin
        //选中图片
        UIImage * selectImage = [UIImage imageNamed:@"choosexia"];
        _selectView = [[UIImageView alloc]initWithFrame:CGRectMake(_lineView.width - selectImage.size.width - 10, (40-selectImage.size.height)/2, selectImage.size.width, selectImage.size.height)];
        _selectView.image = selectImage;
        [self.contentView addSubview:_selectView];
        //修改代码end
        
//        UIImage * image = [UIImage imageNamed:@"choosexia"];
//        _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(_lineView.width - image.size.width - 10, (40-image.size.height)/2, image.size.width, image.size.height)];
//        _rightImage.image = image;
//        [self.contentView addSubview:_rightImage];
        
        _subCategoryView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 100)];
        _subCategoryView.scrollEnabled = NO;
        [self.contentView addSubview:_subCategoryView];
    }
    return self;
}

-(void)setModel:(HomeCategoryModel *)model
{
    _model = model;
    
    _nameLab.text = model.name;
    if (model.isSelect) {
        _nameLab.textColor = COLOR_F2B602;
        _selectView.image = [UIImage imageNamed:@"chooseshang"];
    }else{
        _nameLab.textColor = COLOR_666666;
        _selectView.image = [UIImage imageNamed:@"choosexia"];
    }
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
