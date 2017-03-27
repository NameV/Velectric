//
//  VProductDetailModel.m
//  Velectric
//
//  Created by LYL on 2017/2/28.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VProductDetailModel.h"

@implementation VProductDetailModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"ogvs"   :   [VProductDetailCellModel class]
             };
}

@end

@implementation VProductDetailCellModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ident" : @"id"};
}

@end
