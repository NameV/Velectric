//
//  VFactoryCollectModel.m
//  Velectric
//
//  Created by LYL on 2017/2/16.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VFactoryCollectModel.h"

@implementation VFactoryCollectModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"collectionManuacturer"   :   [VCollectionManuacturerModel class],
             @"manuacturerIds"          :   [VManuacturerIdsModel class]
             };
}
@end

@implementation VCollectionManuacturerModel

@end

@implementation VManuacturerIdsModel

@end
