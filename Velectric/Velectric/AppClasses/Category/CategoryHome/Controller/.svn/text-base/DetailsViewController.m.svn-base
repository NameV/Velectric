//
//  AppDelegate.m
//  Velectric
//
//  Created by QQ on 2016/11/17.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "DetailsViewController.h"
#import "SDCycleScrollView.h"
#import "CellConfig.h"
#import "CartViewController.h"
#import "CommodityInfoCell.h"
#import "CommodityPraiseCell.h"
#import "CommodityPackCell.h"
#import "DetailsBtnView.h"

#import "MBProgressHUD.h"
#import "DetailsMode.h"
#import "FactoryViewController.h"
#import "CartViewController.h"
#import "BrandsModel.h"
#import "OrderSettlementVC.h"
#import "CartListModel.h"
#import "UIButton+ImageTitleSpacing.h"//Button 图片文字样式

#import "SearchViewController.h"

#import "VProductListPayVC.h"//结算清单界面f

#import "VSubDetailView.h"//弹出的规格型号页面
#import "CartModel.h"
#import "SCCartTool.h"
#import "VScanBigImageView.h"//浏览大图view

@interface DetailsViewController ()<UITableViewDataSource, UITableViewDelegate,SDCycleScrollViewDelegate,MBProgressHUDDelegate,UIWebViewDelegate>
{
    MBProgressHUD *HUD;
    NSArray *_images;
    UILabel *_indexPage;
    NSMutableDictionary * dataDic;
    NSMutableArray * mutableArray;//多个型号添加到数组中
    NSMutableArray * ppBtnNumberArr;//多个型号添加到数组中的数量
    NSMutableArray * ppBtnObjectArr;//多个pp对象添加到数组中的数量
    NSInteger collectionProduct;    //产品是否被收藏

}
@property (nonatomic, strong) UITableView *tableView;
/// cellConfig数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
//详情的data
@property (nonatomic, strong) NSMutableArray *detailsArray;

/// 数据模型
@property (nonatomic, strong) DetailsMode *modelToShow;

@property (nonatomic, strong)UIBarButtonItem * rightBotton;

@property (nonatomic, strong)UIButton * goodsBtn;//商品的Btn

@property (nonatomic, strong)UIButton * detailBtn;//详情的Btn
@property (nonatomic, strong) UIView * detailView;

@property (nonatomic, strong) UITableView *tableView1;

@property (nonatomic, assign)BOOL isSelcted;//显示详情或者商品

@property (nonatomic, strong) UIView *tanView;//左上角的弹框

@property (nonatomic, strong) NSMutableDictionary *btnDic;//添加购物车的pamers

@property (nonatomic, copy) NSString *payNumber;//添加购物车的数量
@property (nonatomic, strong)UIWebView * web;//加载的webView

@property (nonatomic, strong)DetailsBtnView  *bottomToolBar;

@property (nonatomic, assign)NSInteger cartQuantity;//购物车数量

@property (nonatomic, copy)NSString * minimumOrderQuantity;//最小起订量

@property (nonatomic, strong)DetailsBtnView  *guiGeView;//规格型号的View

@property (nonatomic, strong) NSMutableArray *allProductArray;//结算的时候所有的商品

@property (nonatomic, strong) VSubDetailView *produtSubView;//规格型号的view
@property (nonatomic, strong) UIView *grayBgView;//规格型号的背景view

/* 浏览大图 */
@property (nonatomic, strong) VScanBigImageView *scanBigImage;
/* 点击大图消失 */
@property (nonatomic, strong) UITapGestureRecognizer *missBigImageTap;

@end

@implementation DetailsViewController


