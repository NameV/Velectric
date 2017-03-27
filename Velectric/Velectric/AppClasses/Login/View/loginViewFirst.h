//
//  loginViewFirst.h
//  Velectric
//
//  Created by QQ on 2016/11/22.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewFirst : UIView
@property (nonatomic , copy)NSString * str;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *verifyField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;
@property (weak, nonatomic) IBOutlet UIImageView *verifyImage;
@property (weak, nonatomic) IBOutlet UIView *greayLine;
@property (weak, nonatomic) IBOutlet UIView *greayLineTwo;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end
