//
//  VHomeViewController.m
//  Velectric
//
//  Created by QQ on 2016/11/26.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "VHomeViewController.h"
#import "SearchViewController.h"
#import "HSearchView.h"
#import "SDCycleScrollView.h"           //轮播图
#import "HomeTableViewCell.h"           //cell
#import "GoodsCollectionCell.h"         //商品collection cell
#import "HomeHotGoodsModel.h"
#import "HomeCategoryModel.h"
#import "UIScrollView+PSRefresh.h"      //横向加载
#import "HeaderNewView.h"               //头条
#import "NewHeaderModel.h"              //头条model
#import "BrandsView.h"                  //品牌馆
#import "BrandCollectView.h"            //品牌采集
#import "CommodityTableViewController.h"//商品列表
#import "DetailsViewController.h"       //商品详情
#import "AlertView.h"                   //提示框
#import "memberMeansController.h"       //修改资料
#import "MemberInfoVC.h"
#import "SCCartTool.h"//请求购物车数量

static CGFloat originX = 10;


@interface VHomeViewController ()<UITextFieldDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,AlertViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

//搜索view
@property (nonatomic, strong) UIView * searchBar;

//搜索输入框
@property (nonatomic, strong) UITextField * searchField;

//搜索显示view
@property (nonatomic, strong) HSearchView * searchView;

//上滑后 搜索按钮
@property (nonatomic, strong) UIButton * searchBtn;

//header
@property (nonatomic, strong) UIView * tableHeaderView;

//轮播图
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;

//统计信息
@property (nonatomic, strong) UIView * countView;

//交易额
@property (nonatomic, strong) UILabel * totalTransactionsLab;

//入住厂商
@property (nonatomic, strong) UILabel * settledManufacturersLab;

//注册商户
@property (nonatomic, strong) UILabel * registeredMerchantLab;

//热门分类
@property (nonatomic, strong) UIView * hotCategoryView;

//热门分类list
@property (nonatomic, strong) NSMutableArray <HomeCategoryModel *>* categoryList;

//头条view
@property (nonatomic, strong) HeaderNewView * headerNew;

//会员服务view
@property (nonatomic, strong) UIView * memberServiceView;

//品牌馆
@property (nonatomic, strong) BrandsView * brandsView;

//品牌采集view
@property (nonatomic, strong) BrandCollectView * brandCollectView;

//热卖商品
@property (nonatomic, strong) UIView * hotSaleGoodView;
@property (nonatomic, strong) BaseTableView * tableView;
@property (nonatomic, strong) NSMutableArray <HomeHotGoodsModel *>* hotGoodList;
@property (nonatomic, strong) NSMutableArray <UIButton *>* hotSaleBtnList;

//tableCell collectionList
@property (nonatomic, strong) NSMutableArray <UICollectionView *>* collectionList;

//没有商品时，默认数据
@property (nonatomic, strong) HomeGoodsModel * defaultGood;

//回到顶部按钮
@property (nonatomic, strong) UIButton * scrollTopBtn;

//tableview headerview的高度
@property (nonatomic, assign) CGFloat originY;

//正在操作的collection索引
@property (nonatomic, assign) NSInteger executeCollectionIndex;

@end

@implementation VHomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavBarHidden:YES];
    [MobClick beginLogPageView:@"首页"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNavBarHidden:NO];
    [MobClick endLogPageView:@"首页"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _collectionList = [NSMutableArray array];
    _categoryList = [NSMutableArray array];
    _hotGoodList = [NSMutableArray array];
    _hotSaleBtnList = [NSMutableArray array];
    
    //创建导航view
    [self creaSearchNav];
    //创建搜索view
    [self creaSearchView];
    //创建 UI
    [self creatUI];
    //创建回到顶部按钮
    [self creatScrollTopBtn];
    
    //添加通知
    [self addNotification];
    
    //perfectStatus 完善度标识 1已完善 0未完善
    if ([GET_USER_INFO.perfectStatus isEqualToString:@"0"] ) {
        AlertView * alert = [[AlertView alloc]initWithLeftTitle:@"去完善" WithRightTitle:@"取消" ContentTitle:@"您的资料尚不完善，请先完善个人资料"];
        alert.delegate = self;
        [[KGModal sharedInstance] showWithContentView:alert];
    }

    [SCCartTool getCartQuality];//获取购物车角标数量
}

#pragma mark - 添加通知
-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMemberCenter) name:COMMIT_ORDER_SUCCESS object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToHome) name:DETAILTOHOME_HOME_SUCCESS object:nil];
}

#pragma mark - 回到首页
-(void)goToHome
{
    self.tabBarController.selectedIndex =0;
}

#pragma mark - 跳转会员中心
-(void)gotoMemberCenter
{
    self.tabBarController.selectedIndex = 4;
}

#pragma mark - 创建搜索view
-(void)creaSearchNav
{
    _searchBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_searchBar];
    
    UIImageView * searchImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    searchImage.frame = CGRectMake(0, 0, 40, 20);
    searchImage.contentMode = UIViewContentModeScaleAspectFit;
    _searchField = [[UITextField alloc]initWithFrame:CGRectMake(17, 25, SCREEN_WIDTH-34, 30)];
    _searchField.leftView = searchImage;
    _searchField.leftViewMode=UITextFieldViewModeAlways;
    _searchField.delegate = self;
    _searchField.font = Font_1_F14;
    _searchField.backgroundColor = COLOR_F7F7F7_A(0.5);
    _searchField.layer.cornerRadius = 4;
    [_searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _searchField.placeholder = @"搜索V机电商品/品牌／厂商";
    [_searchBar addSubview:_searchField];
    
    UIImage * search = [UIImage imageNamed:@"sousuo"];
    _searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(17, 25, search.size.width, search.size.height)];
    [_searchBtn setImage:search forState:UIControlStateNormal];
    _searchBtn.hidden = YES;
    _searchBtn.alpha = 0;
    [_searchBtn addTarget:self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:_searchBtn];
}

