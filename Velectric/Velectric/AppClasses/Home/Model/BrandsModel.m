//
//  BrandsModel.m
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "BrandsModel.h"

@implementation BrandsModel

-(instancetype)init
{
    if (self == [super init]) {
        self.Id = [NSNumber numberWithInteger:0];
        self.name = [[NSString alloc]init];
        self.logoOriginUrl = [[NSString alloc]init];
        self.brandId = [NSNumber numberWithInteger:0];
        self.brandName = [[NSString alloc]init];
        self.isSelect = NO;
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
