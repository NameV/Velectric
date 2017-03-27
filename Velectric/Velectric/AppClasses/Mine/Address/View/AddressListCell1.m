
//
//  AddressListCell1.m
//  Velectric
//
//  Created by hongzhou on 2016/12/15.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "AddressListCell1.h"

@implementation AddressListCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 115)];
        backView.backgroundColor = COLOR_FFFFFF;
        [self.contentView addSubview:backView];
        
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 60, 20)];
        _nameLab.textColor = COLOR_666666;
        _nameLab.font = Font_1_F14;
        _nameLab.numberOfLines = 0;
        [self.contentView addSubview:_nameLab];
        
        _phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(_nameLab.right + 20, _nameLab.top, 100, _nameLab.height)];
        _phoneLab.textColor = COLOR_666666;
        _phoneLab.font = Font_1_F14;
        [self.contentView addSubview:_phoneLab];
        
        _addressLab = [[UILabel alloc]initWithFrame:CGRectMake(_nameLab.left, _nameLab.bottom + 5, SCREEN_WIDTH - _nameLab.left * 2, 35)];
        _addressLab.textColor = COLOR_666666;
        _addressLab.font = Font_1_F14;
        _addressLab.numberOfLines = 0;
        [self.contentView addSubview:_addressLab];
        
        _lineViewMiddle = [[UIImageView alloc]initWithFrame:CGRectMake(10, _addressLab.bottom , SCREEN_WIDTH - 20, 0.5)];
        _lineViewMiddle.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_lineViewMiddle];
        
        _setDefautBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _setDefautBtn.frame = CGRectMake(10, _lineViewMiddle.bottom + 5, 120, 30);
        _setDefautBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _setDefautBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_setDefautBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        _setDefautBtn.titleLabel.font = Font_1_F14;
        [self.contentView addSubview:_setDefautBtn];
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake(SCREEN_WIDTH - 140, _setDefautBtn.top, 60, _setDefautBtn.height);
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"addressedit"] forState:UIControlStateNormal];
        _editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_editBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        _editBtn.titleLabel.font = Font_1_F14;
        [self.contentView addSubview:_editBtn];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(_editBtn.right + 10, _editBtn.top, _editBtn.width, _editBtn.height);
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"addressdelete"] forState:UIControlStateNormal];
        _deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_deleteBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = Font_1_F14;
        [self.contentView addSubview:_deleteBtn];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
