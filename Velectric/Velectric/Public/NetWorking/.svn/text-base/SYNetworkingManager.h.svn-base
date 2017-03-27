//
//  SYNetworkingManager.h
//  shan
//
//  Created by aDu on 16/2/24.
//  Copyright © 2016年 DuKaiShun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(NSDictionary *responseObject);
typedef void (^FailureBlock)(NSError *error);
typedef NS_ENUM(NSInteger,HttpRequestType) {
   HttpRequestTypeGet = 1,

   HttpRequestTypePost = 2
};

@interface SYNetworkingManager : NSObject

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;

/**
 *  发送get/post请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param successBlock    请求成功的回调
 *  @param failureBlock    请求失败的回调
 *  @param httpType   请求方式
 */
+ (void)GetOrPostWithHttpType:(HttpRequestType)httpType
                WithURLString:(NSString *)urlString
                   parameters:(NSDictionary *)parameters
                      success:(SuccessBlock)successBlock
                      failure:(FailureBlock)failureBlock;
/**
 *  发送没有body请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param successBlock    请求成功的回调
 *  @param failureBlock    请求失败的回调
 *  @param httpType   请求方式
 */

+ (void)GetOrPostNoBodyWithHttpType:(HttpRequestType)httpType
                      WithURLString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
                            success:(SuccessBlock)successBlock
                            failure:(FailureBlock)failureBlock;

/**
 *  发送上传文件 只有post方式
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param successBlock    请求成功的回调
 *  @param failureBlock    请求失败的回调
 */

+ (void)upLoadImageRequestWithURLString:(NSString *)urlString
                             parameters:(NSDictionary *)parameters
                          withImageData:(NSData *)data
                                success:(SuccessBlock)successBlock
                                failure:(FailureBlock)failureBlock;

@end
