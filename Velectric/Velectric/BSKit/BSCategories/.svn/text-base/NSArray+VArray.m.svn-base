//
//  NSArray+VArray.m
//  Velectric
//
//  Created by LYL on 2017/3/17.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "NSArray+VArray.h"
#import <objc/runtime.h>

@implementation NSArray (VArray)


//方式数组崩溃
+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{  //方法交换只要一次就好
        Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(__nickyTsui__objectAtIndex:));
        method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    });
}

- (id)__nickyTsui__objectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self __nickyTsui__objectAtIndex:index];
        } @catch (NSException *exception) {
            //__throwOutException  抛出异常
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self __nickyTsui__objectAtIndex:index];
    }
}

@end
