//
//  NSDate+BY.m
//  千丁
//
//  Created by snake on 14-11-13.
//  Copyright (c) 2014年 www.qdingnet.com. All rights reserved.
//


#define KOneYearM  (60*60*24*365*1000.f)
#import "NSDate+BY.h"


@implementation NSDate (BY)
/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}


/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}


+ (NSString *) compareDate:(NSDate *)date {
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    NSString * yesterdayString = [[yesterday stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    
    NSString * dateString = [[date stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone=[NSTimeZone defaultTimeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *destDateString = [dateFormatter stringFromDate:date];
        return destDateString;
    }
}

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+ (NSString *) compareCurrentTime:(NSDate*) compareDate {
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

- (NSString *)stringDateWithFormatterStr:(NSString *)str
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.timeZone=[NSTimeZone defaultTimeZone];
    fmt.dateFormat =str;
    NSString *selfStr = [fmt stringFromDate:self];
    return selfStr;
}

+ (NSString *)getDateStringWithBigStringStyle:(NSString *)string withFormatterStr:(NSString *)str
{
    NSString * formatStr = @"yyyy-MM-dd HH:mm:ss";
    if (!str) {
        str = formatStr;
    }
    if (string==nil) {
        return @"";
    }
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    NSNumber *number = [fmt numberFromString:string];
    NSNumber *smallNumber=[NSNumber numberWithDouble:number.doubleValue/1000.f];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:smallNumber.doubleValue];

    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.timeZone=[NSTimeZone defaultTimeZone];
    [dateFormatter setDateFormat:str];
    NSString *dateStr=[dateFormatter stringFromDate:date];
    return dateStr;
}

/**
 *  返回字符串类型的距1970的毫秒
 */
+ (NSString *)millisecondIntervalSince1970
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    NSString *curTime = [NSString stringWithFormat:@"%llu",dTime];
    return curTime;
}


/**
 *  返回NSTimeInterval对应的字符串类型的毫秒值
 */
+ (NSString *)stringMillisecondWithTimeInterval:(NSTimeInterval)time
{
    long long dTime = [[NSNumber numberWithDouble:time * 1000] longLongValue];
    NSString *curTime = [NSString stringWithFormat:@"%llu",dTime];
    return curTime;
}

/**
 *  返回String日期对应的字符串类型的毫秒
 */
+ (NSTimeInterval)timeIntervalWithTimeString:(NSString *)time
{
    NSString * formatStr = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatStr];
    NSDate * date = [dateFormatter dateFromString:time];
    NSTimeInterval timeInterval = [date timeIntervalSince1970]* 1000;
    return timeInterval;
}

- (NSDate_BYDate_Instrus)getDateInstrus
{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    NSString * yesterdayString = [[yesterday stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    
    NSString * dateString = [[self stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    if ([dateString isEqualToString:todayString])
    {
        return NSDate_BYDate_Instrus_Today;
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return NSDate_BYDate_Instrus_Yesterday;
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return NSDate_BYDate_Instrus_Tomorrow;
    }
    else {
        return NSDate_BYDate_Instrus_OtherDays;
    }
}

/**
 *  将时间戳转换为NSDate
 */
+ (NSDate *)getDateWithTimestamp:(NSString *)timestampStr {
    NSDate *date = nil;
    if (timestampStr.length > 0) {
        NSTimeInterval interval = [timestampStr doubleValue] / 1000.0;
        date = [NSDate dateWithTimeIntervalSince1970:interval];
    }
    return date;
}

@end
