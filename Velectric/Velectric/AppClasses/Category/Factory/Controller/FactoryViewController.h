//
//  FactoryViewController.h
//  Velectric
//
//  Created by QQ on 2016/12/5.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandsModel;

@interface FactoryViewController : BaseViewController

@property (strong,nonatomic) BrandsModel * brandsModel;


//类别model
@property (copy,nonatomic) NSString * goodsName;//商品名称
@property (copy,nonatomic) NSString * brandId;//品牌ID
@property (strong,nonatomic) NSArray * brandNames;//品牌名称，数组
@property (copy,nonatomic) NSString * manufacturerName;//厂商名称
@property (copy,nonatomic) NSString * manufacturerId;//厂商ID
@property (copy,nonatomic) NSString * sort;
@property (copy,nonatomic) NSString * sortDirection;
@property (strong,nonatomic) NSArray * optionIds;
@property (copy,nonatomic) NSString * type;//传入的类型 1 品牌 2 厂商
@property (assign,nonatomic) int pageNum;//分页的页码

@property (nonatomic,assign)ScreeningViewEnterType enterType;
@property (nonatomic, copy)NSString * saiXuanCategory;//筛选页面的id
@property (nonatomic, assign)BOOL isFromsearch;
@property (nonatomic, copy)NSString * cartFlog;
@property (nonatomic, copy)NSString * properyId;//筛选的sku属性
@property (nonatomic, copy)NSString * brandNameStr;//筛选的品牌名称
@property (nonatomic, copy)NSString * minPrice;//筛选的最小价格
@property (nonatomic, copy)NSString * maxPrice;//筛选的最大价格
@property (nonatomic, copy)NSString * level;//id级别
@property (nonatomic, copy)NSString * categoryNameStr;//筛选的name


@end
