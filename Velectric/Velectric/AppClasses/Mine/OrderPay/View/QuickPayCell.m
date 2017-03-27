//
//  QuickPayCell.m
//  Velectric
//
//  Created by hongzhou on 2016/12/16.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "QuickPayCell.h"
#import "BankInfoModel.h"

@implementation QuickPayCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(18, 18, 54, 54)];
        _logoImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_logoImage];
        
        _backNameLab = [[UILabel alloc]initWithFrame:CGRectMake(_logoImage.right + 24, 20, 200, 25)];
        _backNameLab.textColor = COLOR_666666;
        _backNameLab.font = Font_1_F18;
        _backNameLab.numberOfLines = 0;
        [self.contentView addSubview:_backNameLab];
        
        _numberLab = [[UILabel alloc]initWithFrame:CGRectMake(_backNameLab.left, _backNameLab.bottom, 100, _backNameLab.height)];
        _numberLab.textColor = COLOR_999999;
        _numberLab.font = Font_1_F15;
        [self.contentView addSubview:_numberLab];
        
        
        //右边箭头
        UIImage * goImg = [UIImage imageNamed:@"youjiantou"];
        _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 18 - goImg.size.width, (90-goImg.size.height)/2, goImg.size.width, goImg.size.height)];
        _rightImage.image = goImg;
        [self.contentView addSubview:_rightImage];
        
        _lineView = [[UIImageView alloc]initWithFrame:CGRectMake(_logoImage.left, 89.5, SCREEN_WIDTH - _logoImage.left*2, 0.5)];
        _lineView.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_lineView];
    }
    return self;
}

-(void)setModel:(BankInfoModel *)model
{
    _model = model;
    _logoImage.image = [UIImage imageNamed:@"yinlian"];
    
    NSString * bankName = [NSString stringWithFormat:@"%@",model.plantBankName];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:bankName];
//     [attrString addAttribute:NSFontAttributeName value:Font_1_F12 range:[bankName rangeOfString:model.cardType]];
//    [attrString addAttribute:NSForegroundColorAttributeName value:COLOR_666666 range:[bankName rangeOfString:model.cardType]];
    _backNameLab.attributedText = attrString;
    
    _numberLab.text = [NSString stringWithFormat:@"尾号  %@",model.accountNo];
}

-(void)setInfoModel:(BankInfoModel *)infoModel
{
    _infoModel = infoModel;
    _logoImage.image = [UIImage imageNamed:infoModel.logoUrl];
//    _logoImage.backgroundColor = COLOR_F2B602;
    
    NSString * bankName = [NSString stringWithFormat:@"%@",infoModel.plantBankName];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:bankName];
    [attrString addAttribute:NSFontAttributeName value:Font_1_F13 range:NSMakeRange(attrString.length-3, 3)];
//    [attrString addAttribute:NSForegroundColorAttributeName value:COLOR_666666 range:[bankName rangeOfString:infoModel.cardType]];
    _backNameLab.attributedText = attrString;
    
    _logoImage.frame = CGRectMake(_logoImage.left, 10, 45, 45);
    _backNameLab.frame = CGRectMake(_backNameLab.left, 15, _backNameLab.width, 35);
    _rightImage.frame = CGRectMake(_rightImage.left, (65-_rightImage.height)/2, _rightImage.width, _rightImage.height);
    _lineView.frame = CGRectMake(_lineView.left, 64.5, _lineView.width, 0.5);
    _numberLab.hidden = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
