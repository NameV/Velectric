//
//  CommodityTableViewController.h
//  Velectric
//
//  Created by QQ on 2016/11/29.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeCategoryModel;

@interface CommodityTableViewController : UIViewController
/*
 
 @"goodsName":@"五金工具",//商品名称
 @"brandId":@"1",//品牌ID
 @"brandNames":@"1",//品牌名称，数组
 @"manufacturerName":@"1",//厂商名称
 @"manufacturerId":@"1",//厂商ID
 @"categoryName":@"1",//分类名称
 @"categoryIds":@"1",//分类id
 @"pageNum":@"5",//分页，默认为1
 @"pageSize":@"5",//分页，默认20个
 @"keyWords":@"",
 @"sort":@"1",//排序时传值传minProductPrice
 @"sortDirection":@"1",//升序asc 降序 desc
 @"searchWithinResult":@"1",
 @"loginName":@"1",
 @"optionIds":@"1",//sku 属性
 
 
 */

//类别model
@property (strong,nonatomic) HomeCategoryModel * categoryModel;
@property (copy,nonatomic) NSString * goodsName;
@property (copy,nonatomic) NSString * brandId;
@property (copy,nonatomic) NSArray * brandNames;
@property (copy,nonatomic) NSString * manufacturerName;
@property (copy,nonatomic) NSString * manufacturerId;
@property (copy,nonatomic) NSString * categoryName;
@property (copy,nonatomic) NSArray * categoryIds;
@property (copy,nonatomic) NSString * keyWords;
@property (copy,nonatomic) NSString * sort;
@property (copy,nonatomic) NSString * sortDirection;
@property (copy,nonatomic) NSArray * optionIds;

@property (nonatomic,assign)ScreeningViewEnterType enterType;
@property (nonatomic, copy)NSString * categoryIdList;//热卖商品分类ID
@property (nonatomic, copy)NSString * fromType;//来自热门商品的点击事件
@property (nonatomic,assign)NSInteger saiXuanCategoryId;//筛选的categoryID

@property (nonatomic, copy)NSString *minPrice;//筛选的最小值
@property (nonatomic, copy)NSString *maxPrice;//筛选的最大值

@property (nonatomic, copy)NSString *properyId;//筛选的skuid
@property (nonatomic, copy)NSString * brandIds; //筛选的商品id
@property (nonatomic, copy)NSString * brandNameStr;//筛选时的名称

@end
