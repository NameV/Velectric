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

@end
