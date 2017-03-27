//
//  VGetMoneyModel.h
//  Velectric
//
//  Created by LYL on 2017/2/24.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGetMoneyModel : NSObject

@property (nonatomic, copy) NSString *code;         //返回code码
@property (nonatomic, copy) NSString *msg;          //返回的信息
@property (nonatomic, copy) NSString *acctId;       //用户提现卡号
@property (nonatomic, copy) NSString *totalAmount;  //可提现余额
@property (nonatomic, copy) NSString *mobile;       //银行绑定手机号

@end
