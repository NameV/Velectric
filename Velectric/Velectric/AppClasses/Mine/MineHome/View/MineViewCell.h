//
//  MineViewCell.h
//  Velectric
//
//  Created by hongzhou on 2016/12/20.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewCell : UITableViewCell

//小图标
@property (strong,nonatomic) UIImageView * lconImage;
//title
@property (strong,nonatomic) UILabel * titleLab;
//箭头
@property (strong,nonatomic) UIImageView * rightImage;
//线条
@property (strong,nonatomic) UIView * lineView;

@end
