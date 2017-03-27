//
//  UILabel+USLabel.m
//  Sales
//
//  Created by XiaoYang on 16/1/11.
//  Copyright © 2016年 XiaoYang. All rights reserved.
//

#import "UILabel+USLabel.h"

@implementation UILabel (USLabel)

+ (UILabel *)labelShortWithColor:(UIColor *)color font:(CGFloat)font {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

+ (UILabel *)labelLongWithColor:(UIColor *)color font:(CGFloat)font {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}

+ (UILabel *)separator {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return label;
}

@end
