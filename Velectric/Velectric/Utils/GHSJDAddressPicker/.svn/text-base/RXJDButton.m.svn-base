//
//  RXJDButton.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXJDButton.h"
#import "RXHexColor.h"
#define UIColorHexStr(_color) [RXHexColor colorWithHexString:_color]

@implementation RXJDButton


- (CGFloat)btnWidth {
    return _btnWidth;
}

- (CGFloat)btnLeft {
    return _btnLeft;
}


- (void)setAddressName:(NSString *)addressName {
    _addressName = addressName;
    [self setTitle:addressName forState:UIControlStateNormal];

    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:UIColorHexStr(@"333333") forState:UIControlStateNormal];
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.backgroundColor = [UIColor clearColor];
    
    CGRect rect = self.frame;
    _btnLeft = rect.origin.x;

    [self sizeToFit];
    _btnWidth = self.bounds.size.width;
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, _btnWidth, rect.size.height);
    
}

@end
