//
//  VDateManager.m
//  Velectric
//
//  Created by LYL on 2017/3/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VDateManager.h"
#import "VScanHistoryModel.h"
#import "VDateModel.h"

@implementation VDateManager

//获取转换的数组
+ (NSMutableArray *)getArrayWithArray:(NSArray *)array {
    NSMutableArray *mutArray = [NSMutableArray array];
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in array) {
        
        //提起转化
        VScanHistoryModel *model = [VScanHistoryModel yy_modelWithDictionary:dic];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss 'CST' yyyy"];
//        NSDate *date = [dateFormatter dateFromString:model.createTimeStr];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSString *dateSting = [dateFormatter stringFromDate:date];
        
        NSString *dateSting = model.createTimeStr;
        NSString *subDateString = [[dateSting componentsSeparatedByString:@" "] firstObject];
        model.createTimeDetail = [[dateSting componentsSeparatedByString:@" "] lastObject];
        model.createTimeStr = subDateString;
        [mutArray addObject:model];
        
        //去重
        [dateDict setValue:subDateString forKey:subDateString];
    }
    
    //-------------------日期排序--------------------
    //将日期转换成model
    NSMutableArray *sortArray = [NSMutableArray array];
    for (NSString *string in dateDict) {
        VDateModel *dateModel = [[VDateModel alloc]initWithDateString:string];
        dateModel.dateString = string;
        [sortArray addObject:dateModel];
    }
    
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"year" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"month" ascending:YES];
    NSSortDescriptor *sortDescriptor3 = [NSSortDescriptor sortDescriptorWithKey:@"day" ascending:YES];
    
    NSArray *tmpArr1 = [sortArray sortedArrayUsingDescriptors:@[sortDescriptor1,sortDescriptor2,sortDescriptor3]];
    
    NSArray *tmpArr = [[tmpArr1 reverseObjectEnumerator] allObjects];//翻转数组
    
    //---------------------------------------------------------
    
    //-------------------将model重新排序装入二级数组---------------
    
    NSMutableArray *allArray = [NSMutableArray array];
    
    for (int i = 0; i < tmpArr.count; i++) {
        NSString *string = [tmpArr[i] dateString];
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (VScanHistoryModel *model in mutArray) {
            if ([model.createTimeStr isEqualToString:string]) {
                [tmpArray addObject:model];
                NSLog(@"%@",model.createTimeStr);
                //-------------------将今天的日期改为“今天”--------------------
                
                NSDate *currentDate = [NSDate date];//获取当前时间，日期
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateString = [dateFormatter stringFromDate:currentDate];
                NSString *todayString = [[dateString componentsSeparatedByString:@" "] firstObject];
                NSString *tYear = [[todayString componentsSeparatedByString:@"-"] firstObject];
                NSString *tMonth = [todayString componentsSeparatedByString:@"-"] [1];
                NSString *tDay = [todayString componentsSeparatedByString:@"-"] [2];
                
                if ([[model.createTimeStr componentsSeparatedByString:@"-"][0] isEqualToString:tYear] &&
                    [[model.createTimeStr componentsSeparatedByString:@"-"][1] isEqualToString:tMonth]) {
                    if ([[model.createTimeStr componentsSeparatedByString:@"-"][2] isEqualToString:tDay]) {
                        model.createTimeStr = @"今天";
                    }else if (abs([[model.createTimeStr componentsSeparatedByString:@"-"][2] intValue] - [tDay intValue]) == 1) {
                        model.createTimeStr = @"昨天";
                    }
                }
                
                //---------------------------------------------------------
                
            }
        }
        [allArray addObject:tmpArray];
    }
    //-----------------------------------------------------------
    
    return allArray;
}

- (NSString *)getToday {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}


@end
