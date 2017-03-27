//
//  CommitOrderVC.h
//  Velectric
//
//  Created by hongzhou on 2016/12/14.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "BaseViewController.h"

//进入方式
typedef enum {
    EnterType_OrderCenter,          //订单中心进入
    EnterType_CreatOrder,           //创建订单进入
}EnterType;

@interface CommitOrderVC : BaseViewController

//进入方式
@property (assign,nonatomic) EnterType enterType;

//订单id
@property (strong,nonatomic) NSString * mergePaymentId;

//是否从订单进入
@property (assign,nonatomic) BOOL isOrderEnter;

@end
