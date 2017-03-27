//
//  VFileMnager.h
//  Velectric
//
//  Created by LYL on 2017/3/1.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HsearchModel.h"

@interface VFileMnager : NSObject


+ (instancetype)sharedInstance;

//清楚历史记录缓存
- (BOOL)removeAllHistoryCache ;


//-----------------------model存取begin-----------------------------

//根据model增加历史搜索记录
- (BOOL)writeHistorySearchToCacheWithModel:(HsearchModel *)model;

//获取历史搜索记录，获取model数组
- (NSArray *)getHistorySearchFromCache ;

//-----------------------model存取end-------------------------------

@end
