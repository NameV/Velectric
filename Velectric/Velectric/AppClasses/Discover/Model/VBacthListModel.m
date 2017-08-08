//
//  VBacthListModel.m
//  Velectric
//
//  Created by MacPro04967 on 2017/2/14.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VBacthListModel.h"

static CGFloat kpadding = 15.0f;
static CGFloat timeHeight = 15.0f;
static CGFloat separatHeight = 1 + 1 + 10 ;

static CGFloat const contentFont = 15.f;                     //内容字号

@implementation VBacthListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"batchProducts"   :   [VBatchCellModel class]
             };
}

@end


@implementation VBatchCellModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ident" : @"id"
             };
}



@end
