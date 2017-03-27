//
//  OrderProcessVC.h
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderProcessVC : BaseViewController

//订单操作日志
@property (strong,nonatomic) NSArray * orderTraces;

//物流信息
@property (strong,nonatomic) NSDictionary * logisticsDic;

@end
