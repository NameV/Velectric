//
//  CartCell.h
//  Velectric
//
//  Created by user on 2016/12/8.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *xuanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *cartimageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLable;
@property (weak, nonatomic) IBOutlet UILabel *xianghaoLable;
@property (weak, nonatomic) IBOutlet UIView *numberView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;

@end
