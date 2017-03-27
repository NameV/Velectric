//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.


#import <Foundation/Foundation.h>

#import "SCCategory.h"

@interface SCCategoryDetail : NSObject
/**
 *  头标题
 */
@property (nonatomic, strong) SCCategory *headerCategory;
/**
 *  第三级分类(SCCategory)
 */
@property (nonatomic, strong) NSArray *categories;

@end
