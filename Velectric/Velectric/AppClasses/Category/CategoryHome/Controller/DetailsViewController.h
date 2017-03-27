//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
@property (nonatomic, copy)NSString * name;//商品名称
@property (nonatomic, copy)NSString * iD;//商品ID
@property (nonatomic, copy)NSString * type;//类型 1为品牌 2为厂商

@property (nonatomic, strong)UIButton * goFactoryBtn; //商品介绍的btn
@property (nonatomic, strong)UIButton * cart; //规格参数的btn
@property (nonatomic, strong)UIButton * addCart; //包装清单的btn
@property (nonatomic, strong)UIButton * goPayBtn; //售后的btn


@end
