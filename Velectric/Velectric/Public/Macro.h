//
//  Macro.h
//  Velectric
//
//  Created by LYL on 2017/3/1.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#ifndef Macro_h
#define Macro_h



//客服电话
#define TelePhoneNum                    @"tel:4008988618"

//测试账号
#define TestLoginName                   @"18600874366"

//重新登录提示
#define ReLoginToast                   @"请登录"

//App Store 连接地址
#define APPURL @"https://itunes.apple.com/us/app/vjidian/id1196688931?l=zh&ls=1&mt=8"

#pragma mark ---------------- H5 URL  ----------------

////帮助中心url
//#define HelpCenterUrl                   @"http://192.168.1.8:8089/views/my/help/help-app.html"
//
////发现url
//#define DiscoverH5Url                   @"http://192.168.1.8:8089/views/discover/discover-app.html"

//搜索无结果推荐列表url
//#define SearchRecommendedUrl                   @"http://106.75.70.143:8100/searchRecommended"

//支付宝异步回调地址
//#define AliPayAsynRequestUrl            @"http://106.75.70.143:8100/aliPayInterface/alipayNotifyInterface"

//图片url前面的拼接路径
//#define V_Base_ImageURL                 @"http://image.vjidian.com"

#pragma mark ---------------- 通知宏  ----------------

//图片点击的通知方法
#define BannerJumpNotification          @"BannerJumpNotification"

//不登录去首页的通知，控制按钮的显示与否
#define ShowWithouLoginNotification          @"ShowWithouLoginNotification"

//购物车model提示主界面更新数据
#define CartViewReloadView          @"CartViewReloadView"

//立即解算定义一个字段，标记订单是从商品详情进入的，退出时退出pop出一层
#define OrderFromeProductDetail             @"OrderFromeProductDetail"

#endif /* Macro_h */
