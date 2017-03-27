//
//  AddressListCell1.h
//  Velectric
//
//  Created by hongzhou on 2016/12/15.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListCell1 : UITableViewCell

//姓名
@property (strong,nonatomic) UILabel * nameLab;
//手机
@property (strong,nonatomic) UILabel * phoneLab;
//地址
@property (strong,nonatomic) UILabel * addressLab;
//中间线条
@property (strong,nonatomic) UIImageView * lineViewMiddle;
//设为默认按钮
@property (strong,nonatomic) UIButton * setDefautBtn;
//编辑按钮
@property (strong,nonatomic) UIButton * editBtn;
//删除按钮
@property (strong,nonatomic) UIButton * deleteBtn;

@end
