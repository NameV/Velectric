//
//  HomeHotGoodsModel.m
//  Velectric
//
//  Created by hongzhou on 2016/12/27.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "HomeHotGoodsModel.h"

@implementation HomeGoodsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.myId = [value integerValue];
    }
    else if ([key isEqualToString:@"defaultTitle"]) {
        self.name = value;
    }
    else if ([key isEqualToString:@"defaultPrice"]) {
        self.minPrice = [value floatValue];
    }
    else if ([key isEqualToString:@"defaultImageUrl"]) {
        self.pictureUrl = value;
    }
}

@end

@implementation HomeHotGoodsModel

-(instancetype)init
{
    if (self==[super init]) {
        _goodsList = [NSMutableArray array];
    }
    return self;
}

@end
