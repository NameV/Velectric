//
//  CartListModel.m
//  Velectric
//
//  Created by user on 2016/12/24.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "CartListModel.h"
#import "CartModel.h"

@implementation CartListModel

-(instancetype)init
{
    if (self==[super init]) {
        _cartList = [NSMutableArray array];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"basketItems"]) {
        NSDictionary * basketItems = value;
        NSArray * keyList1 = [basketItems allKeys];
        for (NSString * key1 in keyList1) {
            NSDictionary * dic = [basketItems objectForKey:key1];
            CartModel * cartModel = [[CartModel alloc]init];
            [cartModel setValuesForKeysWithDictionary:dic];
            [_cartList addObject:cartModel];
        }
    }
}

@end
