//
//  SYNetworkingManager.m
//  shan
//
//  Created by aDu on 16/2/24.
//  Copyright © 2016年 DuKaiShun. All rights reserved.
//

#import "SYNetworkingManager.h"
#import "Header.h"
#import "Reachability.h"

#define TimeOut 60.f

@implementation SYNetworkingManager

//通用请求
+ (void)GetOrPostWithHttpType:(HttpRequestType)httpType
                WithURLString:(NSString *)urlString
               parameters:(NSDictionary *)parameters
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock
{
    [self httpRequestWithType:httpType WithURLString:urlString parameters:parameters success:successBlock failure:failureBlock];
}

//没有body get的网络请求
+ (void)GetOrPostNoBodyWithHttpType:(HttpRequestType)httpType
                WithURLString:(NSString *)urlString
                   parameters:(NSDictionary *)parameters
                      success:(SuccessBlock)successBlock
                      failure:(FailureBlock)failureBlock
{
    
    [self httpNoBodyRequestWithType:httpType WithURLString:urlString parameters:parameters success:successBlock failure:failureBlock];
}


+ (void)httpRequestWithType:(HttpRequestType)httpType
              WithURLString:(NSString *)urlString
                 parameters:(NSDictionary *)parameters
                    success:(SuccessBlock)successBlock
                    failure:(FailureBlock)failureBlock{
    
    NSLog(@"\n++++++++++++++++++++++++++++++++++++\n%@\n%@\n++++++++++++++++++++++++++++++++++++\n",urlString,parameters);
    
    Reachability * reachability = [Reachability reachabilityForInternetConnection];
    if (reachability.isReachable == false) {
        [VJDProgressHUD showTextHUD:@"您的网络不稳定, 请检查您的网络设置"];
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/ plain"];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TimeOut;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSMutableDictionary * bodyDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    //接口参数
    if (parameters) {
        [paramDic setObject:parameters forKey:@"params"];
    }
    //通用参数
    NSDictionary * commonDic = [self getCommonParams];
    [paramDic setObject:commonDic forKey:@"appdevice"];
    [bodyDic setObject:[self toJSONString:paramDic] forKey:@"body"];
    
    switch (httpType) {
        case HttpRequestTypeGet:
        {
           [manager GET:urlString parameters:bodyDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               if (successBlock) {
                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                   successBlock(dic);
               }
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               if (failureBlock) {
                   failureBlock(error);
                   [self showErrRes:error];
                   NSLog(@"网络异常 - T_T%@", error);
                   NSLog(@"%@%@%ld",error.userInfo,error.domain,error.code);
               }
           }];
        }
            break;
            
        default:
        {
            [manager POST:urlString parameters:bodyDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    successBlock(dic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(error);
                    [self showErrRes:error];
                    NSLog(@"网络异常 - T_T%@", error);
                    NSLog(@"%@%@%ld",error.userInfo,error.domain,error.code);
                }
            }];
        }
            break;
    }
}
//没有body get的网络请求
+ (void)httpNoBodyRequestWithType:(HttpRequestType)httpType
              WithURLString:(NSString *)urlString
                 parameters:(NSDictionary *)parameters
                    success:(SuccessBlock)successBlock
                    failure:(FailureBlock)failureBlock{
    
    NSLog(@"\n++++++++++++++++++++++++++++++++++++\n%@\n%@\n++++++++++++++++++++++++++++++++++++\n",urlString,parameters);
    
    Reachability * reachability = [Reachability reachabilityForInternetConnection];
    if (reachability.isReachable == false) {
        [VJDProgressHUD showTextHUD:@"您的网络不稳定, 请检查您的网络设置"];
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/ plain"];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TimeOut;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    switch (httpType) {
        case HttpRequestTypeGet:
        {
            [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    successBlock(dic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(error);
                    [self showErrRes:error];
                    NSLog(@"网络异常 - T_T%@", error);
                    NSLog(@"%@%@%ld",error.userInfo,error.domain,error.code);
                }
            }];
        }
            break;
            
        default:
        {
            [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    successBlock(dic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(error);
                    [self showErrRes:error];
                    NSLog(@"网络异常 - T_T%@", error);
                    NSLog(@"%@%@%ld",error.userInfo,error.domain,error.code);
                }
            }];
        }
            break;
    }
}


//发送上传文件
+ (void)upLoadImageRequestWithURLString:(NSString *)urlString
                       parameters:(NSDictionary *)parameters
                     withImageData:(NSData *)data
                          success:(SuccessBlock)successBlock
                          failure:(FailureBlock)failureBlock
{
    NSLog(@"\n++++++++++++++++++++++++++++++++++++\n%@\n%@\n++++++++++++++++++++++++++++++++++++\n",urlString,parameters);
    
    Reachability * reachability = [Reachability reachabilityForInternetConnection];
    if (reachability.isReachable == false) {
        [VJDProgressHUD showTextHUD:@"您的网络不稳定, 请检查您的网络设置"];
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/ plain"];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TimeOut;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSMutableDictionary * bodyDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    //接口参数
    if (parameters) {
        [paramDic setObject:parameters forKey:@"params"];
    }
    //通用参数
    NSDictionary * commonDic = [self getCommonParams];
    [paramDic setObject:commonDic forKey:@"appdevice"];
    [bodyDic setObject:[self toJSONString:paramDic] forKey:@"body"];
    
    [manager POST:urlString parameters:bodyDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //第一个参数 上传的图片
        //第二个参数 服务器参数名
        //第三个参数 图片名称
        //第四个参数 上传文件类型
        [formData appendPartWithFileData:data name:@"businessLicenseFile" fileName:@"test.png" mimeType:@""];
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            [self showErrRes:error];
            ELog(@"%@%@%ld",error.userInfo,error.domain,error.code);
        }
    }];
    
}

//获取通用参数
+(NSDictionary *)getCommonParams
{
    //通用参数
    NSDictionary * commonDic = @{@"timestamp":@"",      //服务器时间戳
                                 @"usertoken":@"",      //
                                 @"refreshtoken":@"",   //提供验证码刷新token
                                 @"activetime":@"",     //token有效时间
                                 @"userid":@"",         //用户ID
                                 @"vjdevice":@"",       //系统版本
                                 @"vjplatform":@"2",    //项目平台
                                 @"vjersion":@"1.0",};  //app版本
    return commonDic;
}

+ (void)showErrRes:(NSError *)error{
    if (error.code == 500) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器维护中,无法连接服务器,请稍后在试" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
    }
    if (error.code == 404) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"无法找到文件" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
    }
    if (error.code == 405) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"资源被禁止." delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
    }
}

+ (NSString *)toJSONString:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (jsonData == nil || error != nil) {
        return @"";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (void)configCookie{
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:K_User_Cookie];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}
@end
