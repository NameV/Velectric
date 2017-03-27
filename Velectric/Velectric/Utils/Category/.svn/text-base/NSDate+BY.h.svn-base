//
//  NSDate+BY.h
//  千丁
//
//  Created by snake on 14-11-13.
//  Copyright (c) 2014年 www.qdingnet.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 日期介绍
 */
typedef enum
{
    NSDate_BYDate_Instrus_Today = 0,   // 今天
    NSDate_BYDate_Instrus_Yesterday,   // 昨天
    NSDate_BYDate_Instrus_Tomorrow,    // 明天
    NSDate_BYDate_Instrus_OtherDays    // 其它日期
}NSDate_BYDate_Instrus;

@interface NSDate (BY)
/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;


/**
 *  返回一个只有年月日的时间字符 yyyy年MM月dd日
 */
- (NSString *)stringDateWithFormatterStr:(NSString *)str;
/**
 *  根据NSDate返回昨天还是明天的字符串
 */
+ (NSString *) compareDate:(NSDate *)date;
//同上，扩展
+ (NSString *) compareCurrentTime:(NSDate*) compareDate;

/**
 *  根据一个自1970年的秒数返回一个yyyy/MM/dd格式的日期字符
 *  这个是毫秒
 */
+(NSString *)getDateStringWithBigStringStyle:(NSString *)string withFormatterStr:(NSString *)str;

/**
 *  返回字符串类型的距1970的毫秒
 */
+ (NSString *)millisecondIntervalSince1970;

/**
 *  返回NSTimeInterval对应的字符串类型的毫秒值
 */
+ (NSString *)stringMillisecondWithTimeInterval:(NSTimeInterval)time;

/**
 *  返回String日期对应的字符串类型的毫秒
 */
+ (NSTimeInterval)timeIntervalWithTimeString:(NSString *)time;

/**
 *  获取日期介绍：今天、明天、昨天，或其它日期
 *
 *  @return 日期介绍枚举值
 */
- (NSDate_BYDate_Instrus)getDateInstrus;

/**
 *  将时间戳转换为NSDate
 */
+ (NSDate *)getDateWithTimestamp:(NSString *)timestampStr;

@end
