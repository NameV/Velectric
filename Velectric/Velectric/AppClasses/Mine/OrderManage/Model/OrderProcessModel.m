//
//  OrderProcessModel.m
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "OrderProcessModel.h"

@implementation OrderProcessModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        _myDescription = value;
    }
}

@end
