//
//  MemberInfoModel.h
//  Velectric
//
//  Created by hongzhou on 2017/1/5.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberInfoModel : NSObject

//id
@property (strong,nonatomic) NSNumber * Id;

//公司名称
@property (strong,nonatomic) NSString * realName;

//执照编号
@property (strong,nonatomic) NSString * businessLicenseCode;

//营业执照
@property (strong,nonatomic) NSString * bid;

//店铺照片
@property (strong,nonatomic) NSString * sid;

//税务登记表
@property (strong,nonatomic) NSString * wid;

//联系人
@property (strong,nonatomic) NSString * contactName;

//联系人
@property (strong,nonatomic) NSString * mobile;

//省名称
@property (strong,nonatomic) NSString * provinceName;

//市名称
@property (strong,nonatomic) NSString * cityName;

//区名称
@property (strong,nonatomic) NSString * areaName;

//所在地 省、市、区
@property (strong,nonatomic) NSString * regionId;

//详细地址
@property (strong,nonatomic) NSString * address;

//经营范围
@property (strong,nonatomic) NSString * categoryName;

//介绍人
@property (strong,nonatomic) NSString * introductorName;

//介绍人电话
@property (strong,nonatomic) NSString * introductorMobile;

@end
