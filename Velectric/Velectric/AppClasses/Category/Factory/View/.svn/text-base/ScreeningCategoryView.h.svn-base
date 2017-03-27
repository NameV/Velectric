//
//  ScreeningCategoryView.h
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DataShow_threeLevel,        //三级展示（一级，二级，三级分类）
    DataShow_twoLevel,          //二极展示（二级，三级分类）
    DataShow_oneLevel,          //一极展示（三级分类）
}DataShowType;

@class HomeCategoryModel;

@interface ScreeningCategoryView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) BaseTableView * tableView;

@property (strong,nonatomic) BaseTableView * thirdTableView;

//数据展示方式
@property (assign,nonatomic) DataShowType showType;

//当前层级
@property (assign,nonatomic) NSInteger currentLevel;

//选中的一级类别model
@property (strong,nonatomic) HomeCategoryModel * selectFirstModel;

//选中的二级类别model
@property (strong,nonatomic) HomeCategoryModel * selectSecondModel;

//选中的三级类别model
//@property (strong,nonatomic) HomeCategoryModel * selectThirdModel;

//上级界面传过来的 id
@property (assign,nonatomic) NSInteger categoryId;

//一级分类model集合
@property (strong,nonatomic) NSMutableArray <HomeCategoryModel *>* firstCategoryList;

//二级分类model集合
@property (strong,nonatomic) NSMutableArray <HomeCategoryModel *>* secondCategoryList;

//三级分类model集合
@property (strong,nonatomic) NSMutableArray <HomeCategoryModel *>* thirdbCategoryList;

//回调block
@property (copy,nonatomic) void (^chooseCategoryFinishBlcok)(HomeCategoryModel * model);
//数据级别
@property (copy, nonatomic)NSString * level;
//请求类型 1。 品牌  2，厂商   3. 搜索
@property (copy, nonatomic)NSString * type;

@property (assign, nonatomic)BOOL  fromFactoryFlage;//是否来自厂商的标准

@property (copy, nonatomic)NSString * brandName;//传过来的name


@end
