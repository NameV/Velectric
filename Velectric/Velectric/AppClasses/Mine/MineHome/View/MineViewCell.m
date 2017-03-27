//
//  MineViewCell.m
//  Velectric
//
//  Created by hongzhou on 2016/12/20.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "MineViewCell.h"

@implementation MineViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //小图标
        _lconImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        _lconImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_lconImage];
        
        //标题
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_lconImage.right + 15, 10, 200, 30)];
        _titleLab.textColor = COLOR_333333;
        _titleLab.font = Font_1_F15;
        [self.contentView addSubview:_titleLab];
        
        //右边箭头
        UIImage * goImg = [UIImage imageNamed:@"youjiantou"];
        _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - goImg.size.width, (50-goImg.size.height)/2, goImg.size.width, goImg.size.height)];
        _rightImage.image = goImg;
        [self.contentView addSubview:_rightImage];
        
        //灰色线条
        _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49.5, SCREEN_WIDTH - 20, 0.5)];
        _lineView.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_lineView];
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
