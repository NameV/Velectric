//
//  SkuPropertyModel.m
//  Velectric
//
//  Created by hongzhou on 2016/12/29.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "SkuPropertyModel.h"

@implementation PropertyModel

@end

@implementation SkuPropertyModel

-(instancetype)init
{
    if (self==[super init]) {
        _propertyList = [NSMutableArray array];
        _selectPropertyList = [NSMutableArray array];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"options"]) {
        NSDictionary * options = value;
        NSArray * keyList = [options allKeys];
        for (NSString * key in keyList) {
            NSString * propertyValue = [NSString stringWithFormat:@"%@",[options objectForKey:key]];
            PropertyModel * model = [[PropertyModel alloc]init];
            model.propertyValue = propertyValue;
            model.properyId = key;
            [_propertyList addObject:model];
        }
    }
    if ([key isEqualToString:@"id"]) {
        _properyId = [NSString stringWithFormat:@"%@",value];
    }
}

@end
