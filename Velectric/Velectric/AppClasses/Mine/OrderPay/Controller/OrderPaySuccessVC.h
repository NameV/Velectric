//
//  OrderPaySuccessVC.h
//  Velectric
//
//  Created by hongzhou on 2016/12/14.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderPaySuccessVC : BaseViewController

@property (nonatomic, assign) CGFloat totalAmount;             //总的订单钱数
@property (nonatomic, copy) NSString *payWay;                   //支付方式
@property (nonatomic, copy) NSString *orderNum;                 //流水单号
@property (nonatomic, copy) NSString *payTime;                  //交易时间

@end
