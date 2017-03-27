//
//  OrderListCell.h
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderListModel;

@interface OrderListCell : UITableViewCell

//订单状态
@property (strong,nonatomic) UILabel * orderStatusLab;

//订单号
@property (strong,nonatomic) UILabel * orderNoLab;

//时间
@property (strong,nonatomic) UILabel * orderTimeLab;

//商品背景view
@property (strong,nonatomic) UIView * goodsBgView;

//表 图片
@property (strong,nonatomic) UIImageView * watchImage;

//倒计时
@property (strong,nonatomic) UILabel * timingLab;

//商品数、价格
@property (strong,nonatomic) UILabel * infoLab;

//灰色线条
@property (strong,nonatomic) UIView * lineView;

//支付按钮
@property (strong,nonatomic) UIButton * payBtn;

//订单详情按钮
@property (strong,nonatomic) UIButton * detailBtn;

//取消按钮
@property (strong,nonatomic) UIButton * cancelBtn;

//再次购买按钮
@property (strong,nonatomic) UIButton * buyAgainBtn;

//确认收货按钮
@property (strong,nonatomic) UIButton * sureResiveBtn;

//异常订单按钮
@property (strong,nonatomic) UIButton * unusualBtn;

//订单model
@property (strong,nonatomic) OrderListModel * model;

//定时器
@property (strong,nonatomic) NSTimer * timer;

@end
