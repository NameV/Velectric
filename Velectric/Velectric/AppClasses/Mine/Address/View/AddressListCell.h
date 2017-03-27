//
//  AddressListCell.h
//  Tourph
//
//  Created by yanghongzhou on 16/2/16.
//  Copyright © 2016年 yanghongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@class AddressModel;

@interface AddressListCell : MGSwipeTableCell

//姓名
@property (strong,nonatomic) UILabel * nameLab;
//手机
@property (strong,nonatomic) UILabel * phoneLab;
//地址
@property (strong,nonatomic) UILabel * addressLab;
//删除按钮
@property (strong,nonatomic) UIButton * editBtn;
//分割线
@property (strong,nonatomic) UIView * fengeLine;
//底部线条
@property (strong,nonatomic) UIView * lineView;
//选中图片
@property (strong,nonatomic) UIImageView * selectView;
//默认图片
@property (strong,nonatomic) UIImageView * defaultView;


@property (strong,nonatomic) AddressModel * model;

@end
