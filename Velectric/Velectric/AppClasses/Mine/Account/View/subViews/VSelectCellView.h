//
//  VSelectCellView.h
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSelectCellView : UIButton

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UIView *bottomLine;

- (instancetype)initWithTitle:(NSString *)title ;

@end
