//
//  FactoryModel.m
//  Velectric
//
//  Created by user on 2016/12/29.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "FactoryModel.h"

@implementation FactoryModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _count = 0;
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.Id = [NSString stringWithFormat:@"%@",value] ;
    }
    if ([key isEqualToString:@"productName_ik"]) {
        self.name = [NSString stringWithFormat:@"%@",value] ;
    }
    if ([key isEqualToString:@"price"]) {
        self.minPrice = [value floatValue] ;
    }
    if ([key isEqualToString:@"defaultGoodsPictureUrl"]) {
        self.pictureUrl = [NSString stringWithFormat:@"%@",value] ;
    }

}

@end
