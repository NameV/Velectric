//
//  SignAssistant.m
//  WeMicro
//
//  Created by pengjingli on 16/6/22.
//  Copyright © 2016年 The9 Limited. All rights reserved.
//

#import "SignAssistant.h"
#import <CommonCrypto/CommonDigest.h>

static NSString * const EncryptionKey = @"&key=DALASIgn7gXLvCu8h620o8buYT3";

@implementation SignAssistant
+ (instancetype)sharedAssistant {
    
    static SignAssistant *_instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[SignAssistant alloc] init];
    });
    
    return _instance;
}

- (NSMutableDictionary *)signedParametersWithParameters:(NSDictionary *)parameters {
    
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSMutableArray *keyValuePairs = [self sortedKeyValuePairs:mutableDictionary];
    
    NSString *signString = [self signWithKeyValuePairs:keyValuePairs type:2];
    
    [mutableDictionary addEntriesFromDictionary:@{@"sign":[self md5:signString]}];
    
    return mutableDictionary;
}

- (NSMutableDictionary *)wxSignesParmerersWithParters:(NSDictionary *)paramters{
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:paramters];
    NSMutableArray *keyValuePairs = [self sortedKeyValuePairs:mutableDictionary];
    
    NSString *signString = [self signWithKeyValuePairs:keyValuePairs type:2];
   // [mutableDictionary addEntriesFromDictionary:@{@"sign" : [signString.MD5 uppercaseString]}];
    return mutableDictionary;
}

- (NSMutableArray *)sortedKeyValuePairs:(NSDictionary *)parameters {
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *sortedKeys = [[parameters allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    __block NSMutableArray *keyValuePairs = [NSMutableArray array];
    
    [sortedKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = obj;
        NSString *val = [parameters valueForKey:obj];
        if (key && val) {
            if ([val isKindOfClass:[NSString class]]) {
             val =  [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if (val.length != 0) {
                    NSString *keyValuePair = [NSString stringWithFormat:@"%@=%@", key, val];
                    [keyValuePairs addObject:keyValuePair];
                }
            }else{
                NSString *keyValuePair = [NSString stringWithFormat:@"%@=%@", key, val];
                [keyValuePairs addObject:keyValuePair];
            }
        }
    }];
    return keyValuePairs;
}

- (NSString *)signWithKeyValuePairs:(NSMutableArray *)keyValuePairs type:(NSInteger)type{
    
    if (type == 1) {
        return [[keyValuePairs componentsJoinedByString:@"&"] stringByAppendingString:EncryptionKey];
    }
    
    return [[keyValuePairs componentsJoinedByString:@"&"] stringByAppendingString:EncryptionKey];
}

- (NSString *)md5:(NSString *)someString {
    
    const char *cStr = [someString UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],   result[3],
            result[4],  result[5],  result[6],   result[7],
            result[8],  result[9],  result[10],  result[11],
            result[12], result[13], result[14],  result[15]];
}

@end
