//
//  SkuPropertyModel.h
//  Velectric
//
//  Created by hongzhou on 2016/12/29.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyModel : NSObject

//是否选中
@property (assign,nonatomic) BOOL isSelect;

//属性值
@property (strong,nonatomic) NSString * propertyValue;

//属性id
@property (strong,nonatomic) NSString * properyId;

@end

@interface SkuPropertyModel : NSObject

//属性id
@property (strong,nonatomic) NSString * properyId;

//属性名称
@property (strong,nonatomic) NSString * frontLabel;

//是否展开
@property (assign,nonatomic) BOOL isExpand;

//属性list
@property (strong,nonatomic) NSMutableArray <PropertyModel *>* propertyList;

//选中的 属性list
@property (strong,nonatomic) NSMutableArray <PropertyModel *>* selectPropertyList;

//一般高度
@property (assign,nonatomic) CGFloat normalHeight;

//展开高度
@property (assign,nonatomic) CGFloat expandHeight;

@end
