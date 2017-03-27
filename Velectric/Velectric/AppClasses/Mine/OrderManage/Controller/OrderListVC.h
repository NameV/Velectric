//
//  OrderListVC.h
//  Velectric
//
//  Created by hongzhou on 2016/12/15.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "BaseViewController.h"


//进入方式
typedef enum {
    OrderCenterEnter_MemberCenter,         //会员中心进入
    OrderCenterEnter_CommitOrder,          //提交订单进入
}OrderCenterEnterType;


@interface OrderListVC : BaseViewController

@property (assign,nonatomic) OrderCenterEnterType enterType;

@end