-(void)creaSearchView
{
    _searchView = [[HSearchView alloc]initWithFrame:CGRectMake(0, _searchField.bottom + 5, SCREEN_WIDTH, SCREEN_HEIGHT - _searchField.bottom - 49 - 5)];
    [self.view addSubview:_searchView];
    _searchView.hidden = YES;
}

#pragma mark - 创建tableView
-(void)creatUI
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49);
    [_scrollView addHeaderWithTarget:self action:@selector(refreshNetData)];
    [_scrollView headerBeginRefreshing];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

    //创建 轮播图
    [self creatCycleScrollView];
    //创建 统计信息view
    [self creatCountView];
    //创建 热门分类
    [self creatHotCategoryView];
    //创建 头条
    [self creatHeaderNewView];
    //创建 会员服务
    [self creatMemberServiceView];
    //创建 品牌馆
    [self creatBrandView];
    //创建 品牌采集
    [self creatBrandCollectView];
    
    [self.view bringSubviewToFront:_searchBar];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _originY);
}

#pragma mark - 重载ScrollView
-(void)reloadScrollView
{
    
    self.brandCollectView.frame = CGRectMake(0, self.brandsView.bottom, SCREEN_WIDTH, self.brandCollectView.height);
    self.hotSaleGoodView.frame = CGRectMake(0, self.brandCollectView.bottom, SCREEN_WIDTH, self.hotSaleGoodView.height);
    //轮播图
    if (self.cycleScrollView.hidden) {
        self.countView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.countView.height);
        self.hotCategoryView.frame = CGRectMake(0, self.countView.bottom, SCREEN_WIDTH, self.hotCategoryView.height);
        self.headerNew.frame = CGRectMake(0, self.hotCategoryView.bottom, SCREEN_WIDTH, self.headerNew.height);
        self.memberServiceView.frame = CGRectMake(0, self.headerNew.bottom, SCREEN_WIDTH, self.memberServiceView.height);
        self.brandsView.frame = CGRectMake(0, self.memberServiceView.bottom, SCREEN_WIDTH, self.brandsView.height);
        self.brandCollectView.frame = CGRectMake(0, self.brandsView.bottom, SCREEN_WIDTH, self.brandCollectView.height);
        self.hotSaleGoodView.frame = CGRectMake(0, self.brandCollectView.bottom, SCREEN_WIDTH, self.hotSaleGoodView.height);
    }
    //统计信息
    if (self.countView.hidden) {
        self.hotCategoryView.frame = CGRectMake(0, self.cycleScrollView.bottom, SCREEN_WIDTH, self.hotCategoryView.height);
        self.headerNew.frame = CGRectMake(0, self.hotCategoryView.bottom, SCREEN_WIDTH, self.headerNew.height);
        self.memberServiceView.frame = CGRectMake(0, self.headerNew.bottom, SCREEN_WIDTH, self.memberServiceView.height);
        self.brandsView.frame = CGRectMake(0, self.memberServiceView.bottom, SCREEN_WIDTH, self.brandsView.height);
        self.brandCollectView.frame = CGRectMake(0, self.brandsView.bottom, SCREEN_WIDTH, self.brandCollectView.height);
        self.hotSaleGoodView.frame = CGRectMake(0, self.brandCollectView.bottom, SCREEN_WIDTH, self.hotSaleGoodView.height);
    }
    //头条
    if (self.headerNew.hidden) {
        self.memberServiceView.frame = CGRectMake(0, self.hotCategoryView.bottom, SCREEN_WIDTH, self.memberServiceView.height);
        self.brandsView.frame = CGRectMake(0, self.memberServiceView.bottom, SCREEN_WIDTH, self.brandsView.height);
        self.brandCollectView.frame = CGRectMake(0, self.brandsView.bottom, SCREEN_WIDTH, self.brandCollectView.height);
        self.hotSaleGoodView.frame = CGRectMake(0, self.brandCollectView.bottom, SCREEN_WIDTH, self.hotSaleGoodView.height);
    }
    //会员服务
    if (self.memberServiceView.hidden) {
        self.brandsView.frame = CGRectMake(0, self.headerNew.bottom, SCREEN_WIDTH, self.brandsView.height);
        self.brandCollectView.frame = CGRectMake(0, self.brandsView.bottom, SCREEN_WIDTH, self.brandCollectView.height);
        self.hotSaleGoodView.frame = CGRectMake(0, self.brandCollectView.bottom, SCREEN_WIDTH, self.hotSaleGoodView.height);
    }
    //品牌采集
    if (self.brandCollectView.hidden) {
        self.hotSaleGoodView.frame = CGRectMake(0, self.brandsView.bottom, SCREEN_WIDTH, self.hotSaleGoodView.height);
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.hotSaleGoodView.bottom);
}

#pragma mark - 下拉刷新
-(void)refreshNetData
{
    //请求 基本信息
    [self reuqestQuery];
}

#pragma mark - 请求 Query
-(void)reuqestQuery
{
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName ? GET_USER_INFO.loginName : @"",
                                  @"type":@"0",};
//    NSString * urlString = @"http://192.168.1.8:8100/wts/index/query";  //GetQueryURL
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetQueryURL parameters:parameters success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [_scrollView endRefreshing];
            
            weakSelf.cycleScrollView.hidden = YES;
            weakSelf.countView.hidden = YES;
            weakSelf.headerNew.hidden = YES;
