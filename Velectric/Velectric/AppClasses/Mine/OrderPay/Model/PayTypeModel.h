//
//  PayTypeModel.h
//  Velectric
//
//  Created by hongzhou on 2017/1/9.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayTypeModel : NSObject

//id
@property (strong,nonatomic) NSNumber * Id;

//尾号
@property (strong,nonatomic) NSString * descript;

//logo图片
@property (strong,nonatomic) NSString * iconUrl;

//手机号
@property (strong,nonatomic) NSString * code;

@end
