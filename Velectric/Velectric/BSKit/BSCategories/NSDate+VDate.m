//
//  NSDate+VDate.m
//  Velectric
//
//  Created by LYL on 2017/3/15.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "NSDate+VDate.h"

@implementation NSDate (VDate)

+ (NSString *)getNowDate {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
}

@end
