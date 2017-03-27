//
//  UserConfig.m
//  WeMicro
//
//  Created by LeeZhe on 16/6/22.
//  Copyright © 2016年 The9 Limited. All rights reserved.
//

#import "UserConfig.h"
@implementation UserConfig
+ (instancetype)sharedUser {
    
    static UserConfig *_instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[UserConfig alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    
    if (self == [super init]) {
        self.device_id = [[UIDevice currentDevice] identifierForVendor].UUIDString;
        self.app_id = 1;
        self.os = 0;//0:iphone 1:android
        self.channel = 1;//1：iphone，2：android，3：pc，4：其他
        self.sex = 0;//0：未知 1:女  2：男
        self.type = 1; //标签类型，1:个人2:公司必须
        self.version = @"1.0.0";
        self.uuid = 181;
    }
    
    return self;
}

@end