//            weakSelf.memberServiceView.hidden = YES;
            weakSelf.brandCollectView.hidden = YES;
            //轮播图
            NSDictionary * lunBo = [responseObject objectForKey:@"lunBo"];
            if (lunBo) {
                if ([[lunBo objectForKey:@"display"] boolValue]) {
                    weakSelf.cycleScrollView.hidden = NO;
                    NSMutableArray * cycleScrollList = [NSMutableArray array];
                    for (NSString * string in [lunBo objectForKey:@"data"]) {
                        [cycleScrollList addObject:[NSString stringWithFormat:@"%@/%@",V_HomeViewBannerUrl,string]];
                    }
                    weakSelf.cycleScrollView.imageURLStringsGroup = cycleScrollList;
                }else{
                    weakSelf.cycleScrollView.hidden = YES;
                }
            }else{
                weakSelf.cycleScrollView.hidden = YES;
            }
            
            //统计信息
            NSDictionary * indexStatistics = [responseObject objectForKey:@"indexStatistics"];
            if (indexStatistics) {
                if ([[indexStatistics objectForKey:@"display"] boolValue]) {
                    weakSelf.countView.hidden = NO;
                    
                    NSDictionary * data = [indexStatistics objectForKey:@"data"];
                    NSString * title1 = @"交易总额:";
                    NSString * money = [data objectForKey:@"totalTransactions"];
                    NSString * moneylabText = [NSString stringWithFormat:@"%@%@",title1,money];
                    NSMutableAttributedString * attributedString1= [[NSMutableAttributedString alloc]initWithString:moneylabText];
                    [attributedString1 addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:[moneylabText rangeOfString:money]];
                    weakSelf.totalTransactionsLab.attributedText = attributedString1;
                    
                    NSString * title2 = @"入驻厂商:";
                    NSString * count1 = [[data objectForKey:@"settledManufacturers"] stringByAppendingString:@"家"];
                    NSString * enterCountlabText = [NSString stringWithFormat:@"%@%@",title2,count1];
                    NSMutableAttributedString * attributedString2= [[NSMutableAttributedString alloc]initWithString:enterCountlabText];
                    [attributedString2 addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:[enterCountlabText rangeOfString:count1]];
                    weakSelf.settledManufacturersLab.attributedText = attributedString2;
                    
                    NSString * title3 = @"注册商户:";
                    NSString * count2 = [[data objectForKey:@"registeredMerchant"] stringByAppendingString:@"家"];
                    NSString * registerCountlabText = [NSString stringWithFormat:@"%@%@",title3,count2];
                    NSMutableAttributedString * attributedString3 = [[NSMutableAttributedString alloc]initWithString:registerCountlabText];
                    [attributedString3 addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:[registerCountlabText rangeOfString:count2]];
                    weakSelf.registeredMerchantLab.attributedText = attributedString3;
                }else{
                    weakSelf.countView.hidden = YES;
                }
            }else{
                weakSelf.countView.hidden = YES;
            }
            //头条
            NSDictionary * toutiao = [responseObject objectForKey:@"toutiao"];
            if (toutiao) {
                if ([[toutiao objectForKey:@"display"] boolValue]){
                    weakSelf.headerNew.hidden = NO;
                    NSMutableArray * newsList = [NSMutableArray array];
                    for (NSDictionary * dic in [toutiao objectForKey:@"data"]) {
                        NewHeaderModel * model = [[NewHeaderModel alloc]init];
                        [model setValuesForKeysWithDictionary:dic];
                        [newsList addObject:model];
                    }
                    weakSelf.headerNew.newsList = newsList;
                }else{
                    weakSelf.headerNew.hidden = YES;
                }
            }else{
                weakSelf.headerNew.hidden = YES;
            }
            //品牌采集
            NSDictionary * brand = [responseObject objectForKey:@"brand"];
            if (brand) {
                if ([[brand objectForKey:@"display"] boolValue]) {
                    weakSelf.brandCollectView.hidden = NO;
                    NSMutableArray * brandCollectList = [NSMutableArray array];
                    for (NSString * string in [brand objectForKey:@"data"]) {
                        [brandCollectList addObject:[NSString stringWithFormat:@"%@/%@",V_HomeViewBannerUrl,string]];
                    }
                    weakSelf.brandCollectView.brandCollectList = [brandCollectList mutableCopy];
                }else{
                    weakSelf.brandCollectView.hidden = YES;
                }
            }else{
                weakSelf.brandCollectView.hidden = YES;
            }
            //默认商品
            NSDictionary * defaultGood = [responseObject objectForKey:@"defaultGood"];
            if (defaultGood) {
                _defaultGood = [[HomeGoodsModel alloc]init];
                [_defaultGood setValuesForKeysWithDictionary:defaultGood];
            }
            
            //热卖商品分类
            NSDictionary * category = [responseObject objectForKey:@"category"];
            if (category) {
                [weakSelf.hotGoodList removeAllObjects];
                NSArray * keys = [category allKeys];
                for (NSString * key in keys) {
                    HomeHotGoodsModel * hotModel = [[HomeHotGoodsModel alloc]init];
                    hotModel.Id = key;
                    hotModel.pageNum = 1;
                    hotModel.pageSize = 6;
                    if ([key isEqualToString:@"1"]) {
                        hotModel.title = @"整机";
                    }else if ([key isEqualToString:@"2"]) {
                        hotModel.title = @"配件";
                    }else if ([key isEqualToString:@"3"]) {
                        hotModel.title = @"附件";
                    }else if ([key isEqualToString:@"4"]) {
                        hotModel.title = @"耗材";
                    }
                    hotModel.idlist = [category objectForKey:key]?[category objectForKey:key]:@"";
                    [weakSelf.hotGoodList addObject:hotModel];
                }
                //创建 热卖商品
                if (!_hotSaleGoodView) {
                    [weakSelf creatHotSaleGoodView];
                }
            }else{
                _hotSaleGoodView.hidden = YES;
            }
            //重载scrollView
            [weakSelf reloadScrollView];
            //请求 品牌分类
            [weakSelf requestListByCategory];
            //请求 热卖商品
            [weakSelf requestSearchProductPaginationResult];
        }
        [weakSelf.scrollView headerEndRefreshing];
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
        [weakSelf.scrollView headerEndRefreshing];
    }];
}

