//
//  OrderSettlementVC.h
//  Velectric
//
//  Created by hongzhou on 2016/12/14.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "BaseViewController.h"

@class CartListModel;

//商品结算方式
typedef enum{
    OrderSettlement_Single,         //单个商品结算
    OrderSettlement_More,           //多个商品结算（购物车进入）
}OrderSettlementType;

@interface OrderSettlementVC : BaseViewController

//商品结算方式
@property (assign,nonatomic) OrderSettlementType settlemnetType;

//商品总价格
@property (assign,nonatomic) CGFloat totalPrice;

//商品id，逗号拼接
@property (strong,nonatomic) NSString * goodsIdStr;

//商品数量，逗号拼接
@property (strong,nonatomic) NSString * quantitys;

@property (strong,nonatomic) NSMutableArray <CartListModel*>* productList;

//全部商品列表，下个界面删除的时候用
@property (strong,nonatomic) NSMutableArray <CartListModel*>* allProductList;

@end
