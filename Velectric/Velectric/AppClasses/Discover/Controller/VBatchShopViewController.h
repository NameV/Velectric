//
//  VBatchShopViewController.h
//  Velectric
//
//  Created by MacPro04967 on 2017/2/14.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    Product_Add,
    Product_update
} ProductType;

@interface VBatchShopViewController : BaseViewController

@property (nonatomic, strong) NSNumber *ident;//id
- (instancetype)initWithProductType:(ProductType)type;

/* 进入方式  为1  说明是从发现的H5跳进来的，发布完成之后跳进列表界面 */
@property (nonatomic, assign) NSInteger enterType;

@end
