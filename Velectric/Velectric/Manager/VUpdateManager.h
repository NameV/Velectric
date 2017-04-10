//
//  VUpdateManager.h
//  Velectric
//
//  Created by LYL on 2017/4/5.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VUpdateManager : NSObject

/* 是否显示去首页的button */
@property (nonatomic, copy) NSString *showBtn;

/**
 *  获取单例对象
 */
+ (instancetype)shareManager ;


/**
 *  检查更新
 */
- (void)checkVersion ;

/**
 *  检查用户审核状态
 */
- (void)checkUserNameState ;

@end
