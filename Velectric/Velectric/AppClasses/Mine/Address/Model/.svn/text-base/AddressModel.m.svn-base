//
//  AddressModel.m
//  Tourph
//
//  Created by yanghongzhou on 16/2/16.
//  Copyright © 2016年 yanghongzhou. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:_myId forKey:@"id"];
    [dic setValue:_recipient forKey:@"recipient"];
    [dic setValue:_mobile forKey:@"mobile"];
    [dic setValue:_address forKey:@"address"];
    [dic setValue:[NSNumber numberWithInteger:_regionId] forKey:@"regionId"];
    [dic setValue:_regionName forKey:@"regionName"];
    [dic setValue:_defaulted forKey:@"defaulted"];
    return dic;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.myId = [NSNumber numberWithInteger:[value integerValue]];
    }
}

@end
