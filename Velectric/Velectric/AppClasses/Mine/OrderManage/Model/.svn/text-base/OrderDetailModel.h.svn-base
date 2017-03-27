//
//  OrderDetailModel.h
//  Velectric
//
//  Created by hongzhou on 2016/12/23.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsModel;

@interface ProductInfoModel : NSObject

//商品id
@property (assign,nonatomic) NSInteger productId;

//名称
@property (strong,nonatomic) NSString * name;

//商品信息
@property (strong,nonatomic) NSMutableArray <GoodsModel *>* goodsList;

@end


@interface OrderDetailModel : NSObject

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

//订单金额
@property (assign,nonatomic) CGFloat orderAmount;

//应付金额
@property (assign,nonatomic) CGFloat payableAmount;

//收货人姓名
@property (strong,nonatomic) NSString * receiverName;

//收货人地址
@property (strong,nonatomic) NSString * address;

//收货人手机
@property (strong,nonatomic) NSString * mobile;

//支付方式  0:在线支付 1：网关 2：快捷 3 ：支付宝 4：微信
@property (assign,nonatomic) NSInteger payType;

//支付名称
@property (strong,nonatomic) NSString * payName;

//取货方式  方式 1：送货上门 2：自提
@property (assign,nonatomic) NSInteger sendGoodsType;

//取货名称
@property (strong,nonatomic) NSString * sendGoodsTypeName;

//物流名称
@property (strong,nonatomic) NSString * deliveryModeName;

//发票类型  1专票  2普票  3不开票
@property (assign,nonatomic) NSInteger invoiceType;

//发票类型名称
@property (strong,nonatomic) NSString * invoiceTypeName;

//发票公司名称
@property (strong,nonatomic) NSString * invoiceTitle;

//下单时间
@property (strong,nonatomic) NSString * orderCeateTimeStr;

//商品列表
@property (strong,nonatomic) NSMutableArray <ProductInfoModel *>* productList;

//订单操作日志
@property (strong,nonatomic) NSArray * orderTraces;

//物流信息
@property (strong,nonatomic) NSDictionary * stepMap;

@end
