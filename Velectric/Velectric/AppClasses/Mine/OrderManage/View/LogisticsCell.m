//
//  LogisticsCell.m
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "LogisticsCell.h"
#import "OrderProcessModel.h"

@implementation LogisticsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //圆点
        UIImage * image = [UIImage imageNamed:@"xiaoyuan"];
        _yuanImage = [[UIImageView alloc]initWithFrame:CGRectMake(14.5, (50-image.size.height)/2, image.size.width, image.size.height)];
        _yuanImage.image = image;
        [self.contentView addSubview:_yuanImage];
        
        //竖线
        _verticaleLine = [[UIView alloc]initWithFrame:CGRectMake(_yuanImage.centerX-0.5, 0, 1, 50)];
        _verticaleLine.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_verticaleLine];
        
        //内容
        _contentlab = [[UILabel alloc]initWithFrame:CGRectMake(_yuanImage.right + 12, 5, SCREEN_WIDTH - _yuanImage.right - 24, 20)];
        _contentlab.textColor = COLOR_333333;
        _contentlab.font = Font_1_F12;
        _contentlab.numberOfLines = 0;
        [self.contentView addSubview:_contentlab];
        
        //时间
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(_contentlab.left, _contentlab.bottom, _contentlab.width, _contentlab.height)];
        _timeLab.textColor = COLOR_999999;
        _timeLab.font = Font_1_F12;
        [self.contentView addSubview:_timeLab];
        
        [self.contentView bringSubviewToFront:_yuanImage];
    }
    return self;
}

-(void)setModel:(OrderProcessModel *)model
{
    _model = model;
    
    _contentlab.text = model.myDescription;
    NSString * time = [NSDate getDateStringWithBigStringStyle:[NSString stringWithFormat:@"%@",model.createTime] withFormatterStr:nil];
    _timeLab.text = time;
}

-(void)setLogisticsModel:(OrderProcessModel *)logisticsModel
{
    _logisticsModel = logisticsModel;
    _contentlab.text = logisticsModel.myDescription;
    _timeLab.text = logisticsModel.logisticsTime;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
