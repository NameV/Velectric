//
//  VJDUserManager.h
//  Velectric
//
//  Created by user on 2016/12/17.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VJDUserManager : NSObject
@property (strong, nonatomic) NSDictionary *userInfo;//储存用户信息
@property (strong, nonatomic) NSString * memberId;//会员id
@property (strong, nonatomic) NSString * loginName;//登录名loginName
@property (strong, nonatomic) NSString * mobile;//获取登录的手机号
@property (strong, nonatomic) NSString * perfectStatus;////会员个人中心资料完善度标识 1已完善 0未完善


/*  获取单利
*
*  @return 单利
*/
+ (VJDUserManager *)sharedManager;
/*
 *
 *  @return 获取会员的ID
 */
- (NSString *)getId;
/*
 *
 *  @return 清除存入的信息
 */
- (void)clearInfo;

//获取用户信息
- (NSDictionary *)getUserInfo;
 
@end
