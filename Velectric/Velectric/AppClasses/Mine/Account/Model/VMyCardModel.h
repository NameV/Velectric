//
//  VMyCardModel.h
//  Velectric
//
//  Created by LYL on 2017/2/23.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMyCardModel : NSObject

@property (nonatomic, copy)NSString *code;          //code
@property (nonatomic, copy)NSString *msg;           //响应接口信息，成功或者失败
@property (nonatomic, assign)BOOL binded;           //是否绑卡成功
@property (nonatomic, copy)NSString *bankName; //开户行名称
@property (nonatomic, copy)NSString *name;          //开户行用户姓名
@property (nonatomic, copy)NSString *account;       //用户提现卡号
@property (nonatomic, copy)NSString *mobile;        //银行绑定手机号

@end
