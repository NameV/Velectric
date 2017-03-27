//
//  OrderListModel.m
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "OrderListModel.h"
#import "GoodsModel.h"


@implementation OrderListModel

-(instancetype)init
{
    if (self==[super init]) {
        _goodsList = [NSMutableArray array];
    }
    return self;
}

//-------------------之前代码
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
            //已完成(已关闭)
            _orderStateAPP = 5;
        }else if (_orderStateServer == 6){
            //已取消
            _orderStateAPP = 6;
        }
    }
    
        if ([key isEqualToString:@"serviceStatus"]) {
            if ( [value intValue] == 1) {
                //serviceStatus=1  表示异常
                _orderStateAPP = 7;
            }
        }
    if ([key isEqualToString:@"products"]){
        NSArray * products = value;
        for (NSDictionary * goodsDic in products){
            GoodsModel * goods = [[GoodsModel alloc]init];
            [goods setValuesForKeysWithDictionary:goodsDic];
            [_goodsList addObject:goods];
        }
    }
}
//-------------------之前代码

//-(void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    if ([key isEqualToString:@"orderState"]) {
//        _orderStateServer = [value intValue];
//        if ( [value intValue] == 1) {
//            //待付款
//            _orderStateAPP = 1;
//        }else if ([value intValue] == 2){
//            //待受理
//            _orderStateAPP = 2;
//        }else if ([value intValue] == 6 || [value intValue] == 4 || [value intValue] == 9){
//            //待收货
//            _orderStateAPP = 3;
//        }else if ([value intValue] == 10){
//            //已完成
//            _orderStateAPP = 5;
//        }else if ([value intValue] == 11){
//            //已取消
//            _orderStateAPP = 6;
//        }
//    }
//    
//    if ([key isEqualToString:@"serviceStatus"]) {
//        if ( [value intValue] == 1) {
//            //serviceStatus=1  表示异常
//            _orderStateAPP = 7;
//        }
//    }
//    if ([key isEqualToString:@"products"]){
//        NSArray * products = value;
//        for (NSDictionary * goodsDic in products){
//            GoodsModel * goods = [[GoodsModel alloc]init];
//            [goods setValuesForKeysWithDictionary:goodsDic];
//            [_goodsList addObject:goods];
//        }
//    }
//}

////    0:表示所有
//public static final int STATE_ALL=0;
//
////    1：表示代付款(1)
//public static final int STATE_UNPAID =1;
//
////    2：表示待受理(2)
//public static final int STATE_UNACCEPTED =2;
//
////    3：表示待收货(4,6,9)
//public static final int STATE_UNGOT =3;
////    4：表示已完成(7),已完成和已取消的时间间隔不到1s,不做区分，直接为已关闭
//public static final int STATE_GOT =4;
////    5：表示已取消(10)
//public static final int STATE_CANCELLED =5;
////    6：表示已关闭(11)
//public static final int STATE_CLOSED=6;

@end
