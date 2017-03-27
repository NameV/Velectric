//
//  NSDictionary+VDictionary.m
//  Velectric
//
//  Created by LYL on 2017/3/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "NSDictionary+VDictionary.h"
#import <objc/runtime.h>

@implementation NSDictionary (VDictionary)

+ (void)load {
    
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(em_setObject:forKey:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (void)em_setObject:(id)emObject forKey:(NSString *)key {
    if (emObject == nil) {
        @try {
            [self em_setObject:emObject forKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            emObject = [NSString stringWithFormat:@""];
            [self em_setObject:emObject forKey:key];
        }
        @finally {}
    }else {
        [self em_setObject:emObject forKey:key];
    }
}

@end
