//
//  VPersonBindCardView.h
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSelectCellView.h"
#import "VInputCellView.h"

@interface VPersonBindCardView : UIView

@property (nonatomic, strong) VInputCellView *nameView;                     //名字
@property (nonatomic, strong) VSelectCellView *idCardTypeView;                //选择证件类型
@property (nonatomic, strong) VInputCellView *idCardNumView;                 //证件号码
@property (nonatomic, strong) VSelectCellView *openBankView;                //开户行
@property (nonatomic, strong) VInputCellView *cardNumView;                  //卡号
@property (nonatomic, strong) VInputCellView *phoneNumView;                 //手机号
@property (nonatomic, strong) UIButton *explainBtn;                         //持卡人说明button
@property (nonatomic, strong) UILabel *warningTitleLabel;                   //下面的说明文字
@property (nonatomic, strong) UILabel *warningContentLabel;                   //下面的说明文字

@end