#pragma mark - 请求 品牌分类
-(void)requestListByCategory
{
    VJDWeakSelf;
    NSDictionary * parameters = @{@"categoryId":@"1"};
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:GetGetTreeURL parameters:parameters success:^(NSDictionary *responseObject) {
        NSDictionary * result = [responseObject objectForKey:@"result"];
        if (![result isKindOfClass:[NSNull class]]) {
            NSArray * children = [result objectForKey:@"children"];
            if (children.count){
                [weakSelf.categoryList removeAllObjects];
                for (NSDictionary * dic in children) {
                    HomeCategoryModel * model = [[HomeCategoryModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [weakSelf.categoryList addObject:model];
                }
            }
        }
        else{
            
        }
    } failure:^(NSError *error) {
        [weakSelf.tableView endRefreshing];
    }];
}

#pragma mark - 请求 热卖商品
-(void)requestSearchProductPaginationResult
{
    __block int requestCouny = 0;
    VJDWeakSelf;
    for (HomeHotGoodsModel * hotModel in _hotGoodList){
        //默认显示3个 左滑加载更多，一次加载6条产品，直至全部加载完毕
        NSString * requestUrl = [NSString stringWithFormat:@"%@?pageNum=%@&pageSize=%@",GetSearchProductPaginationResultURL,@"1",@"3"];
        //返回有分类id请求接口，没有直接添加三个默认的
        if (hotModel.idlist.length>0) {
            NSArray * idList = [hotModel.idlist componentsSeparatedByString:@"&"];
            for (int i=0; i<idList.count; i++) {
                NSString * categoryId = [idList objectAtIndex:i];
                requestUrl = [requestUrl stringByAppendingFormat:@"&categoryIds=%@",categoryId];
            }
            
            [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
                NSArray * result = [responseObject objectForKey:@"result"];
                if (result.count){
                    requestCouny ++;
                    if (result.count == 3) {
                        hotModel.pageNum ++;
                    }
                    for (NSDictionary * dic in result) {
                        HomeGoodsModel * goods = [[HomeGoodsModel alloc]init];
                        [goods setValuesForKeysWithDictionary:dic];
                        goods.canLick = YES;
                        [hotModel.goodsList addObject:goods];
                    }
                }else{
                    for (int i=0 ; i<3; i++) {
                        HomeGoodsModel * goods = [[HomeGoodsModel alloc]init];
                        goods.name = weakSelf.defaultGood.name;
                        goods.pictureUrl = weakSelf.defaultGood.pictureUrl;
                        goods.minPrice = weakSelf.defaultGood.minPrice;
                        [hotModel.goodsList addObject:goods];
                    }
                }
                //重载数据
                NSInteger index = [weakSelf.hotGoodList indexOfObject:hotModel];
                UICollectionView * collectView = [weakSelf.hotSaleGoodView viewWithTag:index + 1];
                [collectView reloadData];
            } failure:^(NSError *error) {
                for (int i=0 ; i<3; i++) {
                    HomeGoodsModel * goods = [[HomeGoodsModel alloc]init];
                    goods.name = weakSelf.defaultGood.name;
                    goods.pictureUrl = weakSelf.defaultGood.pictureUrl;
                    goods.minPrice = weakSelf.defaultGood.minPrice;
                    [hotModel.goodsList addObject:goods];
                }
                NSInteger index = [weakSelf.hotGoodList indexOfObject:hotModel];
                UICollectionView * collectView = [weakSelf.hotSaleGoodView viewWithTag:index + 1];
                [collectView reloadData];
            }];
        }else{
            for (int i=0 ; i<3; i++) {
                HomeGoodsModel * goods = [[HomeGoodsModel alloc]init];
                goods.name = weakSelf.defaultGood.name;
                goods.pictureUrl = weakSelf.defaultGood.pictureUrl;
                goods.minPrice = weakSelf.defaultGood.minPrice;
                [hotModel.goodsList addObject:goods];
            }
            NSInteger index = [weakSelf.hotGoodList indexOfObject:hotModel];
            UICollectionView * collectView = [weakSelf.hotSaleGoodView viewWithTag:index + 1];
            [collectView reloadData];
        }
    }
}

#pragma mark - 创建回到顶部按钮
-(void)creatScrollTopBtn
{
    _scrollTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, SCREEN_HEIGHT - 100, 40, 40)];
    [_scrollTopBtn setImage:[UIImage imageNamed:@"huidaodingbu"] forState:UIControlStateNormal];
    _scrollTopBtn.layer.cornerRadius = _scrollTopBtn.width/2;
    [_scrollTopBtn addTarget:self action:@selector(doScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_scrollTopBtn];
    _scrollTopBtn.hidden = YES;
}

#pragma mark - 回到顶部
-(void)doScrollToTop
{
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - 创建 轮播图
-(void)creatCycleScrollView
{
    NSArray * imageList = @[[UIImage imageNamed:@"001.jpg"],[UIImage imageNamed:@"002.jpg"],];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180/(320/SCREEN_WIDTH)) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    _cycleScrollView.localizationImageNamesGroup= imageList;
    [_scrollView addSubview:_cycleScrollView];
    
    _originY = _cycleScrollView.bottom;
}

