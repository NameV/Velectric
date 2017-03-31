//
//  CartModel.h
//  Velectric
//
//  Created by user on 2016/12/24.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsModel;

@interface CartModel : NSObject


//id
@property (assign,nonatomic) NSInteger goodsId;

//basketId---后期新加参数
@property (strong,nonatomic) NSString * basketId;

//商品名
@property (strong,nonatomic) NSString * goodsName;

//图片url
@property (strong,nonatomic) NSString * picUrl;

//规格
@property (strong,nonatomic) NSString * goodsSpecs;

//数量
@property (assign,nonatomic) NSInteger quantity;

//成交价
@property (assign,nonatomic) CGFloat dealPrice;

//是否选中
@property (assign,nonatomic) BOOL selected;

//分类名
@property (strong,nonatomic) NSString * styleName;

//商品总价格
@property (assign,nonatomic) CGFloat totalAmount;

//商品的itemId
@property (strong,nonatomic) NSString * itemId;
//商品价格
@property (copy, nonatomic) NSString *excutePrice;
// 商品的productId
@property (copy, nonatomic) NSString *productId;
// 商品的最小起订量
@property (copy, nonatomic) NSString *minQdl;


@end
