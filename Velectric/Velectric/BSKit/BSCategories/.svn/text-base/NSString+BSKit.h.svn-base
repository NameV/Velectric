//
//  NSString+BSKit.h
//  StarterKit
//
//  Created by XiaoYang on 15/10/13.
//  Copyright © 2015年 XiaoYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonCrypto/CommonDigest.h"


@interface NSString (BSKit)

/**
 *  去两头空格
 */
- (NSString *)whitespace;

/**
 *  去全部空格
 */
- (NSString *)whiteAllSpace;

/**
 *  随机生成32位字符串
 *
 */
//+ (NSString *)ret32bitString;

/**
 * Calculate the current string md5
 * 32位小写
 */
- (NSString *)MD5Hash;


/**
 * Calculate the specified file md5
 *
 */
+ (NSString *)stringWithMD5OfFile:(NSString *)path;


/**
 * Format the file size
 *
 */
+ (NSString *)formatFileSize:(NSUInteger)filesize;


/**
 * Check if the specified string is empty
 *
 */
+ (BOOL)isStringEmpty:(NSString *)string;

- (BOOL)isEmptyString ;
- (BOOL)isEmpty ;


/**
 * Check if the email string is valid
 *
 */
- (BOOL)isEmail;


/**
 *  Check if the ID string is valid
 *
 */
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

/**
 *  给数目加逗号
 *
 *  @param number   传入值
 *  @param position 小数点位数
 *
 *  @return 带逗号的String
 */
+ (NSString *)stringWithRounding:(NSString *)number afterPoint:(NSInteger)position;



/**
 *  two largest number add
 */
+ (NSString *)addWithBigNums:(NSString *)num1 num2:(NSString *)num2;

/**
 *  截取某段字符串
 */
- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;


//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString;

@end
