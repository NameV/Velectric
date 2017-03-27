//
//  AddressListCell.m
//  Tourph
//
//  Created by yanghongzhou on 16/2/16.
//  Copyright © 2016年 yanghongzhou. All rights reserved.
//

#import "AddressListCell.h"
#import "AddressModel.h"

static CGFloat const orangeX = 10;
static CGFloat const orangeY = 10;

@implementation AddressListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //选中图片
        UIImage * selectImage = [UIImage imageNamed:@"yixuan"];
        _selectView = [[UIImageView alloc]initWithFrame:CGRectMake(orangeX, 35, selectImage.size.width, selectImage.size.height)];
        _selectView.image = selectImage;
        [self.contentView addSubview:_selectView];
        
        //姓名
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(orangeX, orangeY, 100, 20)];
        _nameLab.textColor = COLOR_F2B602;
        _nameLab.font = Font_1_F16;
        _nameLab.numberOfLines = 0;
        [self.contentView addSubview:_nameLab];
        
        //默认图片
        UIImage * defaultImg = [UIImage imageNamed:@"moren"];
        _defaultView = [[UIImageView alloc]initWithFrame:CGRectMake(_selectView.right + 10, _nameLab.bottom + 10, defaultImg.size.width, defaultImg.size.height)];
        _defaultView.image = defaultImg;
        [self.contentView addSubview:_defaultView];
        
        //手机
        _phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(_nameLab.right + 20, _nameLab.top, 100, _nameLab.height)];
        _phoneLab.textColor = COLOR_F2B602;
        _phoneLab.font = Font_1_F14;
        [self.contentView addSubview:_phoneLab];

        //详细地址
        _addressLab = [[UILabel alloc]initWithFrame:CGRectMake(_nameLab.left, _nameLab.bottom + 10, SCREEN_WIDTH - _nameLab.left - 80, 35)];
        _addressLab.textColor = COLOR_666666;
        _addressLab.font = Font_1_F12;
        _addressLab.numberOfLines = 0;
        [self.contentView addSubview:_addressLab];
        
        //分割线
        _fengeLine = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 15, 0.5, 50)];
        _fengeLine.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_fengeLine];
        
        //编辑按钮
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake(_fengeLine.right, _fengeLine.top, 60, _fengeLine.height);
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"addressedit"] forState:UIControlStateNormal];
        _editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_editBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        _editBtn.titleLabel.font = Font_1_F12;
        [self.contentView addSubview:_editBtn];
        
        //灰色线条
        _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _addressLab.bottom + 10, SCREEN_WIDTH, 0.5)];
        _lineView.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_lineView];
    }
    return self;
}


-(void)setModel:(AddressModel *)model
{
    _model = model;
    
    _nameLab.text = model.recipient;
    NSMutableString * phone = [[NSMutableString alloc]initWithString:model.mobile];
    if (phone.length == 11)
    {
        [phone replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    _phoneLab.text = phone;
    _addressLab.text = [NSString stringWithFormat:@"%@",model.address];
    
    if ([model.defaulted intValue]) {
        _selectView.hidden = NO;
        _defaultView.hidden = NO;
        
        _nameLab.textColor = COLOR_F2B602;
        _phoneLab.textColor = COLOR_F2B602;
        
        _nameLab.frame = CGRectMake(_defaultView.left, orangeY, _nameLab.width, _nameLab.height);
        _phoneLab.frame = CGRectMake(_nameLab.right + 20, _nameLab.top, _phoneLab.width, _nameLab.height);
        _addressLab.frame = CGRectMake(_defaultView.right + 10, _addressLab.top, _fengeLine.left - _defaultView.right - 20, _addressLab.height);
    }else{
        _selectView.hidden = YES;
        _defaultView.hidden = YES;
        
        _nameLab.textColor = COLOR_333333;
        _phoneLab.textColor = COLOR_333333;
        
        _nameLab.frame = CGRectMake(orangeX, orangeY, _nameLab.width, _nameLab.height);
        _phoneLab.frame = CGRectMake(_nameLab.right + 20, _nameLab.top, _phoneLab.width, _nameLab.height);
        _addressLab.frame = CGRectMake(_nameLab.left, _addressLab.top, SCREEN_WIDTH - _nameLab.left - 80, _addressLab.height);
    }
}

@end
