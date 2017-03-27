//
//  MemberInfoVC.h
//  Velectric
//
//  Created by hongzhou on 2017/1/5.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "BaseViewController.h"

@class MemberInfoModel;

//进入方式
typedef enum {
    MemberInfoVC_Home,
    MemberInfoVC_Mine,
}MemberInfoVCEnterType;

@interface MemberInfoVC : BaseViewController

//进入方式
@property (assign,nonatomic) MemberInfoVCEnterType enterType;

//会员信息
@property (strong,nonatomic) MemberInfoModel * memberInfoModel;

//回调block
@property (copy,nonatomic) void (^changeMemberInfoBlock)(MemberInfoModel * model);

@end
