//
//  BrandsView.h
//  Velectric
//
//  Created by hongzhou on 2016/12/28.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeCategoryModel,BrandsModel;

@interface BrandsView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

//品牌类型 scrollView
@property (nonatomic, strong) UIScrollView * brandtypeScrollView;

//品牌类型按钮 list
@property (nonatomic, strong) NSMutableArray <UIButton *>* typeBtnList;

//品牌背景 scrollView
@property (nonatomic, strong) UICollectionView * brandCollectionView;

//品牌类别 list
@property (nonatomic, strong) NSMutableArray <HomeCategoryModel *>* categoryList;

//品牌model list
@property (nonatomic, strong) NSMutableArray <BrandsModel *>* brandsList;

//点击index
@property (nonatomic, assign) NSInteger clickIndex;


@property (weak, nonatomic) UIViewController * controller;

//重载品牌类型按钮
-(void)reloadBrandTypeScrollView;

//重载品牌类型
-(void)reloadBrandBgScrollView;

@end
