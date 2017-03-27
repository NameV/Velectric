//
//  UserConfig.h
//  WeMicro
//
//  Created by LeeZhe on 16/6/22.
//  Copyright © 2016年 The9 Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConfig : NSObject
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *loginname;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) NSUInteger sex;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, assign) NSUInteger uuid;
@property (nonatomic, assign) NSUInteger app_id;
@property (nonatomic, strong) NSString *device_id;
@property (nonatomic, assign) NSUInteger os;
@property (nonatomic, assign) NSUInteger channel;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, assign) NSString * version;

+ (instancetype)sharedUser;
@end
