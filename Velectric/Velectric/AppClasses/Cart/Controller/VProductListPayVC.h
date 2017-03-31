//
//  VProductListPayVC.h
//  Velectric
//
//  Created by LYL on 2017/3/3.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "BaseViewController.h"
#import "CartListModel.h"

typedef void(^productIconReloadBLock)(NSMutableArray *productListArray);

@interface VProductListPayVC : BaseViewController

@property (nonatomic, copy)NSString * fromDetailFlag;//来自详情页的标子

@property (nonatomic, copy)productIconReloadBLock  block;//删除数据时前面数据更新

//全部商品列表，下个界面删除的时候用
@property (strong,nonatomic) NSMutableArray <CartListModel*>* allProductList;

@end
