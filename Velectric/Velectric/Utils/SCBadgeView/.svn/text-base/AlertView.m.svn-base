//
//  AlertView.m
//  AlertView
//
//  Created by pengjingli on 16/11/23.
//  Copyright © 2016年 pengjingli. All rights reserved.
//

#define Fit_Width [UIScreen mainScreen].bounds.size.width/375
#define Fit_Height [UIScreen mainScreen].bounds.size.height/667

#import "AlertView.h"
#import "UIViewAdditions.h"

@implementation AlertView


- (id)initWithLeftTitle:(NSString *)leftTitle WithRightTitle:(NSString *)rightTitle ContentTitle:(NSString *)contentTitle{
    self = [super init];
    if (self) {
        UIView *tempview;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.frame = CGRectMake(Fit_Width * 30, Fit_Height * 200, SCREEN_WIDTH- Fit_Width * 30 * 2, Fit_Height * 145);
        self.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        tempview = [[UIView alloc] initWithFrame:CGRectMake(0, Fit_Height * 20, (self.width - Fit_Width * 80)/2 , 1)];
        tempview.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:tempview];
        
        self.tip = [UILabel labelWithFrame:CGRectMake(tempview.right, Fit_Height * 10, Fit_Width * 80, Fit_Height * 20) fontSize:15 textAlignment:NSTextAlignmentCenter text:@"提示"];
        _tip.textColor = [UIColor orangeColor];
        [self addSubview:_tip];
        
        tempview = [[UIView alloc] initWithFrame:CGRectMake(_tip.right, tempview.top, tempview.width, 1)];
        tempview.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:tempview];
        
        self.titleLable = [UILabel labelWithFrame:CGRectMake(0, _tip.bottom + Fit_Height * 25, self.width, Fit_Height * 20) fontSize:15 textAlignment:NSTextAlignmentCenter text:contentTitle];
        _titleLable.textColor = [UIColor grayColor];
        [self addSubview:_titleLable];
        
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, _titleLable.bottom + Fit_Height * 25, self.width / 2, Fit_Height * 45);
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _leftBtn.backgroundColor = RGBColor(242, 182, 2);
        [_leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _rightBtn.frame = CGRectMake(_leftBtn.right, _leftBtn.top, _leftBtn.width, _leftBtn.height);
        _rightBtn.backgroundColor = [UIColor whiteColor];
        [_rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return self;
}


- (void)leftBtnAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(okBtnAction)]){
        [self.delegate okBtnAction];
    }
}

- (void)rightBtnAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancleBtnAction)]){
        [self.delegate cancleBtnAction];
    }
}

@end
