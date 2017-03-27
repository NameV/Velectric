//
//  VInputCellView.h
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VInputCellView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *bottomLine;

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder ;

@end
