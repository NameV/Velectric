//
//  GoodsModel.m
//  Velectric
//
//  Created by hongzhou on 2016/12/17.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.myId = [value integerValue];
    }
    if ([key isEqualToString:@"text"]){
        _goodsSpecs = value;
    }
}

@end