- (DetailsMode *)modelToShow
{
    if (!_modelToShow) {
        _modelToShow = [DetailsMode new];
        // 假数据
        _modelToShow.detailsName=@"苹果（Apple）iPhone 6 (A1586) 16GB 金色 移动联通电信4G手机";
        _modelToShow.detailsActivity=@"初心未变，全场普惠，天天618.详情尽在iPhone天天618";
        _modelToShow.detailsPrice=@"￥4783.00";
        _modelToShow.detailsImgZX=@"ZX_Phone";
        _modelToShow.detailsTxtZX=@"比电脑购买省5元";
        _modelToShow.detailsSelect=@"金色 公开版 16GB 非合约机1个 可选延保";
        _modelToShow.detailsAddress=@"辽宁 沈阳市 铁西区";
        _modelToShow.detailsPraise=@"95%";
        _modelToShow.detailsPerson=@"46331人评论";
        
    }
    return _modelToShow;
}
/**
 *  改变不同类型cell的顺序、增删时，只需在此修改即可，
 *  无需在多个tableView代理方法中逐个修改
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        // 二维数组作为tableView的结构数据源
        _dataArray = [NSMutableArray array];

    }
     return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"商品详情"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   // self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    [self setupNavigationItem];
    
    //初始化视图
    [self initView];
    //创建详情的view
    [self creatDetail];
    //创建底部btn
    [self creatBtn];
    
    [self.view addSubview:self.grayBgView];
    self.grayBgView.hidden = YES;
    [self.view addSubview:self.produtSubView];//详情页
    self.produtSubView.hidden = YES;
    [self.view addSubview:self.scanBigImage];//浏览大图
    [self.scanBigImage addTapAction:self selector:@selector(missbigImage:)];
    
    mutableArray = [NSMutableArray array];
    ppBtnNumberArr= [NSMutableArray array];
    ppBtnObjectArr= [NSMutableArray array];
    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-24-self.bottomToolBar.height-self.bottomToolBar.height)];
    self.web = web;
    web.delegate = self;
    //请求购物车数量
    [self loadUpdata];
    
    //请求网络数据s
    [self LoadUpdata];

    
}
#pragma mark - 请求购物车的数量
-(void)loadUpdata
{
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGetCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        NSString * carNumStr =[NSString stringWithFormat:@"%@",responseObject[@"cart"][@"totalQuantity"]];
        self.cartQuantity = [carNumStr integerValue];
        self.bottomToolBar.yuanJiaoLable.text = [NSString stringWithFormat:@"%ld",(long)self.cartQuantity];
        if (!(self.cartQuantity==0)) {
            self.bottomToolBar.yuanJiaoLable.hidden = NO;
            self.bottomToolBar.yuanJiaoLable.text =carNumStr;
        }
    } failure:^(NSError *error) {
        ELog(@"失败");
        [_tableView headerEndRefreshing];
    }];
}

#pragma mark  规格型号的请求网络数据的方法
-(void)LoadUpdata
{
    [VJDProgressHUD  showProgressHUD:nil];
    NSDictionary * parameters = @{@"id":self.iD ? self.iD : @"",
                                  @"loginName":GET_USER_INFO.loginName ? GET_USER_INFO.loginName : @""
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetProductIdDetailURL parameters:parameters success:^(NSDictionary *responseObject) {
         dataDic= responseObject[@"product"];
         _dataArray = dataDic[@"goodsLs"];
        self.minimumOrderQuantity = dataDic[@"minimumOrderQuantity"];
        if ([@"RS200"isEqualToString:responseObject[@"code"]]) {
            if (!_dataArray) {
                [VJDProgressHUD showTextHUD:@"请求数据异常"];
                return ;
            }
            [VJDProgressHUD showSuccessHUD:@"获取成功"];
        }else{
            [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
        }
        [self addHistoryRecord];//添加历史记录
        if (!_dataArray) {
            return;
        }else{
            [_tableView reloadData];
        }
        //收藏或者取消收藏按钮标题
        if ([responseObject[@"collectionProduct"] isEqual:@1]) {
            [self.bottomToolBar.collectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
            [self.bottomToolBar.collectBtn setImage:[UIImage imageNamed:@"取消收藏图标"] forState:UIControlStateSelected];
            [self.bottomToolBar.collectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
            
        }else {
            [self.bottomToolBar.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
            [self.bottomToolBar.collectBtn setImage:[UIImage imageNamed:@"收藏图标"] forState:UIControlStateSelected];
            [self.bottomToolBar.collectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:INTERNET_ERROR];
    }];
}

//添加历史记录
- (void)addHistoryRecord {
    NSString *picturUrl ;
    
    NSArray *array = dataDic[@"pictureUrl"];
    if ([array.class isSubclassOfClass:[NSArray class]]) {
        NSDictionary *dic;
        if (array.count > 0) {
            dic = [array firstObject];
            picturUrl = dic[@"goodsPictureUrl"];
        }else {
            picturUrl = @"";
        }
    }else if ([array.class isSubclassOfClass:[NSString class]]) {
        picturUrl = (NSString *)array;
    }
    
    NSDictionary *paramDic = @{
                               @"memberId"  :   GET_USER_INFO.memberId,
                               @"id"        :   [dataDic.allKeys containsObject:@"id"] ? dataDic[@"id"] : @"",
                               @"name"      :   [dataDic.allKeys containsObject:@"name"] ? dataDic[@"name"] : @"",
                               @"price"     :   [dataDic.allKeys containsObject:@"salesPrice"] ? dataDic[@"salesPrice"] : @"",
                               @"code"      :   [dataDic.allKeys containsObject:@"code"] ? dataDic[@"code"]  : @"",
                               @"pictureUrl":   picturUrl ? picturUrl : @""
                               };
    
    //[VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:HistoricalFootprintSaveURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                          // [VJDProgressHUD showSuccessHUD:nil];
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                            //   [VJDProgressHUD showSuccessHUD:nil];
                                           }else{
                                             //  [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                          // [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

#pragma mark 底部btn 的创建
-(void)creatBtn
{
   DetailsBtnView  *btnView = [[[NSBundle mainBundle]loadNibNamed:@"DetailsBtnView" owner:nil options:nil] firstObject];
    btnView.yuanJiaoLable.text = @"1";
    btnView.yuanJiaoLable.layer.cornerRadius = 3;
    btnView.yuanJiaoLable.clipsToBounds = YES;
    btnView.yuanJiaoLable.font = [UIFont systemFontOfSize:9];
    btnView.yuanJiaoLable.hidden = YES;
    
    [btnView.collectBtn setImage:[UIImage imageNamed:@"收藏图标"] forState:UIControlStateNormal];
    [btnView.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    
    [btnView.collectBtn setImage:[UIImage imageNamed:@"取消收藏图标"] forState:UIControlStateSelected];
    [btnView.collectBtn setTitle:@"取消收藏" forState:UIControlStateSelected];
    
    [btnView.collectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
    [btnView.goFactoryBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
    [btnView.cartBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
    
    self.bottomToolBar = btnView;
    [self.view addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@50);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [btnView.goFactoryBtn addTarget:self action:@selector(goFactoryTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnView.cartBtn addTarget:self action:@selector(goFactoryTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnView.addCartBtn addTarget:self action:@selector(goFactoryTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnView.goPayBtn addTarget:self action:@selector(goFactoryTouch:) forControlEvents:UIControlEventTouchUpInside];
 //规格型号的页面
    DetailsBtnView  *guiGeView = [[[NSBundle mainBundle]loadNibNamed:@"DetailsBtnView" owner:nil options:nil] lastObject];
    [self.view addSubview:guiGeView];
    [guiGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.height);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    guiGeView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    self.guiGeView = guiGeView;
    [guiGeView.cancleBtn addTarget:self action:@selector(cancleHidden) forControlEvents:UIControlEventTouchUpInside];
    self.guiGeView.hidden = YES;
    
    //收藏button
    [btnView.collectBtn addTarget:self action:@selector(goFactoryTouch:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 取消规格型号的页面
-(void)cancleHidden
{
    self.guiGeView.hidden = YES;
}
#pragma mark 详情页的创建

-(void)creatDetail
{
    UIView * detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    detailView.backgroundColor = [UIColor whiteColor];
    detailView.hidden =YES;
    self.detailView =detailView;
    [self.view addSubview:self.detailView];
    //创建顶部Btn
    [self topBtn];
}
#pragma mark 详情页顶部btn 的创建

-(void)topBtn
{
    UIButton * goFactoryBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.25, 40)];
    [goFactoryBtn setTitle:@"商品介绍" forState:UIControlStateNormal];
    self.goFactoryBtn = goFactoryBtn;
    [goFactoryBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
    goFactoryBtn.titleLabel.textColor = RGBColor(242, 182, 1);
    goFactoryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [goFactoryBtn addTarget:self action:@selector(goTopFactoryTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailView addSubview:goFactoryBtn];
    goFactoryBtn.backgroundColor = [UIColor whiteColor];
    
    UIButton * cart = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.25, 0, SCREEN_WIDTH*0.25, 40)];
    self.cart = cart;
    [cart setTitle:@"规格参数" forState:UIControlStateNormal];
    [cart setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    cart.titleLabel.font = [UIFont systemFontOfSize:15];
    [cart addTarget:self action:@selector(goTopFactoryTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailView addSubview:cart];
    cart.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * addCart = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5,0, SCREEN_WIDTH*0.25, 40)];
    self.addCart = addCart;
    [addCart setTitle:@"包装清单" forState:UIControlStateNormal];
    [addCart setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    addCart.titleLabel.font = [UIFont systemFontOfSize:15];
    [addCart addTarget:self action:@selector(goTopFactoryTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailView addSubview:addCart];
    addCart.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * goPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.75,0, SCREEN_WIDTH*0.25, 40)];
    self.goPayBtn = goPayBtn;
    [goPayBtn setTitle:@"售后" forState:UIControlStateNormal];
    [goPayBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    goPayBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [goPayBtn addTarget:self action:@selector(goTopFactoryTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailView addSubview:goPayBtn];
    goPayBtn.backgroundColor = [UIColor whiteColor];

}
#pragma mark  顶部btn 的点击方法
-(void)goTopFactoryTouch:(UIButton *)btn
{
    self.isSelcted = NO;
    self.tanView.hidden =YES;
    
    [self.goFactoryBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    [self.cart setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    [self.goPayBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    [self.addCart setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    if ([btn.titleLabel.text isEqualToString:@"商品介绍"]) {
        ELog(@"商品介绍");
        [btn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        NSString * urlStr =[NSString stringWithFormat:@"%@?type=1&productId=%@",ProductInfoDetailsUrl,self.iD];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        // [NSURLRequest allowsAnyHTTPSCertificateForHost:urlStr];
        [self.view addSubview:self.web];
        self.view.backgroundColor =[UIColor whiteColor];
        [self.web loadRequest:request];

    }else if ([btn.titleLabel.text isEqualToString:@"规格参数"]) {
        ELog(@"规格参数");
        [btn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        NSString * urlStr =[NSString stringWithFormat:@"%@?type=2&productId=%@",ProductInfoDetailsUrl,self.iD];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        // [NSURLRequest allowsAnyHTTPSCertificateForHost:urlStr];
        [self.view addSubview:self.web];
        self.view.backgroundColor =[UIColor whiteColor];
        [self.web loadRequest:request];
    }else if ([btn.titleLabel.text isEqualToString:@"包装清单"]) {
        ELog(@"包装清单");
        [btn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        NSString * urlStr =[NSString stringWithFormat:@"%@?type=3&productId=%@",ProductInfoDetailsUrl,self.iD];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        // [NSURLRequest allowsAnyHTTPSCertificateForHost:urlStr];
        [self.view addSubview:self.web];
        self.view.backgroundColor =[UIColor whiteColor];
        [self.web loadRequest:request];
    }else if ([btn.titleLabel.text isEqualToString:@"售后"]) {
        ELog(@"售后");
        [btn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        NSString * urlStr =[NSString stringWithFormat:@"%@?type=4&productId=%@",ProductInfoDetailsUrl,self.iD];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        // [NSURLRequest allowsAnyHTTPSCertificateForHost:urlStr];
        [self.view addSubview:self.web];
        self.view.backgroundColor =[UIColor whiteColor];
        [self.web loadRequest:request];
    }
}

#pragma mark  设置navbar 的方法

- (void)setupNavigationItem {
   
    UIView * barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, 44)];
    barView.alpha =0;
    self.navigationItem.titleView = barView;
    UIButton * goodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, 40, 30)];
    self.goodsBtn = goodsBtn;
    [goodsBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
    [goodsBtn setTitle:@"商品" forState:UIControlStateNormal];
    goodsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [goodsBtn addTarget:self action:@selector(goodsdetaiBtn:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:goodsBtn];
    
    UIButton * detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-230, 5, 40, 30)];
    [detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    [barView addSubview:detailBtn];
    
    self.detailBtn = detailBtn;
    [detailBtn addTarget:self action:@selector(goodsdetaiBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH-40, 50, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"sandan"] forState:UIControlStateNormal];
    UIBarButtonItem * rightBotton = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.rightBotton = rightBotton;
    [rightBtn addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBotton;
    
}

#pragma mark 切换商品与详情
-(void)goodsdetaiBtn:(UIButton *)btn
{
    
    
    if (btn == self.goodsBtn) {
        if (self.tableView.hidden == YES) {
            self.isSelcted = NO;
            self.tanView.hidden =YES;
        }
        ELog(@"商品");
        self.tableView.hidden =NO;
        self.detailView.hidden = YES;
        [self.web removeFromSuperview];
        [self.goodsBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        [self.detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        if (self.tableView.hidden == NO) {
            self.isSelcted = NO;
            self.tanView.hidden =YES;
        }
        [self.detailBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        [self.goodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.tableView.hidden =YES;
        self.detailView.hidden = NO;
        NSString * urlStr =[NSString stringWithFormat:@"%@?type=1&productId=%@",ProductInfoDetailsUrl,self.iD];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
       // [NSURLRequest allowsAnyHTTPSCertificateForHost:urlStr];
        [self.view addSubview:self.web];
        [self.view bringSubviewToFront:self.bottomToolBar];
        self.view.backgroundColor =[UIColor whiteColor];
        [self.web loadRequest:request];
        ELog(@"详情");
    }
}


#pragma mark 隐藏弹窗的btn

-(void)cancleBtn
{
    if (self.isSelcted) {
        self.isSelcted = NO;
        self.tanView.hidden =YES;
    }else{
        self.isSelcted =YES;
        [self.view bringSubviewToFront:self.tanView];
        self.tanView.hidden =NO;
    }
}

- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-80) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.tableHeaderView =[self addHeaderView];
    
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    [self.view addSubview:view];
    
    
    UIView * tanView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 0, 110, 125)];
    tanView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tancuang"]];
    UIButton * homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 110, 44)];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 47, 110, 44)];
    homeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    UIButton * castomBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 86, 110, 44)];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [castomBtn setTitle:@"客服" forState:UIControlStateNormal];
    castomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [homeBtn addTarget:self action:@selector(kuangBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn addTarget:self action:@selector(kuangBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [castomBtn addTarget:self action:@selector(kuangBtnTouch:) forControlEvents:UIControlEventTouchUpInside];

    [tanView addSubview:homeBtn];
    [tanView addSubview:searchBtn];
    [tanView addSubview:castomBtn];

    self.tanView = tanView;
    tanView.hidden = YES;
    [self.view addSubview:tanView];

}
//弹框上的按钮
-(void)kuangBtnTouch:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"首页"]) {
        self.tabBarController.selectedIndex = 0;
       [self.navigationController popToRootViewControllerAnimated:YES];
  //  [[NSNotificationCenter defaultCenter] postNotificationName:DETAILTOHOME_HOME_SUCCESS object:nil];
    }else if ([btn.titleLabel.text isEqualToString:@"搜索"]){
        SearchViewController *search = [[SearchViewController alloc]init];
        [self.navigationController pushViewController:search animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"客服"]){
        NSString *allString = [NSString stringWithFormat:@"tel:400-8988618"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
    }
    ELog(@"弹框");
}

#pragma mark 购物车等相关Btn 的方法
-(void)goFactoryTouch:(UIButton*)btn
{
    if ([btn.titleLabel.text isEqualToString:@"进入厂商"]) {
              ELog(@"进入厂商");
        FactoryViewController * factory = [[FactoryViewController alloc]init];
        factory.manufacturerId =dataDic[@"manufacturerId"];
        factory.manufacturerName=dataDic[@"brandName"];
        factory.type = @"2";
        BrandsModel * model =[[BrandsModel alloc]init];
        model.name = dataDic[@"brandName"];
        model.Id = dataDic[@"manufacturerId"];
        factory.cartFlog = @"cart";
        factory.brandsModel = model;
        [self.navigationController pushViewController:factory animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"购物车"]){
        ELog(@"购物车");
        CartViewController * cart = [[CartViewController alloc]init];
        cart.fromDetailFlag = @"detail";
        [self.navigationController pushViewController:cart animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"加入购物车"]){
        ELog(@"加入购物车");
        if ([GET_USER_INFO.loginName isEqualToString:TestLoginName]) {//测试账号，显示请登录按钮
            [VJDProgressHUD showTextHUD:ReLoginToast];
            return;
        }
        if (mutableArray.count) {
            [self addLotCartNetWorking];
        }else{
            [self addCartNetWorking];
        }
    }else if ([btn.titleLabel.text isEqualToString:@"立即结算"]){
        if ([GET_USER_INFO.loginName isEqualToString:TestLoginName]) {//测试账号，显示请登录按钮
            [VJDProgressHUD showTextHUD:ReLoginToast];
            return;
        }
        //----------------------之前代码-----------------------
//        if (mutableArray.count) {
//            [self lotPay];
//        }else{
//            [self aPay];
//        }
//               ELog(@"去结算");
        //----------------------------------------------
        [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:OrderFromeProductDetail];
        if (mutableArray.count) {
            [self addLotCartNetWorkingBackground];
        }else{
            [self addCartNetWorkingBackground];
        }
    }else if ([btn.titleLabel.text isEqualToString:@"收藏"]) {
        [self collectProductWithBtn:btn];
    }else if ([btn.titleLabel.text isEqualToString:@"取消收藏"]) {
        [self cancelCollectionProductWithBtn:btn];
    }
}

//---------------------------------------------------立即结算先加入购物车begin------------------------------------------------------------
#pragma mark 单个加入购物车加入购物车的方法
-(void)addCartNetWorkingBackground
{
    _btnDic = [_dataArray firstObject];//默认取第一个元素，不选中也能加入购物车
    if (!(_btnDic[@"id"])) {
        [VJDProgressHUD showTextHUD:@"请选择产品型号"];
        return;
    }
    //给圆角赋值
    self.cartQuantity = self.cartQuantity + [_payNumber integerValue];
    [VJDProgressHUD showProgressHUD:nil];
    NSString * goodId = _btnDic[@"id"];
    NSDictionary * parameters = @{@"goodId":goodId,
                                  @"quantity":_payNumber,
                                  @"loginName":GET_USER_INFO.loginName
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetAddGoodsToCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            [VJDProgressHUD showSuccessHUD:nil];
            [self loadCartDatas];
            [SCCartTool getCartQuality];//同步购物车角标
        }else{
            [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}
#pragma mark 批量加入购物车的方法
-(void)addLotCartNetWorkingBackground
{
    
    _btnDic = [_dataArray firstObject];//默认取第一个元素，不选中也能加入购物车
    NSString *goodId = nil;
    NSString * payNumber = nil;
    for (NSDictionary * dic in mutableArray) {//获取多个型号
        if (goodId) {
            goodId= [NSString stringWithFormat:@"%@,%@",goodId,dic[@"id"]];
        }else{
            goodId = dic[@"id"];
        }
    }
    for (PPNumberButton * btn in ppBtnObjectArr) {//获取每个型号对应的数量
        //给圆角赋值
        self.cartQuantity = self.cartQuantity + [btn.currentNumber integerValue];
        if (payNumber) {
            payNumber= [NSString stringWithFormat:@"%@,%@",payNumber,btn.currentNumber];
        }else{
            payNumber = btn.currentNumber;
        }
    }
    if ((!goodId)||!(payNumber)) {
        [VJDProgressHUD showTextHUD:@"请选择产品型号"];
        return;
    }
    
    NSDictionary * parameters = @{@"goodsIdStr":goodId,
                                  @"quantitys":payNumber,
                                  @"loginName":GET_USER_INFO.loginName
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetBatchAddGoodsToCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            [self loadCartDatas];
            [SCCartTool getCartQuality];//同步购物车角标
        }else{
            [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
        }
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}
//--------------------------------------------------立即结算先加入购物车end-----------------------------------------------------
//--------------------------------------------------立即结算请求购物车数据begin-----------------------------------------------------

#pragma mark 请求购物车数据
-(void)loadCartDatas
{
    
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGetCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        [self.allProductArray removeAllObjects];
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            
            //给圆角赋值
            self.cartQuantity = self.cartQuantity + [_payNumber integerValue];
            
            [VJDProgressHUD showSuccessHUD:nil];
            //品牌-数据
            NSDictionary * baskets = responseObject[@"cart"][@"baskets"];
            NSArray * brands = [baskets allKeys];
            for (NSString * brandsName in brands) {
                //品牌信息
                NSDictionary * brandsInfo = [baskets objectForKey:brandsName];
                CartListModel * cListModel = [[CartListModel alloc]init];
                [cListModel setValuesForKeysWithDictionary:brandsInfo];
                [self.allProductArray addObject:cListModel];
            }
            OrderSettlementVC *orderVC = [[OrderSettlementVC alloc]init];
            NSMutableArray * productListArr1 = [NSMutableArray arrayWithArray:self.allProductArray];
            for (int i=0; i<productListArr1.count; i++) {//循环出要传的model
                CartListModel * cartListModel = productListArr1[i];
                for (int j = 0; j < cartListModel.cartList.count; j++) {
                    CartModel * cartModel = cartListModel.cartList[j];
                    if (!cartModel.selected) {
                        [cartListModel.cartList removeObject:cartModel];
                        j--;
                        if (cartListModel.cartList.count==0) {
                            [productListArr1 removeObject:cartListModel];
                            i--;
                        }
                    }
                }
            }
            orderVC.settlemnetType = OrderSettlement_More;
            orderVC.productList = productListArr1;
            [self.navigationController pushViewController:orderVC animated:YES];

        }else{
            [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

//--------------------------------------------------立即结算请求购物车数据end-----------------------------------------------------

#pragma mark - 收藏商品

//收藏商品
- (void)collectProductWithBtn:(UIButton *)btn {
    NSString *picturUrl ;
    NSArray *array = dataDic[@"pictureUrl"];
    if (array.count > 0) {
        NSDictionary *dic = [array firstObject];
        picturUrl = dic[@"goodsPictureUrl"];
    }else {
        picturUrl = @"";
    }
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  @"productId":self.iD,
                                  @"name" : dataDic[@"name"] ? dataDic[@"name"] : @"",
                                  @"price" : dataDic[@"salesPrice"] ? dataDic[@"salesPrice"] : @"",
                                  @"pictureUrl" : picturUrl
                                  };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:CollectionProductURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            [btn setTitle:@"取消收藏" forState:UIControlStateNormal];
            [VJDProgressHUD showSuccessHUD:@"收藏成功"];
        }else {
            [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
        }
        [self.bottomToolBar.collectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
        
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

//取消收藏商品
- (void)cancelCollectionProductWithBtn:(UIButton *)btn {
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  @"productId":self.iD
                                  };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:CancelCollectionProductURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        [btn setTitle:@"收藏" forState:UIControlStateNormal];
        [VJDProgressHUD showSuccessHUD:@"取消成功"];
        [self.bottomToolBar.collectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark 多个型号去结算
-(void)lotPay
{
    _btnDic = [_dataArray firstObject];//默认取第一个元素，不选中也能加入购物车
    NSString *goodId = nil;
    NSString * payNumber = nil;
    NSMutableArray * totalPriceArr = [NSMutableArray array];//每个产品的单价
    NSMutableArray * numberArr = [NSMutableArray array];//每个型号的产品数量
    CGFloat totalPrice = 0.0 ;

    for (NSDictionary * dic in mutableArray) {//获取多个型号的商品id
        if (goodId) {
            goodId= [NSString stringWithFormat:@"%@,%@",goodId,dic[@"id"]];
        }else{
            goodId = dic[@"id"];
        }
        [totalPriceArr addObject:dic[@"salesPrice"]];
    }
    for (PPNumberButton * btn in ppBtnObjectArr) {//获取每个型号对应的数量
        if (payNumber) {
            payNumber= [NSString stringWithFormat:@"%@,%@",payNumber,btn.currentNumber];
        }else{
            payNumber = btn.currentNumber;
        }
        [numberArr addObject:btn.currentNumber];
    }
        for (int a =0; a<numberArr.count; a++) {
         totalPrice = [numberArr[a] floatValue]*[totalPriceArr[a] floatValue]+totalPrice;
        }

    
//    for (int a =0; a<ppBtnNumberArr.count; a++) {
//     totalPrice = [ppBtnNumberArr[a] floatValue]*[totalPriceArr[a] floatValue]+totalPrice;
//    }
    
    if (!(goodId||payNumber||totalPrice)) {//计算多件商品的总价
        [VJDProgressHUD showTextHUD:@"请选择产品型号"];
        return;
    }
    
    OrderSettlementVC * orderVC = [[OrderSettlementVC alloc]init];
    orderVC.settlemnetType = OrderSettlement_Single;
    orderVC.totalPrice = totalPrice;//总价格
    orderVC.goodsIdStr = goodId;//商品ID
    orderVC.quantitys = payNumber;//商品数量
    [self.navigationController pushViewController:orderVC animated:YES];


}
#pragma mark 单个型号去结算
-(void)aPay
{
    _btnDic = [_dataArray firstObject];//默认取第一个元素，不选中也能加入购物车
    if (!(_btnDic[@"id"])) {
        [VJDProgressHUD showTextHUD:@"请选择产品型号"];
        return;
    }
    [VJDProgressHUD showProgressHUD:nil];
    NSString * goodId = _btnDic[@"id"];
    OrderSettlementVC * orderVC = [[OrderSettlementVC alloc]init];
    orderVC.settlemnetType = OrderSettlement_Single;
    orderVC.totalPrice = [_btnDic[@"salesPrice"] floatValue]*[_payNumber floatValue];//总价格
    orderVC.goodsIdStr = goodId;//商品ID
    orderVC.quantitys =_payNumber; //商品数量
    [self.navigationController pushViewController:orderVC animated:YES];
}


#pragma mark 单个加入购物车加入购物车的方法
-(void)addCartNetWorking
{
    _btnDic = [_dataArray firstObject];//默认取第一个元素，不选中也能加入购物车
    if (!(_btnDic[@"id"])) {
        [VJDProgressHUD showTextHUD:@"请选择产品型号"];
        return;
    }
    //给圆角赋值
    self.cartQuantity = self.cartQuantity + [_payNumber integerValue];
    [VJDProgressHUD showProgressHUD:nil];
    NSString * goodId = _btnDic[@"id"];
    NSDictionary * parameters = @{@"goodId":goodId,
                                  @"quantity":_payNumber,
                                  @"loginName":GET_USER_INFO.loginName
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetAddGoodsToCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        self.bottomToolBar.yuanJiaoLable.text = [NSString stringWithFormat:@"%ld",self.cartQuantity];
        self.bottomToolBar.yuanJiaoLable.hidden =NO;
        [VJDProgressHUD showSuccessHUD:@"加入购物车成功"];
        [SCCartTool getCartQuality];//获取购物车角标数量
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}
#pragma mark 批量加入购物车的方法
-(void)addLotCartNetWorking
{
    
    _btnDic = [_dataArray firstObject];//默认取第一个元素，不选中也能加入购物车
    NSString *goodId = nil;
    NSString * payNumber = nil;
    for (NSDictionary * dic in mutableArray) {//获取多个型号
        if (goodId) {
            goodId= [NSString stringWithFormat:@"%@,%@",goodId,dic[@"id"]];
        }else{
            goodId = dic[@"id"];
        }
    }
    for (PPNumberButton * btn in ppBtnObjectArr) {//获取每个型号对应的数量
        //给圆角赋值
        self.cartQuantity = self.cartQuantity + [btn.currentNumber integerValue];
        if (payNumber) {
            payNumber= [NSString stringWithFormat:@"%@,%@",payNumber,btn.currentNumber];
        }else{
            payNumber = btn.currentNumber;
        }
    }
    if ((!goodId)||!(payNumber)) {
        [VJDProgressHUD showTextHUD:@"请选择产品型号"];
        return;
    }
    
    NSDictionary * parameters = @{@"goodsIdStr":goodId,
                                  @"quantitys":payNumber,
                                  @"loginName":GET_USER_INFO.loginName
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetBatchAddGoodsToCartURL parameters:parameters success:^(NSDictionary *responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            
            [VJDProgressHUD showTextHUD:@"加入购物车成功"];
            _bottomToolBar.yuanJiaoLable.text = [NSString stringWithFormat:@"%ld",self.cartQuantity];
            _bottomToolBar.yuanJiaoLable.hidden = NO;
            
            [SCCartTool getCartQuality];//获取购物车角标数量
            
        }else{
            [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

//弃用
- (UIView*)addHeaderView{
    
    NSString *picturUrl;
    NSMutableArray *picUrlArray = [NSMutableArray array];
    
    NSArray *array = dataDic[@"pictureUrl"];
    if ([array.class isSubclassOfClass:[NSArray class]]) {
        NSDictionary *dic;
        if (array.count > 0) {
            dic = [array firstObject];
            picturUrl = [NSString stringWithFormat:@"%@/%@",V_Base_ImageURL,dic[@"goodsPictureUrl"]];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:picturUrl]];
            UIImage *image = [UIImage imageWithData:data]; // 取得图片
            [picUrlArray addObject:image];
        }else {
            picturUrl = @"";
        }
    }else if ([array.class isSubclassOfClass:[NSString class]]) {
        picturUrl = [NSString stringWithFormat:@"%@/%@",V_Base_ImageURL,(NSString *)array];
        [picUrlArray addObject:picturUrl];
    }
    
    if (picUrlArray.count > 0) {
        _images = [picUrlArray copy];
    }else{
        _images = @[[UIImage imageNamed:@"placeholder2"]];
    }
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-280)];    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) delegate:self placeholderImage:nil];
    cycleScrollView.autoScroll = NO;
    cycleScrollView.infiniteLoop = NO;
    cycleScrollView.localizationImageNamesGroup = _images;
    
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    [view addSubview:cycleScrollView];
    UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"circleBackground"]];
    imageView.frame=CGRectMake(cycleScrollView.frame.size.width-70, cycleScrollView.frame.size.height-70, 50, 50);
    [cycleScrollView addSubview:imageView];
    _indexPage=[[UILabel alloc]initWithFrame:CGRectMake(0,0, imageView.frame.size.width, imageView.frame.size.height)];
    _indexPage.textAlignment = NSTextAlignmentCenter;
    _indexPage.font=[UIFont systemFontOfSize:24];
    _indexPage.textColor=[UIColor whiteColor];
 //   _indexPage.text=[NSString stringWithFormat:@"%i/%i",cycleScrollView.indexPage+1,(int)_images.count];
    [imageView addSubview:_indexPage];
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.tableView1) {
        return 3;
    }else{
        if (_dataArray) {
            if ([_dataArray.class isSubclassOfClass:[NSArray class]]) {
                return _dataArray.count+2;
            }
        }
        return 0;
    }
}

#pragma mark 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.text = @"首页";
            cell.imageView.image = [UIImage imageNamed:@"wupipeijieguoicon"];
        }
        return cell;
    }
    
    if (indexPath.row==0) {
        
    CommodityPraiseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommodityPraiseCell" owner:self options:nil] lastObject];
    }
        cell.pinpaiLable.text = dataDic[@"name"];
        cell.littleLable.text =[NSString stringWithFormat:@"%@ 件",dataDic[@"description"]] ;
        cell.moneyLable.text = dataDic[@"salesPrice"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }else if (indexPath.row==1){
        CommodityPackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CommodityPackCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSDictionary * dic =  _dataArray[indexPath.row-2];
        CommodityPackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CommodityPackCell" owner:self options:nil]firstObject];
        PPNumberButton * numberBtn = [PPNumberButton numberButtonWithFrame:CGRectZero];
        numberBtn.isCanEdit = YES;
        numberBtn.tag = (indexPath.row+10)*10;
        numberBtn.minValue = [self.minimumOrderQuantity integerValue];//设置最小起订量
        VJDWeakSelf;
        numberBtn.resultBlock = ^(NSString *num){
            weakSelf.payNumber = num;
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _payNumber = numberBtn.currentNumber;
        numberBtn.increaseTitle = @"＋";
        numberBtn.decreaseTitle = @"－";
        numberBtn.inputFieldFont = 15;
        numberBtn.increaseImage = [UIImage imageNamed:@"jiaShen"];
        numberBtn.decreaseImage = [UIImage imageNamed:@"jianShen"];
        [cell.bgView addSubview:numberBtn];
        [numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.bgView.mas_top);
            make.right.equalTo(cell.bgView.mas_right);
            make.height.equalTo(@30);
            make.width.equalTo(@100);
        }];
        cell.xinghaoAmoneyLable.text =dic[@"name"];
        cell.numberLable.text =dic[@"salesPrice"];
        cell.xuanBtn.tag =indexPath.row +10;
        cell.xuanBtn.hidden = YES ;//不选中也能加入购物车，隐藏选择按钮
        if (_dataArray.count>1) {
             [cell.xuanBtn addTarget:self action:@selector(duoXuanBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else{
             [cell.xuanBtn addTarget:self action:@selector(xuanBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        //详情弹出框button
        UIButton *popDetailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        popDetailBtn.tag = indexPath.row + 5000;
        popDetailBtn.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:popDetailBtn];
        [popDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(50);
            make.top.bottom.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView.mas_right).offset(-130);
        }];
//        [popDetailBtn addTarget:self action:@selector(popDetailBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }
}
#pragma mark =====  多个型号选中的情况
-(void)duoXuanBtn:(UIButton *)btn
{
    NSInteger  tager = btn.tag*10;
    PPNumberButton * ppbtn = (PPNumberButton *)[self.view viewWithTag:tager];
    
    NSDictionary * dic = nil;
    if (btn.selected) {
        btn.selected = NO;
        dic = _dataArray[btn.tag-12];
        if ([mutableArray containsObject:dic]) {
            [mutableArray removeObject:dic];
        }
  //      if ([ppBtnNumberArr containsObject:ppbtn]) {
    //        [ppBtnNumberArr removeObject:ppbtn];
       // }
        
        if ([ppBtnObjectArr containsObject:ppbtn]) {
            [ppBtnObjectArr removeObject:ppbtn];
        }
        
        [btn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    }else{
        btn.selected = YES;
        [btn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
        dic = _dataArray[btn.tag-12];
        [mutableArray addObject:dic];
     //   [ppBtnNumberArr addObject:ppbtn.currentNumber];
        [ppBtnObjectArr addObject:ppbtn];
    }
    
    
    
}



#pragma mark ===== 单个型号选择的btn 对应的方法
-(void)xuanBtnTouch:(UIButton *)btn
{
    NSDictionary * dic = nil;
    if (btn.selected) {
        btn.selected = NO;
        [btn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
        [_btnDic removeAllObjects];
    }else{
        btn.selected = YES;
        [btn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
        dic = _dataArray[btn.tag-12];
  //      NSArray * dicTwo = dic[@"goodsEavAttributes"];
        _btnDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
}


#pragma mark - TableView Delegate
#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


#pragma mark Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *picturUrl;
    NSMutableArray *picUrlArray = [NSMutableArray array];
    
    //拼接图片URL
    NSArray *array = dataDic[@"pictureUrl"];
    if ([array.class isSubclassOfClass:[NSArray class]]) {
        NSDictionary *dic;
        if (array.count > 0) {
            for (NSDictionary *value in array) {
                dic = value;
                picturUrl = [NSString stringWithFormat:@"%@/%@",V_Base_ImageURL,dic[@"goodsPictureUrl"]];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:picturUrl]];
                UIImage *image = [UIImage imageWithData:data]; // 取得图片
                if (image) {
                    [picUrlArray addObject:image];
                }
            }
        }else {
            picturUrl = @"";
        }
    }else if ([array.class isSubclassOfClass:[NSString class]]) {
        picturUrl = [NSString stringWithFormat:@"%@/%@",V_Base_ImageURL,(NSString *)array];
        [picUrlArray addObject:picturUrl];
    }
    
    //************TODO
    if (picUrlArray.count) {
        [picUrlArray addObject:picUrlArray[0]];
    }
    //************
    
    //看数组里面是否有图片，没有图片显示默认图片
    if (picUrlArray.count > 0) {
        _images = [picUrlArray copy];
    }else{
        _images = @[[UIImage imageNamed:@"placeholder2"]];
    }
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-280)];
    
    //
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) delegate:self placeholderImage:nil];
    cycleScrollView.autoScroll = NO;
    cycleScrollView.infiniteLoop = NO;
    cycleScrollView.localizationImageNamesGroup = _images;
    
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    [view addSubview:cycleScrollView];
    /*
    UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"circleBackground"]];
    imageView.frame=CGRectMake(cycleScrollView.frame.size.width-70, cycleScrollView.frame.size.height-70, 50, 50);
    [cycleScrollView addSubview:imageView];
    _indexPage=[[UILabel alloc]initWithFrame:CGRectMake(0,0, imageView.frame.size.width, imageView.frame.size.height)];
    _indexPage.textAlignment = NSTextAlignmentCenter;
    _indexPage.font=[UIFont systemFontOfSize:24];
    _indexPage.textColor=[UIColor whiteColor];
    //   _indexPage.text=[NSString stringWithFormat:@"%i/%i",cycleScrollView.indexPage+1,(int)_images.count];
    [imageView addSubview:_indexPage];
     */
    if (_dataArray.count) {
        UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(cycleScrollView.frame.size.width-50, cycleScrollView.frame.size.height-50, 40, 40)];
        pageView.backgroundColor = [UIColor grayColor];
        [cycleScrollView addSubview:pageView];
        pageView.clipsToBounds = YES;
        pageView.layer.cornerRadius = 20;
        pageView.alpha = 0.9;
        
        _indexPage=[[UILabel alloc]initWithFrame:CGRectMake(0,0, pageView.frame.size.width, pageView.frame.size.height)];
        _indexPage.textAlignment = NSTextAlignmentCenter;
        _indexPage.font=[UIFont systemFontOfSize:20];
        _indexPage.textColor=[UIColor whiteColor];
        _indexPage.text=[NSString stringWithFormat:@"0/%i",(int)_images.count];
        [pageView addSubview:_indexPage];
    }
    
    return view;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.frame.size.height-280;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView1) {
        return 44;
    }
    
    if (indexPath.row==0) {
        return SCREEN_HEIGHT*0.2;
        
    }
    return 44;
}

