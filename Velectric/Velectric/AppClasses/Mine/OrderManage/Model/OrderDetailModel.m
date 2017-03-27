//
//  OrderDetailModel.m
//  Velectric
//
//  Created by hongzhou on 2016/12/23.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "OrderDetailModel.h"
#import "GoodsModel.h"

@implementation ProductInfoModel

-(instancetype)init
{
    if (self == [super init]) {
        _goodsList = [NSMutableArray array];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"ogvs"]) {
        NSArray * ogvs = value;
        for (NSDictionary * dic in ogvs) {
            GoodsModel * goods = [[GoodsModel alloc]init];
            [goods setValuesForKeysWithDictionary:dic];
            [_goodsList addObject:goods];
        }
    }
}

@end

@implementation OrderDetailModel

-(instancetype)init
{
    if (self == [super init]) {
        _productList = [NSMutableArray array];
    }
    return self;
}

//支付方式
-(void)setPayType:(NSInteger)payType
{
    _payType = payType;
    switch (payType) {
        case 0:
            _payName = @"在线支付";
            break;
        case 1:
            _payName = @"网关支付";
            break;
        case 2:
            _payName = @"快捷支付";
            break;
        case 3:
            _payName = @"支付宝";
            break;
        case 4:
            _payName = @"微信";
            break;
        default:
            break;
    }
}

//配送方式
-(void)setSendGoodsType:(NSInteger)sendGoodsType
{
    _sendGoodsType = sendGoodsType;
    _sendGoodsTypeName = sendGoodsType == 1 ? @"送货上门" : @"自提";
}

//发票类型
-(void)setInvoiceType:(NSInteger)invoiceType
{
    _invoiceType = invoiceType;
    switch (invoiceType) {
        case 1:
            _invoiceTypeName = @"专票";
            break;
        case 2:
        {
//            if (_invoiceTitle) {
//                [_invoiceTypeName componentsSeparatedByString:_invoiceTitle];
//            }
//            _invoiceTypeName = @"普票";//之前代码
        }
            break;
        case 0:
        case 3:
            _invoiceTypeName = @"不开票";
            break;
        default:
            break;
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"orderState"]) {
        _orderStateServer = [value intValue];
        if (_orderStateServer == 1) {
            //待付款
            _orderStateAPP = 1;
        }else if (_orderStateServer == 2){
            //待受理
            _orderStateAPP = 2;
        }else if (_orderStateServer == 3 || _orderStateServer == 4){
            //待收货
            _orderStateAPP = 3;
            if (_orderStateServer == 4) {
                _alreadySend = YES;
            }
        }else if (_orderStateServer == 5 || _orderStateServer == 7){
            //已关闭
            _orderStateAPP = 5;
        }else if (_orderStateServer == 6){
            //已取消
            _orderStateAPP = 6;
        }
    }
    //异常订单
    if ([key isEqualToString:@"serviceStatus"]) {
        if ([value intValue] == 1) {
            _orderStateAPP = 7;
        }
    }
}

@end
