//
//  ScreeningCategoryViewCell3.m
//  Velectric
//
//  Created by hongzhou on 2017/1/15.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "ScreeningCategoryViewCell3.h"
#import "HomeCategoryModel.h"

@implementation ScreeningCategoryViewCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //选中图片
        UIImage * selectImage = [UIImage imageNamed:@"weixuan"];
        _selectView = [[UIImageView alloc]initWithFrame:CGRectMake(30, (40-selectImage.size.height)/2, selectImage.size.width, selectImage.size.height)];
        _selectView.image = selectImage;
        [self.contentView addSubview:_selectView];
        
        //姓名
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_selectView.right + 5, 10, 200, 20)];
        _nameLab.textColor = COLOR_666666;
        _nameLab.font = Font_1_F15;
        _nameLab.numberOfLines = 0;
        [self.contentView addSubview:_nameLab];
        
        CGFloat alphaWidth = SCREEN_WIDTH*(5.0/32.0);
        
        //灰色线条
        _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH - alphaWidth, 0.5)];
        _lineView.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_lineView];
    }
    return self;
}

-(void)setModel:(HomeCategoryModel *)model
{
    _model = model;
    
    _nameLab.text = model.name;
    if (model.isSelect) {
        _nameLab.textColor = COLOR_F2B602;
        _selectView.image = [UIImage imageNamed:@"yixuan"];
    }else{
        _nameLab.textColor = COLOR_666666;
        _selectView.image = [UIImage imageNamed:@"weixuan"];
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
