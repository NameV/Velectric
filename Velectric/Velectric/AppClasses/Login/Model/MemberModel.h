//
//  MemberModel.h
//  Velectric
//
//  Created by user on 2016/12/31.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject

//id
@property (copy,nonatomic) NSString * Id;

//店铺照片
@property (strong,nonatomic) NSString * sid;

//税务登记表
@property (strong,nonatomic) NSString * wid;

//营业执照
@property (strong,nonatomic) NSString * bid;

//城市名称
@property (copy,nonatomic) NSString * cityName;

//categoryId
@property (assign,nonatomic) CGFloat categoryId;
//这是查询返回的categoryIds 经营范围
@property (copy,nonatomic) NSString * categoryIds;

//执照编号
@property (strong,nonatomic) NSString * businessLicenseCode;

//省名称
@property (strong,nonatomic) NSString * provinceName;

//经营范围
@property (strong,nonatomic) NSString * categoryName;

//详细地址
@property (strong,nonatomic) NSString * address;

//自治区
@property (strong,nonatomic) NSString * areaName;

//介绍人电话
@property (strong,nonatomic) NSString * introductorMobile;

//介绍人名称
@property (strong,nonatomic) NSString * introductorName;

//联系人名称
@property (strong,nonatomic) NSString * contactName;

//公司名称
@property (strong,nonatomic) NSString * realName;
//电话
@property (strong,nonatomic) NSString * mobile;
// 所在地id
@property (strong,nonatomic) NSString *regionId;

//------------------二期新增-------------------

// 公司名称审核备注
@property (copy, nonatomic) NSString *branchNameNote;
// 公司名称审核状态
@property (copy, nonatomic) NSString *branchNameStatus;

// 执照编号审核备注
@property (copy,nonatomic) NSString *businessLicenseCodeNote;
// 执照编号审核状态
@property (copy, nonatomic) NSString *businessLicenseCodeStatus;

// 营业执照备注
@property (copy,nonatomic) NSString *businessLicenseUrlNote;
// 营业执照审核状态
@property (copy, nonatomic) NSString *businessLicenseUrlStatus;

// 店铺图片备注
@property (copy,nonatomic) NSString *storePictureUrlNote;
// 店铺图片审核状态
@property (copy, nonatomic) NSString *storePictureUrlStatus;

// 联系人备注
@property (copy,nonatomic) NSString *contactNameNote;
// 联系人审核状态
@property (copy, nonatomic) NSString *contactNameStatus;

// 联系方式备注
@property (copy,nonatomic) NSString *mobileNote;
// 联系方式审核状态
@property (copy, nonatomic) NSString *mobileStatus;

// 所在地区备注
@property (copy, nonatomic) NSString *reginNameNote;
// 所在地区审核状态
@property (copy,nonatomic) NSString *reginNameStatus;


// 详细地址备注
@property (copy, nonatomic) NSString *addressNote;
// 详细地址审核状态
@property (copy,nonatomic) NSString *addressStatus;


// 经营范围备注
@property (copy,nonatomic) NSString *byCombinationNamesNote;
// 经营范围审核状态
@property (copy, nonatomic) NSString *byCombinationNamesStatus;




@end
