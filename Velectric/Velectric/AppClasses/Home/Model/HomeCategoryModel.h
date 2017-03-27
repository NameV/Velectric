//
//  HomeCategoryModel.h
//  Velectric
//
//  Created by hongzhou on 2016/12/27.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCategoryModel : NSObject

//id
@property (assign,nonatomic) NSInteger myId;

//商品名
@property (strong,nonatomic) NSString * name;

//是否选中
@property (assign,nonatomic) BOOL isSelect;

@end
