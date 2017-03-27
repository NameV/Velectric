//
//  VJDUserManager.m
//  Velectric
//
//  Created by user on 2016/12/17.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "VJDUserManager.h"

@implementation VJDUserManager
@synthesize userInfo;

+ (VJDUserManager *)sharedManager
{
    static VJDUserManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        sharedAccountManagerInstance.userInfo = [UserDefaults objectForKey:@"userinfo"];
        
    });
    return sharedAccountManagerInstance;
}
//储存用户信息

-(void)setUserInfo:(NSDictionary *)info{
    if (info) {
        
        [UserDefaults setObject:info forKey:@"userinfo"];
        [UserDefaults synchronize];
        userInfo = info;
        self.loginName = self.userInfo[@"loginName"]?self.userInfo[@"loginName"]:@"";
        self.mobile = self.userInfo[@"mobile"]?self.userInfo[@"mobile"]:@"";
        self.memberId = self.userInfo[@"memberId"]?self.userInfo[@"memberId"]:@"";
        NSString * status = [NSString stringWithFormat:@"%@",self.userInfo[@"perfectStatus"]];
        self.perfectStatus = status ? status :  @"";
    }
}

//清除用户信息
- (void)clearInfo{
    
    self.userInfo = nil;
    [UserDefaults setObject:nil forKey:@"userinfo"];
    [UserDefaults synchronize];
    [UserDefaults setBool:nil forKey:DEFINE_STRING_LOGIN];
}
//获取用户信息
- (NSDictionary *)getUserInfo{
    NSDictionary *dic = [UserDefaults objectForKey:@"userinfo"];
    if (dic) {
        return dic;
    }
    return nil;
}
//获取会员id
- (NSString *)getId{

    return self.userInfo[@"memberId"];
}
//获取用户名
- (NSString *)get{
    
    return self.userInfo[@"memberId"];
}

@end
