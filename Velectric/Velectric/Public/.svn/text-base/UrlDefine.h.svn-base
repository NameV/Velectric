//
//  UrlDefine.h
//  Velectric
//
//  Created by hongzhou on 2016/12/12.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#ifndef UrlDefine_h
#define UrlDefine_h

// base url（1:测试环境；2:仿真环境 3:本地 4:正式环境）
#define NetEnvironment  2
/************* 本地环境 *************/
//测试
#define RequestApiBaseURL_Locatal          @"http://192.168.1.124:8080/vjd-wts"
//购物车 + 登录
#define RequestApiShopCarURL_Locatal       @"http://192.168.1.73:80"
//图片
#define RequestApiPictureURL_Locatal       @"http://image.vjidian.com"
//智能搜索
#define RequestApiSearchURL_Locatal        @"http://192.168.1.124:8080/vjd-wts"
//分类
#define RequestCategoryURL_Locatal         @"http://admin.vjidian.net"
//H5Url
#define H5URL_Local                         @"http://about.vjidian.com"

/************* 测试环境 *************/
//测试
#define RequestApiBaseURL_Test         @"http://192.168.1.8:8100/wts"
//购物车 + 登录
#define RequestApiShopCarURL_Test       @"http://192.168.1.8:8333"
//图片
#define RequestApiPictureURL_Test       @"http://image.vjidian.com"
//智能搜索
#define RequestApiSearchURL_Test        @"http://106.75.80.137:8080"
//分类
#define RequestCategoryURL_Test         @"http://admin.vjidian.net"
//H5Url
#define H5URL_Test                      @"http://about.vjidian.com"
//支付宝支付异步回调
#define RequestAlipayURL_Test           @"http://106.75.26.130:8300"

/************* 仿真环境 *************/
//测试
#define RequestApiBaseURL_Dev           @"https://wts.vjidian.com"//  @"http://106.75.26.130:8101"
//购物车 + 登录
//@"http://192.168.1.124:8081"
#define RequestApiShopCarURL_Dev        @"https://busi.vjidian.com"//    @"http://106.75.26.130:8100"
//图片
#define RequestApiPictureURL_Dev        @"https://imgs.vjidian.com"// @"http://image.vjidian.com"
//智能搜索
#define RequestApiSearchURL_Dev         @"https://search.vjidian.com" //@"http://106.75.80.137:8080"
//分类
#define RequestCategoryURL_Dev          @"https://admin.vjidian.net"//@"http://admin.vjidian.net"
//h5 产品详情界面
#define RequestDetailesURL_Dev          @"https://weiduan.vjidian.com"// @"http://weiduan.vjidian.com"
//H5Url
#define H5URL_Dev                       @"https://weiduan.vjidian.com"//@"http://weiduan.vjidian.com"
//支付宝支付异步回调
#define RequestAlipayURL_Dev            @"https://pay.vjidian.com"//@"http://106.75.26.130:8300"

/************* 正式环境 *************/
//测试
#define RequestApiBaseURL_Dis           @"https://appwts.vjidian.com"
//购物车 + 登录
//@"http://192.168.1.124:8081"
#define RequestApiShopCarURL_Dis        @"https://business.vjidian.com"
//图片
#define RequestApiPictureURL_Dis        @"https://images.vjidian.com"
//智能搜索
#define RequestApiSearchURL_Dis         @"https://searchmall.vjidian.com"
//分类
#define RequestCategoryURL_Dis          @"https://admin.vjidian.com"
//h5 产品详情界面
#define RequestDetailesURL_Dis          @"https://beian.vjidian.com"
//H5Url
#define H5URL_Dis                       @"https://beian.vjidian.com"
//支付宝支付异步回调
#define RequestAlipayURL_Dis            @"https://payment.vjidian.com"


// 测试环境
#if (NetEnvironment == 1)
    #define CreateRequestApiBaseUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiBaseURL_Test,path]
    #define CreateRequestApiShopCarUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiShopCarURL_Test,path]
    #define CreateRequestApiPictureUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiPictureURL_Test,path]
    #define CreateRequestApiSearchUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiSearchURL_Test,path]
    #define CreateRequestApiCategoryUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestCategoryURL_Test,path]
    #define CreateRequestApiProdectUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiSearchURL_Test,path]
    #define CreateH5Url(path)                         [NSString stringWithFormat:@"%@/%@",H5URL_Test,path]
    #define CreateAlipayUrl(path)                 [NSString stringWithFormat:@"%@/%@",RequestAlipayURL_Test,path]
    #define V_Base_ImageURL                     @"http://image.vjidian.com"
    #define V_HomeViewBannerUrl                 @"http://192.168.1.8:8100/wts"
