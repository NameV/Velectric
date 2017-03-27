//
//  VDateModel.m
//  Velectric
//
//  Created by LYL on 2017/3/2.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VDateModel.h"

@implementation VDateModel

- (instancetype)initWithDateString:(NSString *)string {
    self = [super init];
    if (self) {
        NSArray *array = [string componentsSeparatedByString:@"-"];
        _year = array[0];
        _month = array[1];
        _day = array[2];
    }
    return self;
}

@end
