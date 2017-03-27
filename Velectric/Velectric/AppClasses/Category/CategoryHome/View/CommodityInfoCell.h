//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsMode.h"
#import "TYAttributedLabel.h"
#import "TYLinkTextStorage.h"
#define kHeightCommodityInfo 180
@interface CommodityInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) TYAttributedLabel*activityLabel;
@property (nonatomic, strong) UILabel *priceyLabel;//商品价钱
@property (nonatomic, strong) UIImageView *imgZXImageview;//专项图片
@property (nonatomic, strong) UILabel *txtZXLabel;//专项文字


/// 根据数据模型来显示内容
- (void)showInfo:(DetailsMode *)model;
@end
