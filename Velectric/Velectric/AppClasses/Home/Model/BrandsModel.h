//
//  BrandsModel.h
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandsModel : NSObject

//id
@property (strong,nonatomic) NSNumber * Id;

//名称
@property (strong,nonatomic) NSString * name;

//logo链接
@property (strong,nonatomic) NSString * logoOriginUrl;

//id 筛选界面
@property (strong,nonatomic) NSNumber * brandId;

//名称 筛选界面
@property (strong,nonatomic) NSString * brandName;

//是否选中 筛选界面
@property (assign,nonatomic) BOOL isSelect;

@end
