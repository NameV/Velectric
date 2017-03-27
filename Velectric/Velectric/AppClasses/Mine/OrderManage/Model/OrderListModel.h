//
//  OrderListModel.h
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsModel;

@interface OrderListModel : NSObject

//订单状态-后台
@property (assign,nonatomic) OrderStatus orderStateServer;

//订单状态-前端
@property (assign,nonatomic) OrderStatus orderStateAPP;

/*
    订单是否已经发货
    orderStateServer=3 未发货
    orderStateServer=4 已发货
 */
@property (assign,nonatomic) BOOL alreadySend;

//订单id
@property (assign,nonatomic) NSInteger orderId;

//订单编号（后台参数）
@property (strong,nonatomic) NSString * mergePaymentId;

//订单编号（界面展示）
@property (strong,nonatomic) NSString * orderNumber;

//下单时间
@property (strong,nonatomic) NSNumber * orderCreateTime;

//订单总金额
@property (assign,nonatomic) CGFloat orderAmount;

//商品总金额
@property (assign,nonatomic) CGFloat productAmount;

//商品总数量
@property (assign,nonatomic) NSInteger productNum;

//应付金额
@property (assign,nonatomic) CGFloat payableAmount;

//订单操作日志
@property (strong,nonatomic) NSArray * orderTraces;

//商品列表
@property (strong,nonatomic) NSMutableArray <GoodsModel *>* goodsList;

@end