// 仿真环境
#elif (NetEnvironment == 2)
    #define CreateRequestApiBaseUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiBaseURL_Dev,path]
    #define CreateRequestApiShopCarUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiShopCarURL_Dev,path]
    #define CreateRequestApiPictureUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiPictureURL_Dev,path]
    #define CreateRequestApiSearchUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiSearchURL_Dev,path]
    #define CreateRequestApiCategoryUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestCategoryURL_Dev,path]
    #define CreateH5Url(path)                         [NSString stringWithFormat:@"%@/%@",H5URL_Dev,path]
    #define CreateAlipayUrl(path)                 [NSString stringWithFormat:@"%@/%@",RequestAlipayURL_Dev,path]
    #define V_Base_ImageURL                     @"https://imgs.vjidian.com"
    #define V_HomeViewBannerUrl                 @"https://wts.vjidian.com"

// 本地环境
#elif (NetEnvironment == 3)
    #define CreateRequestApiBaseUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiBaseURL_Dev,path]
    #define CreateRequestApiShopCarUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiShopCarURL_Locatal,path]
    #define CreateRequestApiPictureUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiPictureURL_Dev,path]
    #define CreateRequestApiSearchUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiSearchURL_Dev,path]
    #define CreateRequestApiCategoryUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestCategoryURL_Dev,path]
    #define CreateH5Url(path)                         [NSString stringWithFormat:@"%@/%@",H5URL_Local,path]

// 正式环境
#elif (NetEnvironment == 4)
    #define CreateRequestApiBaseUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiBaseURL_Dis,path]
    #define CreateRequestApiShopCarUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiShopCarURL_Dis,path]
    #define CreateRequestApiPictureUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiPictureURL_Dis,path]
    #define CreateRequestApiSearchUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestApiSearchURL_Dis,path]
    #define CreateRequestApiCategoryUrl(path)     [NSString stringWithFormat:@"%@/%@",RequestCategoryURL_Dis,path]
    #define CreateH5Url(path)                      [NSString stringWithFormat:@"%@/%@",H5URL_Dis,path]
    #define CreateAlipayUrl(path)                 [NSString stringWithFormat:@"%@/%@",RequestAlipayURL_Dis,path]
    #define V_Base_ImageURL                     @"https://images.vjidian.com"
    #define V_HomeViewBannerUrl                 @"https://appwts.vjidian.com"

#endif

//-------------------------- 登录 Begin ----------------------
/**
 *  登录
 */
#define GetLoginCheckPATH         @"login/loginCheck"
#define GetLoginCheckURL          CreateRequestApiShopCarUrl(GetLoginCheckPATH)

/**
 *  获取短信验证码
 */
#define GetGetsmsVerifyCodePATH         @"login/getsmsVerifyCode"
#define GetGetsmsVerifyCodeURL          CreateRequestApiShopCarUrl(GetGetsmsVerifyCodePATH)

/**
 *  忘记密码
 */
#define GetChangePasswordPATH         @"login/forgotpassword"
#define GetChangePasswordURL          CreateRequestApiShopCarUrl(GetChangePasswordPATH)

/**
 *  完善会员资料
 */
#define GetRegisterMemberInfoPATH         @"member/registerMemberInfo" //@"member/registerUpdata"
#define GetRegisterMemberInfoURL          CreateRequestApiBaseUrl(GetRegisterMemberInfoPATH)

/**
 *  修改会员资料
 */
#define GetGegisterUpdataPATH         @"member/registerUpdata" //@"member/registerUpdata"
#define GetGegisterUpdataURL          CreateRequestApiBaseUrl(GetGegisterUpdataPATH)



/**
 *  省 市 三级联动
 */
#define GetFindChildrenPATH         @"region/findChildren"
#define GetFindChildrenURL          CreateRequestApiBaseUrl(GetFindChildrenPATH)


