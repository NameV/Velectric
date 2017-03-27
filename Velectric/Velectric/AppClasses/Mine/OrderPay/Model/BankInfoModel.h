//
//  BankInfoModel.h
//  Velectric
//
//  Created by hongzhou on 2016/12/16.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankInfoModel : NSObject

//名称
@property (strong,nonatomic) NSString * plantBankName;
//尾号
@property (strong,nonatomic) NSString * accountNo;
//logo图片
@property (strong,nonatomic) NSString * logoUrl;
//手机号
@property (strong,nonatomic) NSString * telephone;
//支付银行卡id
@property (strong,nonatomic) NSString * bindId;
//银行key
@property (strong,nonatomic) NSString * plantBankId;

@property (strong,nonatomic) NSString * plantId;

@end
