//
//  ScreeningViewCell.m
//  Velectric
//
//  Created by hongzhou on 2016/12/29.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "ScreeningViewCell.h"
#import "SkuPropertyModel.h"


@implementation ScreeningViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.clipsToBounds = YES;
        CGFloat alphaWidth = SCREEN_WIDTH*(5.0/32.0);
        
        //白色背景
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH - alphaWidth, 80)];
        _bgView.backgroundColor = COLOR_FFFFFF;
        [self.contentView addSubview:_bgView];
        
        //名称
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        _titleLab.textColor = COLOR_666666;
        _titleLab.font = Font_1_F17;
        [self.contentView addSubview:_titleLab];

        //箭头
        UIImage * image = [UIImage imageNamed:@"choosexia"];
        _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - alphaWidth - image.size.width - 10, (40-image.size.height)/2 + 10, image.size.width, image.size.height)];
        _rightImage.image = image;
        [self.contentView addSubview:_rightImage];
        
        //展开按钮
        _expandBtn = [[UIButton alloc]initWithFrame:CGRectMake(_rightImage.right - 50, 10, 50, 40)];
        [self.contentView addSubview:_expandBtn];
        
        //选中的属性名称
        _propertyNameLab = [[UILabel alloc]initWithFrame:CGRectMake(_rightImage.left - 40, 10, 30, 20)];
        _propertyNameLab.textColor = COLOR_333333;
        _propertyNameLab.font = Font_1_F14;
        _propertyNameLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_propertyNameLab];
        
        //属性集合 view
        _propertyView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH - alphaWidth, 40)];
        [self.contentView addSubview:_propertyView];
    }
    return self;
}

-(void)setModel:(SkuPropertyModel *)model
{
    _model = model;
    
    //属性名称
    CGFloat textWidth = [model.frontLabel getStringWidthWithFont:_titleLab.font];
    _titleLab.text = model.frontLabel;
    _titleLab.frame = CGRectMake(_titleLab.left, _titleLab.top, textWidth, 20);
    
    if (model.isExpand) {
        _rightImage.image = [UIImage imageNamed:@"chooseshang"];
        _bgView.frame = CGRectMake(0, 10, _bgView.width, model.expandHeight - 10);
    }else{
        _rightImage.image = [UIImage imageNamed:@"choosexia"];
        _bgView.frame = CGRectMake(0, 10, _bgView.width, model.normalHeight - 10);
    }
    //取出选中的属性 赋值
    if (model.selectPropertyList.count) {
        NSString * name = @"";
        for (PropertyModel * proModel in model.selectPropertyList) {
            if ([proModel isEqual:model.selectPropertyList.firstObject]) {
                name = [name stringByAppendingFormat:@"%@",proModel.propertyValue];
            }else{
                name = [name stringByAppendingFormat:@",%@",proModel.propertyValue];
            }
        }
        _propertyNameLab.text = name;
        _propertyNameLab.textColor = COLOR_F2B602;
    }else{
        _propertyNameLab.text = @"全部";
        _propertyNameLab.textColor = COLOR_333333;
    }
    _propertyNameLab.frame = CGRectMake(_titleLab.right + 5, _titleLab.top, _rightImage.left - _titleLab.right - 10, 20);
    
    _propertyView.frame = CGRectMake(0, 50, _propertyView.width, model.expandHeight - 50);
    [_propertyView removeAllSubviews];
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
