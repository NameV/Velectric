//
//  DetailsBtnView.h
//  Velectric
//
//  Created by user on 2016/12/22.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsBtnView : UIView
@property (weak, nonatomic) IBOutlet UIButton *goFactoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *cartBtn;
@property (weak, nonatomic) IBOutlet UIButton *addCartBtn;
@property (weak, nonatomic) IBOutlet UIButton *goPayBtn;
@property (weak, nonatomic) IBOutlet UILabel *yuanJiaoLable;
//lastobject
@property (weak, nonatomic) IBOutlet UIView *guiGeView;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *piceLable;
@property (weak, nonatomic) IBOutlet UILabel *guiGeLable;
@property (weak, nonatomic) IBOutlet UILabel *minLable;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;



@end
