//
//  AlertView.h
//  AlertView
//
//  Created by pengjingli on 16/11/23.
//  Copyright © 2016年 pengjingli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertViewDelegate <NSObject>

- (void)okBtnAction;

- (void)cancleBtnAction;

@end

@interface AlertView : UIView

@property(nonatomic, strong)UILabel *tip;
@property(nonatomic, strong)UILabel *titleLable;
@property(nonatomic, strong)UIButton *leftBtn;
@property(nonatomic, strong)UIButton *rightBtn;
@property(nonatomic, copy)NSString * leftTitle;//左侧btn的title
@property(nonatomic, copy)NSString * rightTitle;//右侧btn的title
@property(nonatomic, copy)NSString * content;//提示内容



@property(nonatomic, assign)id <AlertViewDelegate>delegate;

- (id)initWithLeftTitle:(NSString *)leftTitle WithRightTitle:(NSString *)rightTitle ContentTitle:(NSString *)contentTitle;
@end
