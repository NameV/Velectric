//
//  OrderProcessCell.m
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "OrderProcessCell.h"
#import "OrderProcessModel.h"

@implementation OrderProcessCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //圆点
        UIImage * image = [UIImage imageNamed:@"dayuan"];
        _yuanImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, (40-image.size.height)/2, image.size.width, image.size.height)];
        _yuanImage.image = image;
        
        //竖线
        _verticaleLine = [[UIView alloc]initWithFrame:CGRectMake(_yuanImage.centerX-0.5, _yuanImage.bottom, 1, 40)];
        _verticaleLine.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_verticaleLine];
        [self.contentView addSubview:_yuanImage];
        
        //内容
        _contentlab = [[UILabel alloc]initWithFrame:CGRectMake(_yuanImage.right + 12, 10, 150, 20)];
        _contentlab.textColor = COLOR_333333;
        _contentlab.font = Font_1_F13;
        _contentlab.numberOfLines = 0;
        [self.contentView addSubview:_contentlab];

        //时间
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 135, _contentlab.top, 125, _contentlab.height)];
        _timeLab.textColor = COLOR_999999;
        _timeLab.font = Font_1_F13;
        [self.contentView addSubview:_timeLab];
       
        //线条
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(_contentlab.left, 39.5, SCREEN_WIDTH - _contentlab.left - 10, 0.5)];
        _lineView.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_lineView];
        
        _seeLogisticsBtn = [[UIButton alloc]initWithFrame:CGRectMake(_lineView.left, _lineView.bottom + 15, 80, 20)];
        [_seeLogisticsBtn setImage:[UIImage imageNamed:@"chakanwuliuxia"] forState:UIControlStateNormal];
        [self.contentView addSubview:_seeLogisticsBtn];
        
        _logisticsView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, -_seeLogisticsBtn.bottom, SCREEN_WIDTH, 100)];
        _logisticsView.scrollEnabled = NO;
        [self.contentView addSubview:_logisticsView];
        
//        [self.contentView bringSubviewToFront:_yuanImage];
    }
    return self;
}

-(void)setModel:(OrderProcessModel *)model
{
    _model = model;
    
    _contentlab.adjustsFontSizeToFitWidth = YES;
    _timeLab.adjustsFontSizeToFitWidth = YES;
    
    _contentlab.text = model.myDescription;
    
//    NSTimeInterval time = [NSDate timeIntervalWithTimeString:model.createTime];
//    NSString * timeStr = [NSDate stringMillisecondWithTimeInterval:time];
    NSString * timeStr = [NSDate getDateStringWithBigStringStyle:[NSString stringWithFormat:@"%@",model.createTime] withFormatterStr:nil];
    
    _timeLab.text = timeStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
