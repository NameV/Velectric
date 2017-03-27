//
//  VJDProgressHUD.m
//  Velectric
//
//  Created by hongzhou on 2016/12/23.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "VJDProgressHUD.h"
#import "SVProgressHUD.h"

@implementation VJDProgressHUD

//提示 文字
+(void)showTextHUD:(NSString *)text
{
    [SVProgressHUD setBackgroundColor:COLOR_333333];
    [SVProgressHUD setForegroundColor:COLOR_FFFFFF];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD showInfoWithStatus:text];
}

//提示 成功
+(void)showSuccessHUD:(NSString *)text
{
    [SVProgressHUD setBackgroundColor:COLOR_333333];
    [SVProgressHUD setForegroundColor:COLOR_FFFFFF];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showSuccessWithStatus:text];
}

//提示 成功
+(void)showErrorHUD:(NSString *)text
{
    [SVProgressHUD setBackgroundColor:COLOR_333333];
    [SVProgressHUD setForegroundColor:COLOR_FFFFFF];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showErrorWithStatus:text];
}

//提示 等待
+(void)showProgressHUD:(NSString *)text
{
    [SVProgressHUD setBackgroundColor:COLOR_333333];
    [SVProgressHUD setForegroundColor:COLOR_FFFFFF];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showWithStatus:text];
}

//提示 消失
+(void)dismissHUD
{
    [SVProgressHUD dismiss];
}

@end