#pragma mark - 创建 统计信息view
-(void)creatCountView
{
    //白色背景
    _countView = [[UIView alloc]initWithFrame:CGRectMake(0, _originY, SCREEN_WIDTH, 40)];
    _countView.backgroundColor = COLOR_FFFFFF;
    [_scrollView addSubview:_countView];
    
    CGFloat width = (SCREEN_WIDTH - 40)/3;
    
    //交易总额
    NSString * money = @"1234.00";
    NSString * title1 = @"交易总额:";
    NSString * moneylabText = [NSString stringWithFormat:@"%@%@",title1,money];
    NSMutableAttributedString * attributedString1= [[NSMutableAttributedString alloc]initWithString:moneylabText];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:[moneylabText rangeOfString:money]];
    _totalTransactionsLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, width, 40)];
    _totalTransactionsLab.textColor = COLOR_666666;
    _totalTransactionsLab.font = Font_1_F11;
    _totalTransactionsLab.attributedText = attributedString1;
    _totalTransactionsLab.adjustsFontSizeToFitWidth = YES;
    _totalTransactionsLab.textAlignment = NSTextAlignmentCenter;
    [_countView addSubview:_totalTransactionsLab];
    
    //分割线
    UIView * fengeView1 = [[UIView alloc]initWithFrame:CGRectMake(_totalTransactionsLab.right + 4.5, 14, 0.5, 12)];
    fengeView1.backgroundColor = COLOR_DDDDDD;
    [_countView addSubview:fengeView1];
    
    //入驻厂家
    NSString * count1 = @"12344家";
    NSString * title2 = @"入驻厂商:";
    NSString * enterCountlabText = [NSString stringWithFormat:@"%@%@",title2,count1];
    NSMutableAttributedString * attributedString2= [[NSMutableAttributedString alloc]initWithString:enterCountlabText];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:[enterCountlabText rangeOfString:count1]];
    _settledManufacturersLab = [[UILabel alloc]initWithFrame:CGRectMake(fengeView1.right + 5, _totalTransactionsLab.top, _totalTransactionsLab.width, _totalTransactionsLab.height)];
    _settledManufacturersLab.textColor = COLOR_666666;
    _settledManufacturersLab.font = Font_1_F11;
    _settledManufacturersLab.attributedText = attributedString2;
    _settledManufacturersLab.adjustsFontSizeToFitWidth = YES;
    _settledManufacturersLab.textAlignment = NSTextAlignmentCenter;
    [_countView addSubview:_settledManufacturersLab];
    
    //分割线
    UIView * fengeView2 = [[UIView alloc]initWithFrame:CGRectMake(_settledManufacturersLab.right + 4.5, fengeView1.top, 0.5, 12)];
    fengeView2.backgroundColor = fengeView1.backgroundColor;
    [_countView addSubview:fengeView2];
    
    //注册商户
    NSString * count2 = @"1234家";
    NSString * title3 = @"注册商户:";
    NSString * registerCountlabText = [NSString stringWithFormat:@"%@%@",title3,count2];
    NSMutableAttributedString * attributedString3 = [[NSMutableAttributedString alloc]initWithString:registerCountlabText];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:[registerCountlabText rangeOfString:count2]];
    _registeredMerchantLab = [[UILabel alloc]initWithFrame:CGRectMake(fengeView2.right + 5, _totalTransactionsLab.top, _totalTransactionsLab.width, _totalTransactionsLab.height)];
    _registeredMerchantLab.textColor = COLOR_666666;
    _registeredMerchantLab.font = Font_1_F11;
    _registeredMerchantLab.attributedText = attributedString3;
    _registeredMerchantLab.adjustsFontSizeToFitWidth = YES;
    _registeredMerchantLab.textAlignment = NSTextAlignmentCenter;
    [_countView addSubview:_registeredMerchantLab];
    
    _originY = _countView.bottom;
}

#pragma mark - 创建 热门分类
-(void)creatHotCategoryView
{
    _hotCategoryView = [[UIView alloc]initWithFrame:CGRectMake(0, _originY, SCREEN_WIDTH, 100)];
    [_scrollView addSubview:_hotCategoryView];
    
    //热门分类图片
    UIImage * image = [UIImage imageNamed:@"remenfenlie"];
    UIImageView * hotImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, (32- image.size.height)/2, SCREEN_WIDTH, image.size.height)];
    hotImage.image = image;
    hotImage.contentMode = UIViewContentModeScaleAspectFit;
    [_hotCategoryView addSubview:hotImage];
    
    //白色背景
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH, 210)];
    bgView.backgroundColor = COLOR_FFFFFF;
    [_hotCategoryView addSubview:bgView];
    
    NSArray * imgList = @[@"wujin",@"jidian",@"dianqi",@"mifeng",@"shuinuanjiancai",@"yiqi",@"laobao",@"zhou",];
    NSArray * titleList = @[@"五金工具",@"机电设备",@"电器电缆",@"密封保温",@"水暖建材",@"仪器仪表",@"劳保安防",@"轴承标准件",];
    for (int i=0; i<titleList.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((i%4) * (SCREEN_WIDTH/4), (i/4)*100, SCREEN_WIDTH/4, 100);
        button.titleLabel.font = Font_1_F12;
        button.tag = i;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        UIImage * image = [UIImage imageNamed:[imgList objectAtIndex:i]];
        button.imageEdgeInsets = UIEdgeInsetsMake(20, (button.width - image.size.width)/2, 0, 0);
        [button setImage:image forState:UIControlStateNormal];
        
        CGFloat width = [[titleList objectAtIndex:i] getStringWidthWithFont:Font_1_F12];
        [button setTitle:[titleList objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:COLOR_3E3A39 forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.bottom + 8, (button.width - width)/2 - image.size.width, 0, 0);
        [button addTarget:self action:@selector(hotCategoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
    }
    //灰色线条
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, bgView.height - 0.5, SCREEN_WIDTH, 0.5)];
    bottomLine.backgroundColor = COLOR_DDDDDD;
    [bgView addSubview:bottomLine];
    
    _hotCategoryView.frame = CGRectMake(0, _originY, SCREEN_WIDTH, bgView.bottom);
    
    _originY = _hotCategoryView.bottom;
}

