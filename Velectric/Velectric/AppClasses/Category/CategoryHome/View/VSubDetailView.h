//
//  VSubDetailView.h
//  Velectric
//
//  Created by LYL on 2017/3/23.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSubDetailView : UIView

@property (nonatomic, strong)UIImageView *iconImage;//图标

@property (nonatomic, strong)UILabel *priceLabel;//图标

@property (nonatomic, strong)UIButton *cancelBtn;//取消buttun

@property (nonatomic, strong)UILabel *productTypeKeyLabel;//产品规格/型号key
@property (nonatomic, strong)UILabel *productTypeValueLabel;//产品规格/型号value

@property (nonatomic, strong)UILabel *minKeyLabel;//最小起订量Valuelabel
@property (nonatomic, strong)UILabel *minValueLabel;//最小起订量Valuelabel

/* 规格型号字符串，set方法控制button的显示 */
@property (nonatomic, copy) NSString *guigeString;

@end
