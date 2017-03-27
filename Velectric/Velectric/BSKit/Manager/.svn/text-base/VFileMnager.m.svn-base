//
//  VFileMnager.m
//  Velectric
//
//  Created by LYL on 2017/3/1.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VFileMnager.h"
#import "VFileManagerHistoryModel.h"

#define Name @"name"
#define Time @"time"
#define HistorySearch @"HistorySearch.plist"

static VFileMnager *_instance;

@implementation VFileMnager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


//-----------------------model存取begin-----------------------------

//增加历史记录
- (BOOL)writeHistorySearchToCacheWithModel:(HsearchModel *)model  {
    
    //新的数据
//    NSString *newString = [model yy_modelToJSONString];
    NSDictionary *newDic = [model yy_modelToJSONObject];
    
    NSString *filePath = [self getPathWithName:HistorySearch];
    NSMutableArray *allArray = [[NSArray arrayWithContentsOfFile:filePath] mutableCopy];
    if (!allArray) {
        allArray = [NSMutableArray array];
    }
    
    //---------------判断，如果存在，移除旧的--------------
    for (int i = 0; i < allArray.count; i++) {
        NSDictionary *oldDic = allArray[i];
        if ([oldDic isEqualToDictionary:newDic]) {
            [allArray removeObject:oldDic];//移除旧的
        }
    }
    //------------------------------------------------
    
    [allArray addObject:newDic];//增加新的
    
    BOOL result = [allArray writeToFile:filePath atomically:YES];
    
    return result;
}

//获取历史记录
- (NSArray *)getHistorySearchFromCache  {
    NSString *filePath = [self getPathWithName:HistorySearch];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        //用yymodel转换的话，会将空值转化为0，所以用这种方式转化
        HsearchModel * model = [[HsearchModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
//        HsearchModel *model = [HsearchModel yy_modelWithDictionary:dic];//不可用这种方式转化
        [mutArray addObject:model];
    }
    return [[mutArray reverseObjectEnumerator]allObjects];
}

//-----------------------model存取end-------------------------------

//------------------------字符串存取begin---------------------------

//增加历史搜索记录
-(BOOL)addRecordWithName:(NSString *)name {
    
    //---------------将数据转化成字典--------------------
    
    NSDictionary *newDic = @{@"name"    :   name,
                             @"time"    :   [self getTodayDate]
                             };
    
    //------------------------------------------------
    
    NSString *filePath = [self getPathWithName:HistorySearch];
    NSMutableArray *allArray = [[NSArray arrayWithContentsOfFile:filePath] mutableCopy];
    if (!allArray) {
        allArray = [NSMutableArray array];
    }
    
    //---------------判断，如果存在，移除旧的--------------
    for (int i = 0; i < allArray.count; i++) {
        NSDictionary *dic = allArray[i];
        if ([name isEqualToString:dic[Name]]) {
            [allArray removeObject:dic];//移除旧的
        }
    }
    //------------------------------------------------
    
    [allArray addObject:newDic];//增加新的
    
    BOOL result = [allArray writeToFile:filePath atomically:YES];
    
    return result;
}


//获取历史存储数据，数组里面是字典
- (NSArray *)getHistorySearch {
    NSString *filePath = [self getPathWithName:HistorySearch];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    
    return [[array reverseObjectEnumerator]allObjects];
}

//获取历史存储数据，数组里面是model
- (NSArray *)getHistorySearchModelArray {
    NSString *filePath = [self getPathWithName:HistorySearch];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        VFileManagerHistoryModel *model = [VFileManagerHistoryModel yy_modelWithDictionary:dic];
        [mutArray addObject:model];
    }
    return [[mutArray reverseObjectEnumerator]allObjects];
}

//------------------------字符串存取end-----------------------------

//清楚历史记录缓存
- (BOOL)removeAllHistoryCache {
    NSString *filePath = [self getPathWithName:HistorySearch];
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
}

//获取现在的时间
- (NSString *)getTodayDate {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}


//获取文件路径
- (NSString *)getPathWithName:(NSString *)fileName {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    return filePath;
}




@end
