//
//  ScreeningView.h
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenView.h"

typedef void(^reSelectBlock)();

@class HomeCategoryModel,BrandsModel;

@interface ScreeningView : UIView<UITableViewDelegate,UITableViewDataSource,ScreenViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic) BaseTableView * tableView;

//table header
@property (strong,nonatomic) UIView * headerView;

//进入方式
@property (assign,nonatomic) ScreeningViewEnterType enterType;

//半透明宽度
@property (assign,nonatomic) CGFloat alphaWidth;

//分类view
@property (strong,nonatomic) UIView * categoryView;

//选中的分类
@property (strong,nonatomic) UILabel * categoryValueLab;

//品牌view
@property (strong,nonatomic) UIView * brandsView;

//选中的品牌
@property (strong,nonatomic) UILabel * brandsValueLab;

//品牌集合
@property (strong,nonatomic) NSMutableArray <BrandsModel *>* brandsList;

//选中的品牌集合
@property (strong,nonatomic) NSMutableArray <BrandsModel *>* selectBrandsList;

//价格view
@property (strong,nonatomic) UIView * priceView;

//最低价
@property (strong,nonatomic) UITextField * lowPriceTextF;

//最高价
@property (strong,nonatomic) UITextField * highPriceTextF;

//选中的类别model
@property (strong,nonatomic) HomeCategoryModel * selectCategoryModel;

//上级界面传过来的 id
@property (assign,nonatomic) NSInteger categoryId;

//是否创建
@property (assign,nonatomic) BOOL isCreatBottomView;

//回调block
@property (copy,nonatomic) void (^screeningBlcok)(NSMutableArray * brandsList,NSMutableArray * properyList,NSString * lowPrice,NSString * highPrice,HomeCategoryModel *selectModel);
//回调block
@property (copy,nonatomic) void (^categoryNameBlock)(NSString * categoryNameStr);
//screenView 的属性
@property (strong, nonatomic)ScreenView * screenView;

@property (assign, nonatomic)BOOL  fromFactoryFlage;//是否来自厂商的标准
//请求类型 1。 品牌  2，厂商   3. 搜索

@property (copy, nonatomic)NSString * type;
//品牌名称
@property (copy, nonatomic)NSString * brandName;
//是否是重置
@property (assign, nonatomic)BOOL chongZhiFlog;

/* 重选的block，重置catogeryId */
@property (nonatomic, copy) reSelectBlock reselectBlock;


-(void)enterType:(ScreeningViewEnterType)enterType;

@end
