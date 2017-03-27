//
//  NSString+Category.m
//  Tourph
//
//  Created by yanghongzhou on 16/1/19.
//  Copyright © 2016年 yanghongzhou. All rights reserved.
//


#import "NSString+Category.h"

@implementation NSString (Category)

//获取文字宽度
-(CGFloat)getStringWidthWithFont:(UIFont *)font
{
    NSString * string = self.length ? self:@"";
    CGSize size = [string boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width;
}

//获取文字高度
-(CGSize)stringWithFont:(UIFont *)font andSize:(CGSize)contentSize
{
    NSString * string = self.length ? self:@"";
    CGSize size = [string boundingRectWithSize:CGSizeMake(contentSize.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}

//验证是否为空或者输入空格 YES：表示有空格或者为空    NO：表示输入正常文本
-(BOOL)stringValidateSpaceAndNULL
{
    NSString * string = self.length ? self:@"";
    if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]) {
        return YES;
    }else{
        return NO;
    }
}

//JSON字符串转化为字典
-(NSDictionary *)getDictionaryFromJosnString
{
    NSString * string = self.length ? self:@"";
    NSError * error = nil;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if (!error) {
        return dic;
    }
    return nil;
}

@end