- (NSMutableArray *)allProductArray {
    if (!_allProductArray) {
        _allProductArray = [NSMutableArray array];
    }
    return _allProductArray;
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
    self.scanBigImage.hidden = NO;
    self.scanBigImage.index = index;
    self.scanBigImage.datas = [_images mutableCopy];
    [self.scanBigImage.collectionView reloadData];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)indexOnPageControl:(NSInteger)index{
     _indexPage.text=[NSString stringWithFormat:@"%i/%i",(int)index+1,(int)_images.count];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    _indexPage.text=[NSString stringWithFormat:@"%i/%i",(int)index+1,(int)_images.count];
}

#pragma mark - produtSubViewCanel

- (void)produtSubViewCanel:(UIButton *)btn {
    self.produtSubView.hidden = YES;
    self.grayBgView.hidden = YES;
}

//点击弹出详情view
- (void)popDetailBtnAction:(UIButton *)btn {
    
    NSInteger tag = btn.tag - 5000;
    if (tag >= 2) {
        [self.view bringSubviewToFront:self.grayBgView];
        self.grayBgView.hidden = NO;
        [self.view bringSubviewToFront:self.produtSubView];
        
        //图片
        NSString *picturUrl ;
        
        NSArray *array = dataDic[@"pictureUrl"];
        if ([array.class isSubclassOfClass:[NSArray class]]) {
            NSDictionary *dic;
            if (array.count > 0) {
                dic = [array firstObject];
                picturUrl = dic[@"goodsPictureUrl"];
            }else {
                picturUrl = @"";
            }
        }else if ([array.class isSubclassOfClass:[NSString class]]) {
            picturUrl = (NSString *)array;
        }
        NSString *pictureUrlString = [NSString stringWithFormat:@"%@/%@",V_Base_ImageURL,picturUrl];
        [self.produtSubView.iconImage sd_setImageWithURL:[NSURL URLWithString:pictureUrlString] placeholderImage:[UIImage imageNamed:@"placeholder2"]];
        
        //价格、规格、型号
        NSDictionary * dic =  _dataArray[tag-2];
        
        NSString *priceValue = dic[@"salesPrice"] ;
        self.produtSubView.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[priceValue floatValue]];
        self.produtSubView.productTypeValueLabel.text = dic[@"name"];
        self.produtSubView.minValueLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"minimumOrderQuantity"]];
        self.produtSubView.guigeString = dic[@"propvalue"];
