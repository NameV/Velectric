//
//  VGoodsCollectModel.m
//  Velectric
//
//  Created by LYL on 2017/2/16.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VGoodsCollectModel.h"

@implementation VGoodsCollectModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"collectionProduct"   :   [VGoodsCollectCellModel class]
             };
}

@end


@implementation VGoodsCollectCellModel

@end
