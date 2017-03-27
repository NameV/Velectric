//
//  AddressManageVC.h
//  Velectric
//
//  Created by hongzhou on 2016/12/13.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>

//进入来源
typedef enum{
    AddressManageEnterSource_Mine          = 1,//个人中心
    AddressManageEnterSource_Order         = 2,//创建订单
}AddressManageEnterSource;

@class AddressModel;

@interface AddressManageVC : BaseViewController

@property (assign,nonatomic) AddressManageEnterSource enterSource;

@property (copy,nonatomic) void (^chooseAddressBlcok)(AddressModel * model);

@end
