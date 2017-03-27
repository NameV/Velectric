//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "SCCategory.h"

@implementation SCCategory

// 解决属性名与服务器参数key不一致的问题
+ (NSDictionary *)replacedKeyFromPropertyName {
    
    // key是属性名, value是参数名
    return @{@"detail_description" : @"description"};
}

@end
