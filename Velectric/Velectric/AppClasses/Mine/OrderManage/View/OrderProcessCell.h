//
//  OrderProcessCell.h
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderProcessModel;

@interface OrderProcessCell : UITableViewCell

//圆点image
@property (strong,nonatomic) UIImageView * yuanImage;

//竖线
@property (strong,nonatomic) UIView * verticaleLine;

//内容
@property (strong,nonatomic) UILabel * contentlab;

//时间
@property (strong,nonatomic) UILabel * timeLab;

//线条
@property (strong,nonatomic) UIView * lineView;

//查看物流
@property (strong,nonatomic) UIButton * seeLogisticsBtn;

//物流列表
@property (strong,nonatomic) BaseTableView * logisticsView;


@property (strong,nonatomic) OrderProcessModel * model;

@end
