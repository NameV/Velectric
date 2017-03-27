//
//  memberMeansController.h
//  Velectric
//
//  Created by QQ on 2016/11/22.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface memberMeansController : BaseViewController
@property (nonatomic,strong)UITextField *realNameField;//公司名称
@property (nonatomic,strong)UITextField *businessLicenseCodeField;//执照编号
@property (nonatomic,strong)UITextField *contactNameField;//联系人
@property (nonatomic,strong)UITextField *mobileField;//联系方式
@property (nonatomic,strong)UITextField *addressField;//详细地址
@property (nonatomic,strong)UITextField *introductorNameField;//介绍人
@property (nonatomic,strong)UITextField *introductorMobileField;//介绍人电话
@property (nonatomic,strong)UITextField *intoMainField;//所在地
@property (nonatomic,strong)UITextField *buyField;//经营范围

@property (nonatomic,strong)NSString *isForm;//来自的界面 1，来自登录  2 来自修改会员审核页面


@end
