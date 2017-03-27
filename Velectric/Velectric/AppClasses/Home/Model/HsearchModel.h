//
//  HsearchModel.h
//  Velectric
//
//  Created by user on 2016/12/30.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HsearchModel : NSObject
//商品ID
@property (strong,nonatomic) NSNumber *brandId;

//商品名称
@property (copy,nonatomic) NSString * brandName;

//分类ID
@property (copy,nonatomic) NSString * categoryId;

//分类的三级路径
@property (copy,nonatomic) NSString * categoryTreePath;

//商品数量
@property (assign,nonatomic)NSInteger count;


//厂商ID
@property (strong,nonatomic) NSNumber * manufacturerId;

//厂商名称
@property (strong,nonatomic) NSString * manufacturerName;

//产品ID
@property (strong,nonatomic)NSNumber  * productId;

//产品名称
@property (strong,nonatomic) NSString * productName;

//类型
@property (strong,nonatomic) NSString * type;
//分类级别
@property (assign, nonatomic)NSInteger level;


//新加的参数，用来标记是否是点击搜索进行的搜索
//若有值，表示是点击搜索进行的搜索，若无值，表示是点击下面的智能提示进行的搜索。
@property (strong,nonatomic) NSString * searchText;

//商品名称--无结果列表
@property (copy,nonatomic) NSString * name;

@end