#pragma mark - 创建 头条
-(void)creatHeaderNewView
{
    _headerNew = [[HeaderNewView alloc]initWithFrame:CGRectMake(0, _originY, SCREEN_WIDTH, 45)];
    _headerNew.backgroundColor = COLOR_FFFFFF;
    [_scrollView addSubview:_headerNew];
    
    _originY = _headerNew.bottom;
}

#pragma mark - 创建 会员服务
-(void)creatMemberServiceView
{
    _memberServiceView = [[UIView alloc]initWithFrame:CGRectMake(0, _originY, SCREEN_WIDTH, 100)];
    [_scrollView addSubview:_memberServiceView];
    //进货
    NSString * purchaseaValue = @"进货:在线选货,线上订货,互联网时代进货新模式";
    UILabel * purchasesLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, 10, SCREEN_WIDTH - originX - 90, 20)];
    purchasesLab.textColor = COLOR_999999;
    purchasesLab.font = Font_1_F12;
    NSMutableAttributedString * attriString1 = [[NSMutableAttributedString alloc]initWithString:purchaseaValue];
    [attriString1 addAttribute:NSForegroundColorAttributeName value:COLOR_333333 range:NSMakeRange(0, 3)];
    purchasesLab.attributedText = attriString1;
    [_memberServiceView addSubview:purchasesLab];
    
    //售后
    NSString * saleAfterValue = @"售后:让消费者不再有后顾之忧";
    UILabel * saleAfterLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, purchasesLab.bottom, purchasesLab.width, purchasesLab.height)];
    saleAfterLab.textColor = COLOR_999999;
    saleAfterLab.font = Font_1_F12;
    NSMutableAttributedString * attriString2 = [[NSMutableAttributedString alloc]initWithString:saleAfterValue];
    [attriString2 addAttribute:NSForegroundColorAttributeName value:COLOR_333333 range:NSMakeRange(0, 3)];
    saleAfterLab.attributedText = attriString2;
    [_memberServiceView addSubview:saleAfterLab];
    
    //培训
    NSString * trainValue = @"培训:手把手教您如何使用进货平台";
    UILabel * trainLab = [[UILabel alloc]initWithFrame:CGRectMake(originX, saleAfterLab.bottom, purchasesLab.width, purchasesLab.height)];
    trainLab.textColor = COLOR_999999;
    trainLab.font = Font_1_F12;
    NSMutableAttributedString * attriString3 = [[NSMutableAttributedString alloc]initWithString:trainValue];
    [attriString3 addAttribute:NSForegroundColorAttributeName value:COLOR_333333 range:NSMakeRange(0, 3)];
    trainLab.attributedText = attriString3;
    [_memberServiceView addSubview:trainLab];
    
    //分割线
    UIView * fengeView2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 14, 0.5, 75 - 28)];
    fengeView2.backgroundColor = COLOR_DDDDDD;
    [_memberServiceView addSubview:fengeView2];
    
    //会员服务中心
    UIImage * image2 = [UIImage imageNamed:@"huiyuanfuwu"];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(fengeView2.right, 0, SCREEN_WIDTH - fengeView2.right, 75);
    button.titleLabel.font = Font_1_F12;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    button.imageEdgeInsets = UIEdgeInsetsMake(10, (button.width - image2.size.width)/2, 0, 0);
    [button setImage:image2 forState:UIControlStateNormal];
    NSString * title = @"会员服务中心";
    CGFloat width = [title getStringWidthWithFont:Font_1_F12];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:COLOR_3E3A39 forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.bottom + 4, (button.width - width)/2 - image2.size.width, 0, 0);
//    [button addTarget:self action:@selector(hotCategoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_memberServiceView addSubview:button];
    
    _memberServiceView.frame = CGRectMake(0, _originY, SCREEN_WIDTH, button.bottom);
    
    _originY = _memberServiceView.bottom;
}

#pragma mark - 创建 品牌馆
-(void)creatBrandView
{
    _brandsView = [[BrandsView alloc]initWithFrame:CGRectMake(0, _originY, SCREEN_WIDTH, 295)];
    _brandsView.backgroundColor = COLOR_FFFFFF;
    _brandsView.controller = self;
    [_scrollView addSubview:_brandsView];
    
    _originY = _brandsView.bottom;
}

#pragma mark - 创建 品牌采集
-(void)creatBrandCollectView
{
    _brandCollectView = [[BrandCollectView alloc]initWithFrame:CGRectMake(0, _originY, SCREEN_WIDTH, 45)];
    _brandCollectView.backgroundColor = COLOR_F7F7F7;
    _brandCollectView.clipsToBounds = YES;
    [_scrollView addSubview:_brandCollectView];
    _originY = _brandCollectView.bottom;
    
    VJDWeakSelf;
    _brandCollectView.changeFrameBlcok = ^(){
        weakSelf.hotSaleGoodView.frame = CGRectMake(0, weakSelf.brandCollectView.bottom, SCREEN_WIDTH, weakSelf.hotSaleGoodView.height);
        weakSelf.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, weakSelf.hotSaleGoodView.bottom);
    };
}

