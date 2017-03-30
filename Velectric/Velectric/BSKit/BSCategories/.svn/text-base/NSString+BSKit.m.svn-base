//
//  NSString+BSKit.m
//  StarterKit
//
//  Created by XiaoYang on 15/10/13.
//  Copyright © 2015年 XiaoYang. All rights reserved.
//

#import "NSString+BSKit.h"
//#import "NSDate+BSKit.h"

@implementation NSString (BSKit)

- (NSString *)whitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
}


//- (NSString *)whiteAllSpace {
//    NSString *string = [[self whitespace] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    return string;
//}
//
//+ (NSString *)ret32bitString {
//    char data[32];
//    
//    for (int x=0;x < 32; data[x++] = (char)('A' + (arc4random_uniform(26))));
//    
//    NSString *retString = [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
//    NSString *date = [[NSDate date] formatTimeYMDHMS];
//    return [NSString stringWithFormat:@"%@%@", retString, date];
//}

- (NSString *)MD5Hash {
    CC_MD5_CTX md5;
    CC_MD5_Init (&md5);
    CC_MD5_Update (&md5, [self UTF8String], (CC_LONG)[self length]);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (digest, &md5);
    NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0],  digest[1],
                   digest[2],  digest[3],
                   digest[4],  digest[5],
                   digest[6],  digest[7],
                   digest[8],  digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
}

+ (NSString *)stringWithMD5OfFile:(NSString *)path {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath: path];
    if (handle == nil) {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init (&md5);
    
    BOOL done = NO;
    
    while (!done) {
        NSData *fileData = [[NSData alloc] initWithData: [handle readDataOfLength: 4096]];
        NSAssert([fileData length] > UINT32_MAX, @"too big");
        CC_MD5_Update (&md5, [fileData bytes], (CC_LONG)[fileData length]);
        
        if ([fileData length] == 0) {
            done = YES;
        }
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (digest, &md5);
    NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0],  digest[1],
                   digest[2],  digest[3],
                   digest[4],  digest[5],
                   digest[6],  digest[7],
                   digest[8],  digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
}


+ (NSString *)formatFileSize:(NSUInteger)filesize {
    
    if (filesize < 1024) {
        return [NSString stringWithFormat:@"%luB", (unsigned long)filesize];
    }
    
    NSUInteger kb = filesize/1024;
    if (kb < 1024) {
        return [NSString stringWithFormat:@"%zdKB", kb];
    }
    
    NSUInteger mb = kb/1024;
    if (mb < 1024) {
        return [NSString stringWithFormat:@"%zdMB", mb];
    }
    
    NSUInteger gb = mb/1024;
    if (gb < 1024) {
        return [NSString stringWithFormat:@"%zdGB", gb];
    }
    
    NSUInteger tb = gb/1024;
    return [NSString stringWithFormat:@"%zdTB", tb];
}


+ (BOOL)isStringEmpty:(NSString *)string {
    if (!string) {
        return YES;
    }
    
    if ([string length] == 0) {
        return YES;
    }
    
    if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isEmpty {
    if (!self) {
        return YES;
    }
    
    if ([self length] == 0) {
        return YES;
    }
    
    if (![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return YES;
    }
    
    if ([self isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}
- (BOOL)isEmptyString {
    if (!self) {
        return YES;
    }
    
    if (self == nil || self == NULL) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([self length] == 0) {
        return YES;
    }
    
    if (![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return YES;
    }
    
    if ([self isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}


- (BOOL)isEmail {
    NSString *emailRegEx = @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (NSString *)stringWithRounding:(NSString *)number afterPoint:(NSInteger)position {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithString:number];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    
    return [numFormat stringFromNumber:roundedOunces];
}


+ (NSString *)addWithBigNums:(NSString *)num1 num2:(NSString *)num2 {
    NSString *result = [NSString string];
    //确保num1大些，如果不是，则调换。
    if(num1.length < num2.length){
        result =[NSString stringWithString:num1];
        num1 =[NSString stringWithString:num2];
        num2 =[NSString stringWithString:result];
        result = [NSString string];
    }
    //进位
    int carryBit = 0;
    //加法的最大位
    int largestBit = 0;
    for(int i = 1; i <= num2.length ; i++) {
        //num1 的当前位
        int intNum1 = [[num1 substringWithRange:NSMakeRange(num1.length - i, 1)] intValue];
        //num2 的当前位
        int intNum2 = [[num2 substringWithRange:NSMakeRange(num2.length - i, 1)] intValue];
        int intTemp = intNum1 + intNum2 + carryBit;
        
        if(intTemp > 9){
            carryBit = 1;
            result = [NSString stringWithFormat:@"%d%@",intTemp % 10,result];
        }
        else {
            carryBit = 0;
            result = [NSString stringWithFormat:@"%d%@",intTemp,result];
        }
        
        if(i == num2.length) {
            if(num1.length == num2.length) {
                if(carryBit) result = [NSString stringWithFormat:@"%d%@",carryBit,result];
            }
            else {
                largestBit = [[num1 substringWithRange:NSMakeRange(num1.length - i - 1, 1)] intValue];
                NSString *restStringOfNum1 = [num1 substringWithRange:NSMakeRange(0, num1.length - num2.length)];
                NSInteger largestNum2 = largestBit + carryBit;
                NSString *restStringOfNum11 = [num1 substringWithRange:NSMakeRange(0, num1.length - num2.length - 1)];
                
                if (largestNum2 < 9) {
                    result = [NSString stringWithFormat:@"%@%zd%@", restStringOfNum11, largestNum2, result];
                }
                else {
        
                    for (int j = 1; j <= restStringOfNum1.length; j++) {
                        int restNum = [[restStringOfNum1 substringWithRange:NSMakeRange(restStringOfNum1.length - j, 1)] intValue];
                        int restTemp = restNum + carryBit;
                        
                        if (restTemp > 9) {
                            carryBit = 1;
                            result = [NSString stringWithFormat:@"%d%@",restTemp % 10,result];
                        }
                        else {
                            carryBit = 0;
                            result = [NSString stringWithFormat:@"%d%@",restTemp,result];
                        }
                        
                        if (j == restStringOfNum1.length) {
                            if(carryBit) result = [NSString stringWithFormat:@"%d%@",carryBit,result];
                        }
                        
                    }
                }
                
            }
        }
    }
    return result;
}

// 截取字符串方法封装//

- (NSString
   *)subStringFrom:(NSString
                    *)startString to:(NSString
                                      *)endString{
    NSRange
    startRange = [self
                  rangeOfString:startString];
    NSRange
    endRange = [self
                rangeOfString:endString];
    NSRange
    range = NSMakeRange(startRange.location
                        + startRange.length,
                        endRange.location
                        - startRange.location
                        - startRange.length);
    return
    [self
     substringWithRange:range];
}

@end
