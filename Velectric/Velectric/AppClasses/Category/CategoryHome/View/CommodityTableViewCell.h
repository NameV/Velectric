//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CommodityTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *commodityImg;
@property (strong, nonatomic) IBOutlet UILabel *commodityName;
@property (strong, nonatomic) IBOutlet UILabel *commodityPrice;
@property (weak, nonatomic) IBOutlet UILabel *payNumLable;
@property (weak, nonatomic) IBOutlet UILabel *qiLable;

@end