/**
 *  图形验证码的网络请求
 */
#define GetGetVerifyCodePATH         @"login/getVerifyCode"
#define GetGetVerifyCodeURL          CreateRequestApiShopCarUrl(GetGetVerifyCodePATH)

//-------------------------- 登录 End   ----------------------


//-------------------------- 分类 Begin ----------------------

/**
 *  分类一级界面
 */
#define GetGetTreePATH         @"vjidian-category/category/getTree"
#define GetGetTreeURL          CreateRequestApiCategoryUrl(GetGetTreePATH)

/**
 *  智能搜索
 */
#define GetSuggestPATH         @"suggestNew"
#define GetSuggestURL          CreateRequestApiSearchUrl(GetSuggestPATH)


/**
 *  商品列表信息
 */
//#define GetSearchProductPaginationResultPATH         @"searchProductPaginationResult"
//#define GetSearchProductPaginationResultURL          CreateRequestApiSearchUrl(GetSearchProductPaginationResultPATH)

/**
 *  商品列表信息
 */
#define GetSearchProductPaginationResultPATH         @"searchGoodsPagination"
#define GetSearchProductPaginationResultURL          CreateRequestApiSearchUrl(GetSearchProductPaginationResultPATH)

/**
 *  商品列表信息(2)
 */
#define GetProductPaginationResultPATH         @"searchProductPaginationResult"
#define GetProductPaginationResultURL          CreateRequestApiProdectUrl(GetProductPaginationResultPATH)


/**
 *  品牌，厂商详情
 */
#define GetQueryByIdPATH         @"brand/queryById"
#define GetQueryByIdURL          CreateRequestApiBaseUrl(GetQueryByIdPATH)


/**
 *  商品详情
 */
#define GetProductIdPATH         @"product/productIdDetail"
#define GetProductIdURL          CreateRequestApiBaseUrl(GetProductIdPATH)

/**
 *  商品详情(第二版)
 */
#define GetProductIdDetailPATH         @"product/productIdDetail"
#define GetProductIdDetailURL          CreateRequestApiBaseUrl(GetProductIdDetailPATH)

/**
 *  筛选 请求品牌
 */
#define GetBrandCategoryPATH         @"brand/getBrandCategory"
#define GetBrandCategoryURL          CreateRequestApiBaseUrl(GetBrandCategoryPATH)

/**
 *  筛选 请求SKU属性
 */
#define GetCategorySchemaListPATH         @"categorySchema/categorySchemaList"
#define GetCategorySchemaListURL          CreateRequestApiShopCarUrl(GetCategorySchemaListPATH)

/**
 *  筛选 请求分类id
 */
#define GetCategoryGetByBrandOrManufacturerPATH         @"category/getByBrandOrManufacturer"
#define GetCategoryGetByBrandOrManufacturerURL          CreateRequestApiBaseUrl(GetCategoryGetByBrandOrManufacturerPATH)

/**
 *  banner图--二期
 */
#define GetBannerQueryPATH                          @"banner/query"
#define BannerQueryURL                              CreateRequestApiShopCarUrl(GetBannerQueryPATH)


//-------------------------- 分类 End   ----------------------


//-------------------------- 地址管理 Begin ----------------------

/**
 *  地址列表查询
 */
#define GetFindUserAddressListPATH         @"address/findUserAddressList"
#define GetFindUserAddressListURL          CreateRequestApiBaseUrl(GetFindUserAddressListPATH)

/**
 *  添加地址
 */
#define GetSaveAddressPATH         @"address/saveAddress"
#define GetSaveAddressURL          CreateRequestApiBaseUrl(GetSaveAddressPATH)

/**
 *  查询地址详细信息
 */
#define GetFindAddressByIdPATH         @"address/findAddressById"
#define GetFindAddressByIdURL          CreateRequestApiBaseUrl(GetFindAddressByIdPATH)

/**
 *  修改地址
 */
#define GetUpdateAddressPATH         @"address/updateAddress"
#define GetUpdateAddressURL          CreateRequestApiBaseUrl(GetUpdateAddressPATH)

/**
 *  设为默认地址
 */
