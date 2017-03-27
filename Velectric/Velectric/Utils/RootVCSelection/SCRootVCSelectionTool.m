//
//  SCRootVCSelectionTool.m
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCRootVCSelectionTool.h"

//#import "SCOAuthViewController.h"
#import "VelectricTabbarController.h"

//#import "SCAccountTool.h"


@implementation SCRootVCSelectionTool

#pragma mark - 根据授权与否设置window的根控制器
#warning 此项目有实现京东授权，但是此APPkey在授权的时候经常跳转 404。有兴趣的童鞋可以自行申请 key 进行测试。
#warning 测试key 可以看 SCNote.c 文件
+ (void)setRootViewControllerForWindow:(UIWindow *)window {
    
    
    // 2. 选择根控制器:判断access_Token是否有效
//    if ([SCAccountTool account] == nil) { // 1. 如果授权过期或没有授权过
//    
//        // 设置OAuth授权控制器为根控制器
//        SCOAuthViewController *OAuthVC = [[SCOAuthViewController alloc] init];
//        window.rootViewController = OAuthVC;
//        
//    } else {                            // 2. 如果授权过
    
        // 设置TabBarController为根控制器
        VelectricTabbarController *tabBarVC = [[VelectricTabbarController alloc] init]; // TabBarController一创建就加载(ViewDidLoad)
        window.rootViewController = tabBarVC;
//    }

}

@end
