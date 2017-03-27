//
//  HomeHotGoodsModel.h
//  Velectric
//
//  Created by hongzhou on 2016/12/27.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeGoodsModel : NSObject

//id
@property (assign,nonatomic) NSInteger myId;

//商品名
@property (strong,nonatomic) NSString * name;

//图片url
@property (strong,nonatomic) NSString * pictureUrl;

//价格
@property (assign,nonatomic) CGFloat minPrice;

//数量
@property (assign,nonatomic) NSInteger count;

//是否能点击
@property (assign,nonatomic) BOOL canLick;

@end

@interface HomeHotGoodsModel : NSObject

//商品类id
@property (strong,nonatomic) NSString * Id;

//商品类型 名称
@property (strong,nonatomic) NSString * title;

//类别idlist
@property (strong,nonatomic) NSString * idlist;

//页码
@property (assign,nonatomic) NSInteger pageNum;

//一页数量
@property (assign,nonatomic) NSInteger pageSize;

//商品
@property (strong,nonatomic) NSMutableArray <HomeGoodsModel *>* goodsList;

@end
