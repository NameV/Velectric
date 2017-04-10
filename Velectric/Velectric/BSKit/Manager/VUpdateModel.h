//
//  VUpdateModel.h
//  Velectric
//
//  Created by LYL on 2017/4/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VUpdateModel : NSObject

/* //是否强制更新，N-否，Y-是 */
@property (nonatomic, copy) NSString *type;

/* 下载地址 */
@property (nonatomic, copy) NSString *url;

/* 版本  */
@property (nonatomic, copy) NSString *version;

/* 1-显示，0-不显示【ios才有此标识，安卓没有】 */
@property (nonatomic, copy) NSString *show;

@end
