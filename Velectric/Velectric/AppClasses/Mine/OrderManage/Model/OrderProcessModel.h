//
//  OrderProcessModel.h
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderProcessModel : NSObject

//内容
@property (strong,nonatomic) NSString * myDescription;

//时间
@property (strong,nonatomic) NSNumber * createTime;

//物流更新时间
@property (strong,nonatomic) NSString * logisticsTime;

//状态
@property (strong,nonatomic) NSString * status;

@end
