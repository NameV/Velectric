//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"

//定义协议
@protocol MultilevelMenuDelegate <NSObject>
//点击btn 跳转厂商页面
-(void)BtnPush:(NSDictionary *)dic;
//刷新页面
-(void)passTrendValues:(NSString *)values;
@end
#define kLeftWidth 100

@interface MultilevelMenu : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

//二期拿出来的，因为要加banner图片，所以放在.h文件中，便于去到属性
@property (nonatomic, strong)HeaderView * headview;
/* banner图片url */
@property (nonatomic, copy) NSString *picUrl;

@property(strong,nonatomic,readonly) NSArray * allData;


@property(copy,nonatomic,readonly) id block;


@property(assign,nonatomic) BOOL isRecordLastScroll;

@property(assign,nonatomic) NSInteger selectIndex;

/**
 *  为了 不修改原来的，因此增加了一个属性，选中指定 行数
 */
@property(assign,nonatomic) NSInteger needToScorllerIndex;
/**
 *  颜色属性配置
 */

/**
 *  左边背景颜色
 */
@property(strong,nonatomic) UIColor * leftBgColor;
/**
 *  左边点中文字颜色
 */
@property(strong,nonatomic) UIColor * leftSelectColor;
/**
 *  左边点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftSelectBgColor;

/**
 *  左边未点中文字颜色
 */

@property(strong,nonatomic) UIColor * leftUnSelectColor;
/**
 *  左边未点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftUnSelectBgColor;
/**
 *  tablew 的分割线
 */
@property(strong,nonatomic) UIColor * leftSeparatorColor;

@property (nonatomic, weak)id<MultilevelMenuDelegate>delegate;


-(id)initWithFrame:(CGRect)frame FirstData:(NSMutableArray *)firstdata TwoData:(NSMutableArray *)twodata ThreeData:(NSMutableArray *)threedata withSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex;
-(void)reloadDataFirstData:(NSMutableArray *)firstdata TwoData:(NSMutableArray *)twodata ThreeData:(NSMutableArray *)threedata;

@end

