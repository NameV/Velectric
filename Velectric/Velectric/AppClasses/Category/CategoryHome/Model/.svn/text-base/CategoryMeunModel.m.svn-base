//
//  CategoryMeunModel.m
//  Velectric
//
//  Created by QQ on 2016/11/29.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "CategoryMeunModel.h"

@implementation CategoryMeunModel

#pragma mark 根据字典初始化对象
-(CategoryMeunModel *)initWithDictionary:(NSDictionary *)dic{
    if (self==[self init]) {
        self.Id=[dic[@"Id"] intValue];
        self.menuName=dic[@"menuName"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(CategoryMeunModel *)statusWithDictionary:(NSDictionary *)dic{
    CategoryMeunModel *categoryMeun=[[CategoryMeunModel alloc]initWithDictionary:dic];
    return categoryMeun;
}

@end