#define GetUpdateDefaultedPATH         @"address/updateDefaulted"
#define GetUpdateDefaultedURL          CreateRequestApiBaseUrl(GetUpdateDefaultedPATH)

/**
 *  删除地址
 */
#define GetDeleteAddressPATH         @"address/deleteAddress"
#define GetDeleteAddressURL          CreateRequestApiBaseUrl(GetDeleteAddressPATH)

/**
 *  取消默认地址
 */
#define GetCancelDefaultedPATH         @"address/cancelDefaulted"
#define GetCancelDefaultedURL          CreateRequestApiBaseUrl(GetCancelDefaultedPATH)

//-------------------------- 地址管理 End   ----------------------


//-------------------------- 订单中心 Begin ----------------------
/**
 *  订单列表
 */
#define GetOrderPagePATH         @"order/orderPage"
#define GetOrderPageURL          CreateRequestApiShopCarUrl(GetOrderPagePATH)

/**
 *  订单详情
 */
#define GetOrderDetailPATH         @"order/orderDetail"
#define GetOrderDetailURL          CreateRequestApiShopCarUrl(GetOrderDetailPATH)

/**
 *  取消订单
 */
#define GetCancelOrderPATH         @"order/cancelOrder"
#define GetCancelOrderURL          CreateRequestApiShopCarUrl(GetCancelOrderPATH)

/**
 *  确认收货
 */
#define GetReceiveOrderPATH         @"order/receiveOrder"
#define GetReceiveOrderURL          CreateRequestApiShopCarUrl(GetReceiveOrderPATH)

/**
 *  异常订单【申请】
 */
#define GetExceptionRequestOrderPATH         @"order/exceptionRequestOrder"
#define ExceptionRequestOrderURL          CreateRequestApiShopCarUrl(GetExceptionRequestOrderPATH)

//-------------------------- 订单中心 End ----------------------


//-------------------------- 支付 Begin ----------------------

/**
 *  确认订单（生成订单）
 */
#define GetCreateOrderPATH         @"order/createOrder"
#define GetCreateOrderURL          CreateRequestApiShopCarUrl(GetCreateOrderPATH)

/**
 *  确认订单（单品结算）
 */
#define GetCreateSingleOrderPATH         @"order/createSingleOrder"
#define GetCreateSingleOrderURL          CreateRequestApiShopCarUrl(GetCreateSingleOrderPATH)

/**
 *  订单提交成功
 */
#define GetMergePaymentIdPATH         @"payment/merge/mergePaymentId"
#define GetMergePaymentIdURL          CreateRequestApiShopCarUrl(GetMergePaymentIdPATH)

/**
 *  快捷支付-银行列表
 */
#define GetMergeKJPATH         @"payment/mergeKJ"
#define GetMergeKJURL          CreateRequestApiShopCarUrl(GetMergeKJPATH)

/**
 *  快捷支付-短信验证码
 */
#define GetSendMsgKJPATH         @"payment/sendMsgKJ"
#define GetSendMsgKJURL          CreateRequestApiShopCarUrl(GetSendMsgKJPATH)

/**
 *  快捷支付-立即支付
 */
#define GetPaymentKJPATH         @"payment/paymentKJ"
#define GetPaymentKJURL          CreateRequestApiShopCarUrl(GetPaymentKJPATH)

/**
 *  网关支付
 */
#define GetToPayPATH         @"payment/toPay"
#define GetToPayURL          CreateRequestApiShopCarUrl(GetToPayPATH)

/**
 *  网关支付跳转的H5
 */
#define GetPaySuccessH5PATH         @"/views/my/order/paySuccess.html"
#define GetPaySuccessH5URL          CreateH5Url(GetPaySuccessH5PATH)



/**
 *  微信支付 获取code
 */
#define GetByWeixinCodePATH         @"payWeixin/getByWeixinCode"
#define GetByWeixinCodeURL          CreateRequestApiShopCarUrl(GetByWeixinCodePATH)

/**
 *  微信支付 获取openid
 */
#define GetOpenIdPATH         @"payWeixin/getOpenId"
#define GetOpenIdURL          CreateRequestApiShopCarUrl(GetOpenIdPATH)

/**
 *  微信支付 获取支付信息
 */
#define GetPaywxHPATH         @"payWeixin/paywxH"
#define GetPaywxHURL          CreateRequestApiShopCarUrl(GetPaywxHPATH)

