//
//  VUpdateManager.m
//  Velectric
//
//  Created by LYL on 2017/4/5.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VUpdateManager.h"
#import "CheckViewController.h"
#import "USPopView.h"
#import "BSAlertView.h"
#import "VUpdateModel.h"

@implementation VUpdateManager

//获取对象单例
+ (instancetype)shareManager  {
    static dispatch_once_t predicate;
    static VUpdateManager * sharedManager;
    dispatch_once(&predicate, ^{
        sharedManager=[[VUpdateManager alloc] init];
    });
    return sharedManager;
}

#pragma mark - 检查更新
/**
 *  检查更新
 */
- (void)checkVersion {
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@?body={params:{type:ios}}",GetVersionURL];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1
                                       WithURLString:requestUrl
                                          parameters:nil
                                             success:^(NSDictionary *responseObject) {
                                                 
                                                 [VJDProgressHUD dismissHUD];
                                                 if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                                     VUpdateModel *model = [VUpdateModel yy_modelWithDictionary:responseObject];
                                                     [self updateWithModel:model];//是否更新
                                                     self.showBtn = model.show;
                                                     [self postNotificationWithShow:model.show];//发送显示按钮与否的通知
                                                 }
                                             } failure:^(NSError *error) {
                                                 [VJDProgressHUD dismissHUD];
                                             }];
}

//发送显示按钮与否的通知
- (void)postNotificationWithShow:(NSString *)show {
    UIViewController *viewCon = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (![viewCon.class isSubclassOfClass:[VelectricTabbarController class]]) {
        NSDictionary *dic = @{@"show":show};
        [[NSNotificationCenter defaultCenter]postNotificationName:ShowWithouLoginNotification object:nil userInfo:dic];
    }
}

- (void)updateWithModel:(VUpdateModel *)model {
    
    BOOL newVersion = NO;
    BOOL mustUpdate = NO;
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([version isEqualToString:model.version]) {
        newVersion = YES;
    }
    
    if ([model.type isEqualToString:@"Y"]) {
        mustUpdate = YES;
    }
    
    //有新版本
    if (newVersion == YES) {
        
        //强制更新
        if (mustUpdate == YES) {
            [BSAlertView alertViewWithTitle:@"有新版本更新"
                                    message:@"请前往更新新版本!"
                              alertViewType:BSAlertViewNormal
                            completionBlock:^(NSInteger buttonIndex) {
                                
                                if (buttonIndex == 1) {
                                    NSURL *url = [NSURL URLWithString:model.url];
                                    [[UIApplication sharedApplication]openURL:url];
                                }else{
                                    [self outLogin];//退出登录
                                }
                            }];
        }else{//不强制更新
            [BSAlertView alertViewWithTitle:@"有新版本更新"
                                    message:@"请前往更新新版本!"
                              alertViewType:BSAlertViewNormal
                            completionBlock:^(NSInteger buttonIndex) {
                                
                                if (buttonIndex == 1) {
                                    NSURL *url = [NSURL URLWithString:model.url];
                                    [[UIApplication sharedApplication]openURL:url];
                                }
                            }];
        }
    //已经是最新版本
    }else{
        NSLog(@"已经是最新版本");
    }
}

- (void)outLogin {
    [GET_USER_INFO clearInfo];// 清除缓存的用户信息
    [UserDefaults setBool:NO forKey:DEFINE_STRING_LOGIN];//设置为未登录状态
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changRootViewController" object:nil];
    
    //友盟账号统计
    [MobClick profileSignOff];
}

#pragma mark - 检查用户审核状态
/**
 *  检查用户审核状态
 */
- (void)checkUserNameState {
    
    //未登录，请求用户状态
    if (![UserDefaults boolForKey:DEFINE_STRING_LOGIN]){
        
        NSString *requestUrl = [NSString stringWithFormat:@"%@?body={params:{memberId:%@}}",GetAuditStateURL,GET_USER_INFO.memberId ? GET_USER_INFO.memberId : @""];
        requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [VJDProgressHUD showProgressHUD:nil];
        [SYNetworkingManager GetOrPostNoBodyWithHttpType:1
                                           WithURLString:requestUrl
                                              parameters:nil
                                                 success:^(NSDictionary *responseObject) {
                                               
                                               [VJDProgressHUD dismissHUD];
                                               if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                                   
                                                   NSInteger state = [responseObject[@"auditState"] integerValue];
                                                   [self changeViewControllerWithState:state];
                                               }
                                           } failure:^(NSError *error) {
                                               [VJDProgressHUD dismissHUD];
                                               [self pushLoginController];//请求失败，跳转登录界面
                                               
                                           }];
        
    }else{
        //已经登录，直接进入主页
        VelectricTabbarController * tabbar = [[VelectricTabbarController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController =tabbar;
        
    }
    
    
    
}

/**
 *  跳转界面
 *
 *  state--审核状态：1未审核 2审核通过 3审核不通过 4审核中
 */
- (void)changeViewControllerWithState:(NSInteger)state {
    switch (state) {
        case 1:
        {
            [self pushLoginController];
        }
            break;
        case 2:
        {
            [self pushMainController];
        }
            break;
        case 3:
        {
            [self pushLoginController];
            [self pushCheckStr:@"2"];
        }
            break;
        case 4:
        {
            [self pushLoginController];
            [self pushCheckStr:@"1"];
        }
            break;
            
            
        default:
            break;
    }
}


/**
 *  跳转到主页
 */
- (void)pushMainController {

    [UserDefaults setBool:YES forKey:DEFINE_STRING_LOGIN];
    VelectricTabbarController * tabbar = [[VelectricTabbarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
}

/**
 *  跳转到会员审核页面
 */
-(void)pushCheckStr:(NSString *)str
{
    CheckViewController * check = [[CheckViewController alloc]init];
    check.checkType = str;
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:check animated:NO];
    
}

/**
 *  跳到登录页面
 */
- (void)pushLoginController {
    LoginViewController * login = [[LoginViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:login];
    [loginNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"barBg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [loginNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [loginNav.navigationBar setShadowImage:[UIImage new]];
    UIImage *image = [UIImage imageNamed:@"backJianTou-1"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    loginNav.navigationBar.backIndicatorImage = image;
    loginNav.navigationBar.backIndicatorTransitionMaskImage = image;
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    loginNav.navigationItem.backBarButtonItem = backBtn;
    
    [UIApplication sharedApplication].keyWindow.rootViewController =loginNav;
}

/**
 *   跳转到完善会员页面
 */
//-(void)pushMember
//{
//    memberMeansController * member = [[memberMeansController alloc]init];
//    member.isForm = @"1";
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:member];
//    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
//}

@end
