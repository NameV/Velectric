//
//  NewAddressVC.h
//  Tourph
//
//  Created by yanghongzhou on 16/2/16.
//  Copyright © 2016年 yanghongzhou. All rights reserved.
//

#import "BaseViewController.h"

@interface NewAddressVC : BaseViewController

@property (strong,nonatomic) NSNumber * addressId;

//添加成功或者修改地址成功回调
@property (copy,nonatomic) void (^insertAddressBlcok)();

//请求地址信息
-(void)requestAddressData;

@end