#pragma mark - 创建 热卖商品
-(void)creatHotSaleGoodView
{
    _hotSaleGoodView = [[UIView alloc]initWithFrame:CGRectMake(0, _originY, SCREEN_WIDTH, 33)];
    [_scrollView addSubview:_hotSaleGoodView];
    
    //品牌采集
    UIImage * image = [UIImage imageNamed:@"remai"];
    UIImageView * hotImageV = [[UIImageView alloc]initWithFrame:CGRectMake(originX, 0, image.size.width, 33)];
    hotImageV.image = image;
    hotImageV.contentMode = UIViewContentModeScaleAspectFit;
    [_hotSaleGoodView addSubview:hotImageV];
    
    CGFloat height = (SCREEN_WIDTH - 30)/3/(125.0/140.0);
    
    _hotSaleGoodView.frame = CGRectMake(0, _originY, SCREEN_WIDTH, hotImageV.bottom + height * _hotGoodList.count);
    
    for (int i=0; i<_hotGoodList.count; i++) {
        HomeHotGoodsModel * hotModel = [_hotGoodList objectAtIndex:i];
        //类型
        UILabel * typeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, hotImageV.bottom + i*height, 30, height)];
        if (i%2 == 0) {
            typeLab.backgroundColor = COLOR_807775;
        }else{
            typeLab.backgroundColor = COLOR_F2B602;
        }
        typeLab.font = Font_1_F15;
        typeLab.textColor = COLOR_FFFFFF;
        typeLab.numberOfLines = 0;
        typeLab.text = hotModel.title;
        typeLab.textAlignment = NSTextAlignmentCenter;
        [_hotSaleGoodView addSubview:typeLab];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(typeLab.right, typeLab.top, SCREEN_WIDTH - typeLab.right, height) collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.tag = i+1;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = COLOR_FFFFFF;
        [_hotSaleGoodView addSubview:collectionView];
        
        [collectionView registerClass:[GoodsCollectionCell class] forCellWithReuseIdentifier:@"GoodsCollectionCell"];
        VJDWeakSelf;
        __weak UICollectionView * collect = collectionView;
        [collectionView addGifRefreshFooterNoStatusWithClosure:^{
            weakSelf.executeCollectionIndex = collect.tag;
            [weakSelf loadMoreGoods];
        }];
        
        UIButton * showMoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30, typeLab.top + 15, 30, typeLab.height - 30)];
        [showMoreBtn setTitle:@"查\n看\n更\n多" forState:UIControlStateNormal];
        showMoreBtn.titleLabel.numberOfLines = 0;
        showMoreBtn.titleLabel.font = Font_1_F12;
        showMoreBtn.backgroundColor = COLOR_333333_A(0.4);
        [showMoreBtn addTarget:self action:@selector(showMoreGoods:) forControlEvents:UIControlEventTouchUpInside];
        showMoreBtn.tag = i+10;
        [_hotSaleGoodView addSubview:showMoreBtn];
        [_hotSaleBtnList addObject:showMoreBtn];
        
        UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, typeLab.bottom-0.5, SCREEN_WIDTH, 0.5)];
        bottomLine.backgroundColor = COLOR_DDDDDD;
        [_hotSaleGoodView addSubview:bottomLine];
    }
    
    _originY = _hotSaleGoodView.bottom;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _originY);
}

#pragma mark - 热卖商品 查看更多
-(void)showMoreGoods:(UIButton *)sender
{
    HomeHotGoodsModel * hotModel = [_hotGoodList objectAtIndex:sender.tag-10];
    NSArray * idList = [hotModel.idlist componentsSeparatedByString:@"&"];
    NSString * categoryIdList = @"";
    for (int i=0; i<idList.count; i++) {
        NSString * categoryId = [idList objectAtIndex:i];
        categoryIdList = [categoryIdList stringByAppendingFormat:@"&categoryIds=%@",categoryId];
    }
    
    HomeGoodsModel * model = [hotModel.goodsList firstObject];
    if (!model.canLick) {
        return;
    }
    CommodityTableViewController * commit = [[CommodityTableViewController alloc]init];
    commit.categoryIdList = categoryIdList;
    commit.fromType = @"1";
    commit.enterType = ScreeningViewEnterType2;
    [self.navigationController pushViewController:commit animated:YES];
}

#pragma mark - UIScrollView 的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag>0) {
        CGFloat offset = scrollView.contentOffset.x;
        UIButton * moreBtn = [_hotSaleBtnList objectAtIndex:scrollView.tag-1];
        if (offset >= scrollView.width/20) {
            moreBtn.hidden = YES;
        }else{
            moreBtn.hidden = NO;
        }
        return;
    }
    CGFloat offset = _scrollView.contentOffset.y;
    if (offset<0 ) {
        _searchField.hidden = YES;
        _searchBtn.hidden = YES;
    }
    else if (offset == 0) {
        _searchField.hidden = NO;
        _searchField.alpha = 1;
        _searchBtn.hidden = YES;
        _searchBtn.alpha = 0;
    }else if (offset>0 && offset<=60){
        CGFloat alpha = offset*1.0/60;
        _searchField.hidden = NO;
        _searchField.alpha = 1-alpha;
        _searchBtn.alpha = alpha;
        _searchBtn.hidden = NO;
    }else if (offset>60) {
        _searchBtn.hidden = YES;
        _searchField.alpha = 0;
        _searchBtn.alpha = 1;
        _searchBtn.hidden = NO;
    }
    
    if (offset >= _scrollView.height/2) {
        _scrollTopBtn.hidden = NO;
    }else{
        _scrollTopBtn.hidden = YES;
    }
}

//已经结束拖拽，手指刚离开view的那一刻
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offset = _scrollView.contentOffset.y;
    if (offset>=0 && offset<=30) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (offset>30 && offset<=60){
        [_scrollView setContentOffset:CGPointMake(0, 60) animated:YES];
    }
}
//已经停止滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = _scrollView.contentOffset.y;
    if (offset>=0 && offset<=30) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (offset>30 && offset<=60){
        [_scrollView setContentOffset:CGPointMake(0, 60) animated:YES];
    }
}

#pragma mark - UItextField 的代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    SearchViewController * vc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

- (void)textFieldDidChange:(id)sender
{
    UITextField * field = (UITextField *)sender;
    if (field.text.length) {
        _searchView.isSearch =YES;
        [_searchView reloadTableviewFieldText:field.text];
    }else{
        _searchView.isSearch = NO;
        [_searchView reloadTableviewFieldText:field.text];
    }
}