/**
 *  支付宝 同步回调
 */
#define GetAlipayRetifyInterfacePATH         @"appPay/alipayRetifyInterface"
#define GetAlipayRetifyInterfaceURL          CreateRequestApiShopCarUrl(GetAlipayRetifyInterfacePATH)

/**
 *  支付宝 异步回调
 */
#define GetAlipayNotifyInterfacePATH         @"aliPayInterface/alipayNotifyInterface"
#define AlipayNotifyInterfaceURL          CreateAlipayUrl(GetAlipayNotifyInterfacePATH)

/**
 *  支付宝 支付请求【安卓、ios】
 */
#define GetAlipayParamPATH                   @"appPay/alipayParam"
#define AlipayParamURL                      CreateRequestApiBaseUrl(GetAlipayParamPATH)


//-------------------------- 支付 End ----------------------


//-------------------------- 购物车 Begin ----------------------


/**
 *  购物车列表接口
 */
#define GetGetCartPATH         @"cart/getCart"
#define GetGetCartURL          CreateRequestApiShopCarUrl(GetGetCartPATH)

/**
 *  单个物品加入购物车的接口
 */
#define GetAddGoodsToCartPATH         @"cart/addGoodsToCart"
#define GetAddGoodsToCartURL          CreateRequestApiShopCarUrl(GetAddGoodsToCartPATH)

/**
 *  多个物品加入购物车的接口
 */
#define GetBatchAddGoodsToCartPATH         @"cart/batchAddGoodsToCart"
#define GetBatchAddGoodsToCartURL          CreateRequestApiShopCarUrl(GetBatchAddGoodsToCartPATH)

/**
 *   去结算的接口
 */
#define GetAddAllGoodsToCartPATH         @"cart/addAllGoodsToCart"
#define GetAddAllGoodsToCartURL          CreateRequestApiShopCarUrl(GetAddAllGoodsToCartPATH)

/**
 *   批量删除
 */
#define GetDeleteSelectedPATH         @"cart/deleteSelected"
#define GetDeleteSelectedURL          CreateRequestApiShopCarUrl(GetDeleteSelectedPATH)

/**
 *   滑动单个删除
 */
#define GetDeletePATH         @"cart/delete"
#define GetDeleteURL          CreateRequestApiShopCarUrl(GetDeletePATH)


//-------------------------- 购物车 End ----------------------


//-------------------------- 首页 Begin ----------------------

/**
 *   基本信息
 */
#define GetQueryPATH         @"index/query"
#define GetQueryURL          CreateRequestApiBaseUrl(GetQueryPATH)


/**
 *   品牌馆
 */
#define GetListByCategoryPATH         @"vjidian-basic/brandfront/listByCategory"
#define GetListByCategoryURL          CreateRequestApiCategoryUrl(GetListByCategoryPATH)


/**
 *   热卖商品-查id
 */
#define GetFindByProductFunctionPATH         @"category/findByProductFunction"
#define GetFindByProductFunctionURL          CreateRequestApiBaseUrl(GetFindByProductFunctionPATH)


//-------------------------- 首页 End ----------------------


//-------------------------- 会员中心 Begin ----------------------

/**
 *   会员资料查询
 */
#define GetFindRegistervPATH         @"member/findRegister"
#define GetFindRegistervURL          CreateRequestApiBaseUrl(GetFindRegistervPATH)

/**
 *   上传图片的接口
 */
#define GetUploadPicPATH         @"picture/uploadPic"
#define GetUploadPicURL          CreateRequestApiShopCarUrl(GetUploadPicPATH)

//-------------------------- 会员中心 End ----------------------

//-------------------------- 收藏 Begin ----------------------

/**
 *   收藏产品
 */
#define GetCollectionProductPATH         @"product/collectionProduct"
#define CollectionProductURL          CreateRequestApiBaseUrl(GetCollectionProductPATH)

/**
 *   获取收藏产品
 */
#define GetGetCollectionProductPATH         @"product/getCollectionProduct"
#define GetCollectionProductURL          CreateRequestApiBaseUrl(GetGetCollectionProductPATH)

/**
 *  取消收藏产品
 */
