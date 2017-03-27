//
//  OrderListCell.m
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "OrderListCell.h"
#import "OrderListModel.h"
#import "GoodsModel.h"

@implementation OrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 220)];
        bgView.backgroundColor = COLOR_FFFFFF;
        [self.contentView addSubview:bgView];
        
        //订单状态
        _orderStatusLab = [[UILabel alloc]initWithFrame:CGRectMake(10, bgView.top + 15, 60, 20)];
        _orderStatusLab.textColor = COLOR_FFFFFF;
        _orderStatusLab.backgroundColor = COLOR_F2B602;
        _orderStatusLab.font = Font_1_F14;
        _orderStatusLab.numberOfLines = 0;
        _orderStatusLab.layer.cornerRadius = 2;
        _orderStatusLab.clipsToBounds = YES;
        _orderStatusLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_orderStatusLab];
        
        //订单号
        _orderNoLab = [[UILabel alloc]initWithFrame:CGRectMake(_orderStatusLab.right + 10, _orderStatusLab.top, 150, _orderStatusLab.height)];
        _orderNoLab.textColor = COLOR_333333;
        _orderNoLab.font = Font_1_F12;
        [self.contentView addSubview:_orderNoLab];
        
        //时间
        _orderTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 135, _orderStatusLab.top, 125, _orderStatusLab.height)];
        _orderTimeLab.textColor = COLOR_999999;
        _orderTimeLab.font = Font_1_F10;
        _orderTimeLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_orderTimeLab];
        
        //商品背景view
        _goodsBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _orderNoLab.bottom + 15, SCREEN_WIDTH, 70)];
        _goodsBgView.backgroundColor = COLOR_F7F7F7;
        [self.contentView addSubview:_goodsBgView];
        
        //表 图片
        UIImage * watch = [UIImage imageNamed:@"countdown"];
        _watchImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, _goodsBgView.bottom + (40-watch.size.height)/2, watch.size.width, watch.size.height)];
        _watchImage.image = watch;
        [self.contentView addSubview:_watchImage];
        
        //倒计时
        _timingLab = [[UILabel alloc]initWithFrame:CGRectMake(_watchImage.right+5, _watchImage.top, 80, _orderStatusLab.height)];
        _timingLab.textColor = COLOR_333333;
        _timingLab.font = Font_1_F12;
        [self.contentView addSubview:_timingLab];
        
        //商品数、价格
        _infoLab = [[UILabel alloc]initWithFrame:CGRectMake(100, _watchImage.top, SCREEN_WIDTH - 110, _orderStatusLab.height)];
        _infoLab.textColor = COLOR_666666;
        _infoLab.font = Font_1_F15;
        _infoLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_infoLab];
        
        //灰色线条
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(10, _goodsBgView.bottom + 40, SCREEN_WIDTH - 20, 0.5)];
        _lineView.backgroundColor = COLOR_DDDDDD;
        [self.contentView addSubview:_lineView];
        
        //支付按钮
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.titleLabel.font = Font_1_F13;
        [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        _payBtn.layer.cornerRadius = 2;
        _payBtn.layer.borderWidth = 0.5;
        _payBtn.layer.borderColor = COLOR_F2B602.CGColor;
        [self.contentView addSubview:_payBtn];
        
        //订单详情按钮
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.titleLabel.font = Font_1_F13;
        [_detailBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        _detailBtn.backgroundColor = COLOR_F7F7F7;
        _detailBtn.layer.cornerRadius = 2;
        [self.contentView addSubview:_detailBtn];
        
        //取消按钮
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.titleLabel.font = Font_1_F13;
        [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = COLOR_F7F7F7;
        _cancelBtn.layer.cornerRadius = 2;
        [self.contentView addSubview:_cancelBtn];
        
        //再次购买按钮
        _buyAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyAgainBtn.titleLabel.font = Font_1_F13;
        [_buyAgainBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        [_buyAgainBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        _buyAgainBtn.layer.cornerRadius = 2;
        _buyAgainBtn.layer.borderWidth = 0.5;
        _buyAgainBtn.layer.borderColor = COLOR_F2B602.CGColor;
        [self.contentView addSubview:_buyAgainBtn];
        
        //确认收货按钮
        _sureResiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureResiveBtn.titleLabel.font = Font_1_F13;
        [_sureResiveBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [_sureResiveBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        _sureResiveBtn.layer.cornerRadius = 2;
        _sureResiveBtn.layer.borderWidth = 0.5;
        _sureResiveBtn.layer.borderColor = COLOR_F2B602.CGColor;
        [self.contentView addSubview:_sureResiveBtn];
        
        //异常订单按钮
        _unusualBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _unusualBtn.titleLabel.font = Font_1_F13;
        [_unusualBtn setTitle:@"异常订单" forState:UIControlStateNormal];
        [_unusualBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        _unusualBtn.backgroundColor = COLOR_F7F7F7;
        _unusualBtn.layer.cornerRadius = 2;
        [self.contentView addSubview:_unusualBtn];
        
        _payBtn.hidden = YES;
        _detailBtn.hidden = YES;
        _cancelBtn.hidden = YES;
        _buyAgainBtn.hidden = YES;
        _sureResiveBtn.hidden = YES;
        _timingLab.hidden = YES;
        _watchImage.hidden = YES;
        
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
        //加入主循环池中
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

-(void)setModel:(OrderListModel *)model
{
    _model = model;
    //设置订单状态和按钮是否显示，以及frame
    switch (model.orderStateAPP) {
        case OrderStatus_WaitPay://待付款
        {
            _orderStatusLab.text = Order_WaitPay;
            _payBtn.hidden = NO;
            _detailBtn.hidden = NO;
            _cancelBtn.hidden = NO;
            _buyAgainBtn.hidden = YES;
            _sureResiveBtn.hidden = YES;
            _timingLab.hidden = NO;
            _watchImage.hidden = NO;
            _unusualBtn.hidden = YES;
            //开启定时器
//            [_timer fire];
            [_timer setFireDate:[NSDate distantPast]];
            
            _payBtn.frame = CGRectMake(SCREEN_WIDTH - 90, _lineView.bottom + 15, 80, 30);
            _detailBtn.frame = CGRectMake(SCREEN_WIDTH - 90*2, _lineView.bottom + 15, 80, 30);
            _cancelBtn.frame = CGRectMake(SCREEN_WIDTH - 90*3, _lineView.bottom + 15, 80, 30);
        }
            break;
        case OrderStatus_WaitExecuse://待受理
        {
            _orderStatusLab.text = Order_WaitExecuse;
            _payBtn.hidden = YES;
            _detailBtn.hidden = NO;
            _cancelBtn.hidden = YES;
            _buyAgainBtn.hidden = YES;
            _sureResiveBtn.hidden = YES;
            _timingLab.hidden = NO;
            _watchImage.hidden = NO;
            _unusualBtn.hidden = YES;
            //开启定时器
            [_timer setFireDate:[NSDate distantPast]];
//            [_timer fire];
            
            _detailBtn.frame = CGRectMake(SCREEN_WIDTH - 90, _lineView.bottom + 15, 80, 30);
        }
            break;
        case OrderStatus_WaitReceive://待收货
        {
            _orderStatusLab.text = Order_WaitReceive;
            _payBtn.hidden = YES;
            _detailBtn.hidden = NO;
            _cancelBtn.hidden = YES;
            _buyAgainBtn.hidden = YES;
            _sureResiveBtn.hidden = NO;
            _timingLab.hidden = YES;
            _watchImage.hidden = YES;
            
            //如果已经发货，异常按钮不隐藏，未发货，异常按钮隐藏，相应的布局也要变化
            if (model.alreadySend == YES) {
                _unusualBtn.hidden = NO;
                _sureResiveBtn.frame = CGRectMake(SCREEN_WIDTH - 90, _lineView.bottom + 15, 80, 30);
                _unusualBtn.frame = CGRectMake(SCREEN_WIDTH - 90*2, _lineView.bottom + 15, 80, 30);
                _detailBtn.frame = CGRectMake(SCREEN_WIDTH - 90*3, _lineView.bottom + 15, 80, 30);
            }else{
                _unusualBtn.hidden = YES;
                _sureResiveBtn.frame = CGRectMake(SCREEN_WIDTH - 90, _lineView.bottom + 15, 80, 30);
                _detailBtn.frame = CGRectMake(SCREEN_WIDTH - 90*2, _lineView.bottom + 15, 80, 30);
            }
            
            //关闭定时器
//            [_timer invalidate];
            [_timer setFireDate:[NSDate distantFuture]];
            
            
        }
            break;
        case OrderStatus_Finish://已关闭
        {
            _orderStatusLab.text = Order_Finish;
            _payBtn.hidden = YES;
            _detailBtn.hidden = NO;
            _cancelBtn.hidden = YES;
            _buyAgainBtn.hidden = YES;
            _sureResiveBtn.hidden = YES;
            _timingLab.hidden = YES;
            _watchImage.hidden = YES;
            _unusualBtn.hidden = YES;
            //关闭定时器
//            [_timer invalidate];
            [_timer setFireDate:[NSDate distantFuture]];
            
            _detailBtn.frame = CGRectMake(SCREEN_WIDTH - 90, _lineView.bottom + 15, 80, 30);
        }
            break;
        case OrderStatus_Cancel://已取消
        {
            _orderStatusLab.text = Order_Cancel;
            _payBtn.hidden = YES;
            _detailBtn.hidden = NO;
            _cancelBtn.hidden = YES;
            _buyAgainBtn.hidden = NO;
            _sureResiveBtn.hidden = YES;
            _timingLab.hidden = YES;
            _watchImage.hidden = YES;
            _unusualBtn.hidden = YES;
            //关闭定时器
//            [_timer invalidate];
            [_timer setFireDate:[NSDate distantFuture]];
            
            _buyAgainBtn.frame = CGRectMake(SCREEN_WIDTH - 90, _lineView.bottom + 15, 80, 30);
            _detailBtn.frame = CGRectMake(SCREEN_WIDTH - 90*2, _lineView.bottom + 15, 80, 30);
        }
            break;
        case OrderStatus_Unusual://异常订单
        {
            _orderStatusLab.text = Order_Unusual;
            _payBtn.hidden = YES;
            _detailBtn.hidden = NO;
            _cancelBtn.hidden = YES;
            _buyAgainBtn.hidden = NO;
            _sureResiveBtn.hidden = YES;
            _timingLab.hidden = YES;
            _watchImage.hidden = YES;
            _unusualBtn.hidden = YES;
            //关闭定时器
            //            [_timer invalidate];
            [_timer setFireDate:[NSDate distantFuture]];
            
            _buyAgainBtn.frame = CGRectMake(SCREEN_WIDTH - 90, _lineView.bottom + 15, 80, 30);
            _detailBtn.frame = CGRectMake(SCREEN_WIDTH - 90*2, _lineView.bottom + 15, 80, 30);
        }
            break;
        default:
            break;
    }
    //设置订单号
    _orderNoLab.text = model.orderNumber;
    //设置订单时间
    NSString * time = [NSDate getDateStringWithBigStringStyle:[NSString stringWithFormat:@"%@",_model.orderCreateTime] withFormatterStr:nil];
    _orderTimeLab.text = time;
    //设置商品
    [_goodsBgView removeAllSubviews];
    int goodsCount = 0;
    if (model.goodsList.count == 1) {
        
        goodsCount = 1;
        UIImageView * picView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        GoodsModel * goods = [model.goodsList firstObject];
        NSURL * url = [NSURL URLWithString:CreateRequestApiPictureUrl(goods.url)];
        [picView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [_goodsBgView addSubview:picView];
        
        UILabel * nameLab = [[UILabel alloc]initWithFrame:CGRectMake(picView.right + 10, 10, SCREEN_WIDTH - picView.right - 20, picView.height - 20)];
        nameLab.font = Font_1_F15;
        nameLab.text = goods.name;
        nameLab.textColor = COLOR_333333;
        nameLab.numberOfLines = 0;
        [_goodsBgView addSubview:nameLab];
        
        UILabel * specLab = [[UILabel alloc]initWithFrame:CGRectMake(nameLab.left, nameLab.bottom, nameLab.width, 20)];
        specLab.font = Font_1_F12;
        specLab.text = goods.goodsSpecs;
        specLab.textColor = COLOR_999999;
        specLab.numberOfLines = 0;
        [_goodsBgView addSubview:specLab];
        
    }else{
        for (int i=0; i<model.goodsList.count; i++){
            GoodsModel * goods = [model.goodsList objectAtIndex:i];
            goodsCount += goods.quantity;
            UIImageView * picView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i*60, 10, 50, 50)];
            NSURL * url = [NSURL URLWithString:CreateRequestApiPictureUrl(goods.url)];
            [picView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
            [_goodsBgView addSubview:picView];
        }
    }
    //商品数量和价格
    NSString * money = [NSString stringWithFormat:@"¥%0.2f",model.orderAmount];
    
    NSString * count = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:goodsCount]];
    NSString * info = [NSString stringWithFormat:@"共%@件商品  总价：%@",count,money];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:info];
    [attrString addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:[info rangeOfString:count]];
    [attrString addAttribute:NSForegroundColorAttributeName value:COLOR_F44336 range:[info rangeOfString:money]];
    _infoLab.attributedText = attrString;
}

#pragma mark - 时间倒计时
-(void)timeCountdown
{
    //获取当前时间戳 毫秒
    double nowChuo = [[NSDate millisecondIntervalSince1970] doubleValue];
    //获取结束时间戳 毫秒
    double endChuo = [_model.orderCreateTime doubleValue] + 60*60*12*1000;
    if (_model.orderStateAPP == 2){
        endChuo = [_model.orderCreateTime doubleValue] + 60*60*48*1000;
    }
    NSDate * nowDate = [NSDate dateWithTimeIntervalSince1970:nowChuo/1000.f];
    NSDate * endDate = [NSDate dateWithTimeIntervalSince1970:endChuo/1000.f];
    
    NSTimeInterval aTimer = [endDate timeIntervalSinceDate:nowDate];
    NSInteger hour = (aTimer/3600);
    NSInteger minute = (aTimer - hour*3600)/60;
    NSInteger second = aTimer - hour*3600 - minute*60;
    NSString * timing = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute,second];
    _timingLab.text = timing;
    if (hour == 0 && minute == 0 && second == 0) {
        [_timer invalidate];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