#pragma mark - 搜索
-(void)doSearch
{
    SearchViewController * vc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - AlertView Delegate
- (void)okBtnAction
{
    [[KGModal sharedInstance] hide];
    
    //注册 完善资料
//    memberMeansController * vc = [[memberMeansController alloc]init];
    
    //我的 修改资料
    MemberInfoVC * vc = [[MemberInfoVC alloc]init];
    vc.enterType = MemberInfoVC_Home;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancleBtnAction
{
    [[KGModal sharedInstance] hide];
}

#pragma mark - 取消搜索
-(void)cancleSearch
{
    _searchView.hidden = YES;
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationController.navigationBar endEditing:YES];
}

#pragma mark - 轮播图 SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
}

#pragma mark - 热门分类 点击
-(void)hotCategoryBtnClick:(UIButton *)sender
{
    if (!_categoryList.count) {
        return;
    }
    HomeCategoryModel * model = [_categoryList objectAtIndex:sender.tag];
    CommodityTableViewController * vc = [[CommodityTableViewController alloc]init];
    vc.enterType = ScreeningViewEnterType1;
    NSString * str = [NSString stringWithFormat:@"%ld",model.myId];
    vc.saiXuanCategoryId =model.myId;
    vc.categoryIds = @[str];
    vc.fromType = @"3";
    vc.categoryName = model.name;
    vc.categoryModel =  model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableView.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indentifer= @"indentifer";
    HomeTableViewCell * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
    if (!cell)
    {
        cell=[[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    HomeHotGoodsModel * hotModel = [_tableView.dataArray objectAtIndex:indexPath.row];
    NSString * title = hotModel.title;
    cell.typeLab.text = title;
    if (indexPath.row%2 == 0) {
        cell.typeLab.backgroundColor = COLOR_807775;
    }else{
        cell.typeLab.backgroundColor = COLOR_F2B602;
    }
    cell.collectionView.tag = indexPath.row;

    [_collectionList addObject:cell.collectionView];
    [cell.collectionView registerClass:[GoodsCollectionCell class] forCellWithReuseIdentifier:@"GoodsCollectionCell"];
    cell.collectionView.delegate = self;
    cell.collectionView.dataSource = self;
//    [cell.collectionView reloadData];
    VJDWeakSelf;
    __weak HomeTableViewCell * weakCell = cell;
    [cell.collectionView addGifRefreshFooterNoStatusWithClosure:^{
        weakSelf.executeCollectionIndex = weakCell.collectionView.tag;
        [weakSelf loadMoreGoods];
    }];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_WIDTH - 30)/3/(125.0/140.0);
}

#pragma mark - UICollectionViewDelegate
// item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-30)/3+1, (SCREEN_WIDTH - 30)/3/(125.0/140.0));
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    HomeHotGoodsModel * hotModel = [_hotGoodList objectAtIndex:collectionView.tag-1];
    return [hotModel.goodsList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionCell" forIndexPath:indexPath];
    HomeHotGoodsModel * hotModel = [_hotGoodList objectAtIndex:collectionView.tag-1];
    HomeGoodsModel * model = [hotModel.goodsList objectAtIndex:indexPath.row];
    cell.goodsModel = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeHotGoodsModel * hotModel = [_hotGoodList objectAtIndex:collectionView.tag-1];
    HomeGoodsModel * model = [hotModel.goodsList objectAtIndex:indexPath.row];
    if (model.canLick) {
        DetailsViewController * detail = [[DetailsViewController alloc]init];
        detail.iD = [NSString stringWithFormat:@"%ld",model.myId];
        detail.name = model.name;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark - 加载更多商品
-(void)loadMoreGoods
{
    [self requestGoodsData];
}

#pragma mark - 请求商品数据接口
-(void)requestGoodsData
{
    HomeHotGoodsModel * hotModel = [_hotGoodList objectAtIndex:_executeCollectionIndex - 1];
    
    //默认显示3个 左滑加载更多，一次加载6条产品，直至全部加载完毕
    NSString * requestUrl = [NSString stringWithFormat:@"%@?pageNum=%@&pageSize=%@",GetSearchProductPaginationResultURL,[NSNumber numberWithInteger:hotModel.pageNum],[NSNumber numberWithInteger:hotModel.pageSize]];
    if (hotModel.idlist.length>0)
    {
        NSArray * idList = [hotModel.idlist componentsSeparatedByString:@"&"];
        for (int i=0; i<idList.count; i++) {
            NSString * categoryId = [idList objectAtIndex:i];
            requestUrl = [requestUrl stringByAppendingFormat:@"&categoryIds=%@",categoryId];
        }
        VJDWeakSelf;
        [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
            NSArray * result = [responseObject objectForKey:@"result"];
            if (result.count){
                if (result.count >= hotModel.pageSize) {
                    hotModel.pageNum ++;
                }
                for (NSDictionary * dic in result) {
                    HomeGoodsModel * goods = [[HomeGoodsModel alloc]init];
                    [goods setValuesForKeysWithDictionary:dic];
                    goods.canLick = YES;
                    [hotModel.goodsList addObject:goods];
                }
            }
            //重载数据
            NSInteger index = [weakSelf.hotGoodList indexOfObject:hotModel];
            UICollectionView * collectView = [weakSelf.hotSaleGoodView viewWithTag:index + 1];
            [collectView reloadData];
            [collectView endRefreshing];
        } failure:^(NSError *error) {
            [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
            
            NSInteger index = [weakSelf.hotGoodList indexOfObject:hotModel];
            UICollectionView * collectView = [weakSelf.hotSaleGoodView viewWithTag:index + 1];
            [collectView endRefreshing];
        }];
    }else{
        NSInteger index = [self.hotGoodList indexOfObject:hotModel];
        UICollectionView * collectView = [self.hotSaleGoodView viewWithTag:index + 1];
        [collectView endRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