#define GetCancelCollectionProductPATH         @"product/cancelCollectionProduct"
#define CancelCollectionProductURL          CreateRequestApiBaseUrl(GetCancelCollectionProductPATH)

/**
 *   收藏厂商
 */
#define GetCollectionManufacturerPATH         @"manufacturer/collectionManufacturer"
#define CollectionManufacturerURL          CreateRequestApiBaseUrl(GetCollectionManufacturerPATH)

/**
 *   获取收藏厂商
 */
#define GetGetCollectionManufacturerPATH         @"manufacturer/getCollectionManufacturer"
#define GetCollectionManufacturerURL          CreateRequestApiBaseUrl(GetGetCollectionManufacturerPATH)

/**
 *   取消收藏厂商
 */
#define GetCancelCollectionManufacturerPATH         @"manufacturer/cancelCollectionManufacturer"
#define CancelCollectionManufacturerURL          CreateRequestApiBaseUrl(GetCancelCollectionManufacturerPATH)


//-------------------------- 收藏 End ----------------------

//-------------------------- 我的账户 Begin ----------------------

/**
 *   账户余额
 */
#define GetMyAccAmountPATH         @"my/myAccAmount"
#define MyAccAmountURL          CreateRequestApiShopCarUrl(GetMyAccAmountPATH)

/**
 *   已绑定银行卡
 */
#define GetMyCardPATH         @"my/myCard"
#define MyCardURL          CreateRequestApiShopCarUrl(GetMyCardPATH)

/**
 *  解绑银行卡
 */
#define GetUnbindCardPATH         @"my/unbindCard"
#define UnbindCardURL          CreateRequestApiShopCarUrl(GetUnbindCardPATH)

/**
 *   绑定卡页面
 */
#define GetShowBindCardPATH         @"my/showBindCard"
#define ShowBindCardURL          CreateRequestApiShopCarUrl(GetShowBindCardPATH)

/**
 *   小额鉴权方式绑卡
 */
#define GetBindCardByMoneyValidatePATH         @"my/bindCardByMoneyValidate"
#define BindCardByMoneyValidateURL          CreateRequestApiShopCarUrl(GetBindCardByMoneyValidatePATH)

/**
 *   短信验证方式绑卡
 */
#define GetBindCardByCaptchaValidatePATH         @"my/bindCardByCaptchaValidate"
#define BindCardByCaptchaValidateURL          CreateRequestApiShopCarUrl(GetBindCardByCaptchaValidatePATH)

/**
 *   小额鉴权验证码【小额鉴权绑卡方式发送验证码】
 */
#define GetSendBindCardMoneyPATH         @"my/sendBindCardMoney"
#define SendBindCardMoneyURL          CreateRequestApiShopCarUrl(GetSendBindCardMoneyPATH)

/**
 *   手机数字验证码【短信验证方式绑卡方式发送验证码】
 */
#define GetSendBindCardCaptchaPATH         @"my/sendBindCardCaptcha"
#define SendBindCardCaptchaURL          CreateRequestApiShopCarUrl(GetSendBindCardCaptchaPATH)

/**
 *   提现页面
 */
#define GetShowWithdrawPATH         @"my/showWithdraw"
#define GetShowWithdrawPATHURL          CreateRequestApiShopCarUrl(GetShowWithdrawPATH)

/**
 *   提现
 */
#define GetWithdrawPATH         @"my/withdraw"
#define WithdrawURL          CreateRequestApiShopCarUrl(GetWithdrawPATH)

/**
 *   短信验证码方式解绑调用的短信验证码【短信验证方式绑卡】
 */
#define GetSendMobileVerifyCodePATH         @"my/sendMobileVerifyCode"
#define SendMobileVerifyCodeURL          CreateRequestApiShopCarUrl(GetSendMobileVerifyCodePATH)

/**
 *   提现记录
 */
#define GetWithdrawRecordPATH         @"my/withdrawRecord"
#define WithdrawRecordURL          CreateRequestApiShopCarUrl(GetWithdrawRecordPATH)


//-------------------------- 我的账户 End ----------------------

//-------------------------- 帮助中心 Begin ----------------------

/**
 *   帮助中心H5
 */
#define GetHelpPATH         @"article/help"
#define HelpURL          CreateH5Url(GetHelpPATH)
//-------------------------- 帮助中心 End ----------------------