//        self.produtSubView.guigeString = @"时间了反馈,爱是来得及发来看撒,asdj,阿萨德飞机,aslfjl";
        self.produtSubView.hidden = NO;
    }
}

#pragma mark - 浏览大图消失
- (void)missbigImage:(UITapGestureRecognizer *)tap {
    self.scanBigImage.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - getter

- (VSubDetailView *)produtSubView {
    if (!_produtSubView) {
        _produtSubView = [[VSubDetailView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
        [_produtSubView.cancelBtn addTarget:self action:@selector(produtSubViewCanel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _produtSubView;
}

- (UIView *)grayBgView {
    if (!_grayBgView) {
        _grayBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _grayBgView.backgroundColor = [UIColor grayColor];
        _grayBgView.alpha = 0.6;
    }
    return _grayBgView;
}

- (VScanBigImageView *)scanBigImage {
    if (!_scanBigImage) {
        _scanBigImage = [[VScanBigImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scanBigImage.hidden = YES;
    }
    return _scanBigImage;
}

- (UITapGestureRecognizer *)missBigImageTap {
    if (!_missBigImageTap) {
        _missBigImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missbigImage:)];
    }
    return _missBigImageTap;
}

-(void)dealloc {
    //订单的进入方式  置为零 ,这样在订单返回的时候，不收影响
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:OrderFromeProductDetail];
}

@end
