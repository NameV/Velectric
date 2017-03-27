//
//  Header.h
//  Velectric
//
//  Created by QQ on 2016/11/18.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#ifndef Header_h
#define Header_h

/**
 * 快速写入沙河路径的宏
 */
#define UserDefaults [NSUserDefaults standardUserDefaults]

#define DEFINE_STRING_LOGIN  @"loginOrQuit"   //是否登录

#define GET_USER_INFO [VJDUserManager sharedManager] //快速获取用户信息 

#define FIRST_INSTALL [[NSUserDefaults standardUserDefaults] boolForKey:@"First_Install"]//首次安装

#define INTERNET_ERROR @"网络连接异常，请重试"

#define GOTO_ORDER_CENTER @"gotoOrderCenter"

#define PAY_SUCCESS @"paySuccess"   //支付宝支付成功跳转通知

#define COMMIT_ORDER_SUCCESS @"commitOrderSuccess"   //提交订单成功跳转通知
#define DETAILTOHOME_HOME_SUCCESS @"detailToHome"   //点击详情首页btn的通知


/**
 * 微信相关Api
 */
static NSString *kWX_DNS = @"https://api.weixin.qq.com/";

static NSString *kWX_access_token = @"sns/oauth2/access_token?";

static NSString *kWX_refresh_token = @"sns/oauth2/refresh_token?";

static NSString *kWX_auth = @"/sns/auth";

static NSString *kWx_userinfo = @"sns/userinfo";

static NSString *wx_access_token = @"access_token";

static NSString *wx_openid = @"openid";

static NSString *kWeChatAppID = @"wx3ae75c0c51423377";

static NSString *kWeChatAppSecret = @"b949f553c0dc9baa8104cd07ce6eba1f";

static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";

static NSString *kAuthState = @"xxx";

/**
 * 微信支付相关
 */
static NSString *kWX_PAY_URL = @"https://api.mch.weixin.qq.com/pay/";

static NSString *kWX_PAY_unifiedorder = @"unifiedorder";

static NSString *kWX_PAY_appid = @"appid";

/** 商户号 */
static NSString *kWX_PAY_partnerid = @"partnerid";

static NSString *kWX_PAY_partnerid_value = @"1358433002";

static NSString *kWX_PAY_package = @"package";

static NSString *kWX_PAY_package_value = @"Sign=WXPay";

#pragma mark -- 污哩8卦Api
/**
 * 答啦相关Api
 */
//调试
#ifdef DEBUG
//static NSString *kDL_DNS = @"http://dl-php.wm.com/";
//static NSString *kDL_DNS = @"https://api.wuli8g.com/";
//static NSString *BAIDU = @"https://www.baidu.";

//static NSString *kDL_DNS = @"http://uat.api.wuli8g.com/";
#else
//static NSString *kDL_DNS = @"http://uat.api.wuli8g.com/";

//static NSString *kDL_DNS = @"https://www.baidu.com/"; // Service release

//static NSString *kDL_DNS = @"http://dl-php.wm.com/"; // Service Debug
#endif

static NSString *kDL_SHARE = @"api/share_info?";

static NSString *param_agreement = @"api/agreement";

#define param_app_id @"app_id"

#define param_device_id @"device_id"

#define param_method @"method"

#define param_device_type @"device_type"

#define param_version @"version"

#define param_app_key_version @"key_version"

#define param_uuid @"uuid"

#define param_t_uuid @"t_uuid"

#define param_token @"token"

#define param_id @"id"

#define param_invite_code_info @"invite_code_info"

#define param_hots_api @"hots_api"

#define param_search_api @"search_api"

#define param_statistics_api @"statistics_api"

#define param_er_api @"api"

#define param_invite_api @"invite_api"

#define K_User_Cookie @"kUserCookie"


#endif /* Header_h */