//-------------------------- 批量进货 Begin ----------------------

/**
 *   发布批量购买商品
 */
#define GetSaveBatchProductPATH         @"batch/saveBatchProduct"
#define SaveBatchProductURL          CreateRequestApiShopCarUrl(GetSaveBatchProductPATH)

/**
 *   查询单个批量购买商品
 */
#define GetGetBatchProductPATH         @"batch/getBatchProduct"
#define GetBatchProductURL          CreateRequestApiShopCarUrl(GetGetBatchProductPATH)

/**
 *   查询所有批量购买商品
 */
#define GetGetBatchProductAllPATH         @"batch/getBatchProductAll"
#define GetBatchProductAllURL          CreateRequestApiShopCarUrl(GetGetBatchProductAllPATH)

/**
 *   修改单个批量购买商品
 */
#define GetUpdateBatchProducPATH         @"batch/updateBatchProduct"
#define UpdateBatchProducURL          CreateRequestApiShopCarUrl(GetUpdateBatchProducPATH)

/**
 *   删除单个批量购买商品
 */
#define GetDeleteBatchProductPATH         @"batch/deleteBatchProduct"
#define DeleteBatchProductURL          CreateRequestApiShopCarUrl(GetDeleteBatchProductPATH)


//-------------------------- 批量进货 End ----------------------

//-------------------------- 历史足迹 Begin ----------------------
/**
 *  添加历史足迹
 */
#define GetHistoricalFootprintSavePATH         @"historicalFootprint/save"
#define HistoricalFootprintSaveURL          CreateRequestApiBaseUrl(GetHistoricalFootprintSavePATH)

/**
 *  查询历史足迹
 */
#define GetHistoricalFootprintQueryPATH         @"historicalFootprint/query"
#define HistoricalFootprintQueryURL          CreateRequestApiBaseUrl(GetHistoricalFootprintQueryPATH)

/**
 *  清空历史足迹【所有】
 */
#define GetHistoricalFootprintDeletePATH         @"historicalFootprint/delete"
#define HistoricalFootprintDeleteURL          CreateRequestApiBaseUrl(GetHistoricalFootprintDeletePATH)

/**
 *  清空历史足迹【单个】
 */
#define GetHistoricalFootprintDeleteByIdPATH         @"historicalFootprint/deleteById"
#define HistoricalFootprintDeleteByIdURL          CreateRequestApiBaseUrl(GetHistoricalFootprintDeleteByIdPATH)

//-------------------------- 历史足迹 End   ----------------------

//-------------------------- 热搜词 Begin ----------------------

/**
 *  热搜词
 */
#define GetHotWordQueryPATH         @"hotWord/query"
#define HotWordQueryURL          CreateRequestApiShopCarUrl(GetHotWordQueryPATH)

//增加
#define GetSaveSearchRecordPATH         @"searchRecord/save"
#define SaveSearchRecordURL          CreateRequestApiBaseUrl(GetSaveSearchRecordPATH)

/**
 *  搜索无结果推荐列表
 */
#define GetsearchRecommendedPATH         @"searchYouWantByGuess"
#define SearchRecommendedUrl          CreateRequestApiSearchUrl(GetsearchRecommendedPATH)



//-------------------------- 热搜词 End ----------------------

//-------------------------- H5 Begin ----------------------

/**
 *  发现
 */
#define GetDiscoverAPPPATH         @"views/discover/discover-ios.html"
#define DiscoverH5Url          CreateH5Url(GetDiscoverAPPPATH)

/**
 *  帮助中心
 */
#define GetHelpAPPPATH         @"views/my/help/help-app.html"
#define HelpCenterUrl          CreateH5Url(GetHelpAPPPATH)

/**
 *  帮助中心
 */
#define GetOrderToPayPATH         @"views/my/order/toPay.html"
#define OrderToPayUrl          CreateH5Url(GetOrderToPayPATH)

/**
 *  详情H5
 */

#define GetProductInfoDetailsPATH         @"/views/list/product_info_details.html"
#define ProductInfoDetailsUrl          CreateH5Url(GetProductInfoDetailsPATH)



//-------------------------- H5 End ----------------------



#endif /* UrlDefine_h */
