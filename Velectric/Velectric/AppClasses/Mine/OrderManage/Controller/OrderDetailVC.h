//
//  OrderDetailVC.h
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailVC : BaseViewController

//订单id
@property (strong,nonatomic) NSString * orderId;

//订单操作日志
@property (strong,nonatomic) NSArray * orderTraces;

@end
