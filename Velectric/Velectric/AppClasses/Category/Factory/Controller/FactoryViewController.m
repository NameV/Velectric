//
//  FactoryViewController.m
//  Velectric
//
//  Created by QQ on 2016/12/5.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "FactoryViewController.h"
#import "CommodityTableViewCell.h"
#import "PPiFlatSegmentedControl.h"
#import "PinPaiDetailView.h"
#import "BrandsModel.h"
#import "VJDToolbarView.h"          //工具栏
#import "ScreeningView.h"           //筛选view
#import "FactoryModel.h"
#import "DetailsViewController.h"
#import "MJRefresh.h"
#import "SkuPropertyModel.h"
#import "VBrandDetailModel.h"

@interface FactoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray * dataArray;
    NSDictionary * headDic;
    }
@property (nonatomic, strong)PinPaiDetailView *pinpai;
@property (nonatomic, strong)UIBarButtonItem * rightBotton;
@property (nonatomic, assign)BOOL isXiaLa;
@property (nonatomic, strong)UILabel * zhuYingLable;
@property (nonatomic, strong)UIImageView * logoImage;

@property (nonatomic, strong)NSMutableArray* properyList;//属性集合
@property (nonatomic, strong)NSMutableArray * brandsList;//品牌数组

@property (nonatomic, strong)UIButton * collectBtn;     //收藏button
@property (nonatomic, strong)ScreeningView * saiXuanView;//筛选的view的创建

@property (nonatomic, strong)NSDictionary *valueDic;//厂商的value字典
@property (nonatomic, strong)VBrandDetailModel *brandDetailModel;//厂商的value字典


@end

@implementation FactoryViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView headerBeginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"";
    NSString * rightBtnTitle;
    if ([self.type isEqualToString:@"1"]) {
        rightBtnTitle = @"品牌详情";
    }else if ([self.type isEqualToString:@"2"]) {
        rightBtnTitle = @"厂商详情";
    }
    [self setRightBarButtonWithTitle:rightBtnTitle withImage:nil withAction:@selector(detailsBtn)];
    //分页的页码
    self.pageNum = 1;
    //创建 UI
    [self creatUI];
    //创建 工具栏
    [self initToolbarView];
    //创建 品牌详情
    [self creatPinPaiDetail];
    
    //请求 品牌详情
    [self requestQueryById];
    self.brandsList= [NSMutableArray arrayWithObject:_brandsModel.name ? _brandsModel.name : self.manufacturerName];
    //请求 商品列表
   // [self requestSearchProductPaginationResult];
    dataArray = [NSMutableArray array];
    headDic = [NSDictionary dictionary];
    
    self.valueDic = [NSDictionary dictionary];
    self.brandDetailModel = [[VBrandDetailModel alloc]init];
}

#pragma mark - 请求 品牌详情
-(void)requestQueryById
{   // [VJDProgressHUD showProgressHUD:nil];
    VJDWeakSelf;
   
    NSDictionary * parameters = @{@"name":_brandsModel.name ? _brandsModel.name : self.manufacturerName,
                                  @"loginName":GET_USER_INFO.loginName ? GET_USER_INFO.loginName : @"",
                                  @"id":_brandsModel.Id ? _brandsModel.Id : self.manufacturerId,
                                  @"type":self.type ? self.type : @"",     //1品牌     2厂商
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetQueryByIdURL parameters:parameters success:^(NSDictionary *responseObject) {
        
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            NSDictionary *responsDic = (NSDictionary *)responseObject;
            if ([self.type isEqualToString:@"1"]) {//品牌
                self.brandDetailModel.name = responsDic[@"name"];
                self.brandDetailModel.imageUrl = [NSString stringWithFormat:@"%@/%@",RequestApiPictureURL_Test,responsDic[@"logUrl"]];
                self.brandDetailModel.kdescription = responsDic[@"description"];
                self.brandDetailModel.manage = responsDic[@"scop"];
            }else if ([self.type isEqualToString:@"2"]) {
                NSArray *array = responsDic[@"brand"];
                if (array.count > 0 ) {
                    NSDictionary *valueDic = [array firstObject];
                    self.brandDetailModel.name = valueDic[@"company"];
                    self.brandDetailModel.imageUrl = [NSString stringWithFormat:@"%@/%@",RequestApiPictureURL_Test,valueDic[@"logUrl"]];
                    self.brandDetailModel.kdescription = valueDic[@"description"];
                    self.brandDetailModel.manage = responsDic[@"scop"];
                }
            }
            NSURL * url =[NSURL URLWithString:self.brandDetailModel.imageUrl];
            [weakSelf.logoImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
            weakSelf.zhuYingLable.text = self.brandDetailModel.kdescription;
            weakSelf.navTitle =self.brandDetailModel.name;
            [weakSelf creatPinPaiDetail];
        }
        
        //------------------------之前代码-------------------
//        headDic = responseObject;
//        NSURL * url =[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",RequestApiPictureURL_Test,headDic[@"logUrl"]]];
//        [weakSelf.logoImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
//        weakSelf.zhuYingLable.text = headDic[@"description"];
//        weakSelf.navTitle =headDic[@"name"];
//        [weakSelf creatPinPaiDetail];
        
        //------------------------之前代码end-------------------
        
        //厂商要加上收藏按钮
        if ([self.type isEqualToString:@"2"] &&
            [responseObject[@"code"] isEqualToString:@"RS200"]) {
            self.collectBtn.hidden = NO;
            //是否含有key值，判断收藏按钮标题
            if ([responseObject.allKeys containsObject:@"collectionManufacturer"]) {
                
                if ([responseObject[@"collectionManufacturer"] isEqual:@0]) {
                    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
                    [self.collectBtn setImage:[UIImage imageNamed:@"收藏图标"] forState:UIControlStateNormal];
                    [self.collectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
                }else{
                    [self.collectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
                    [self.collectBtn setImage:[UIImage imageNamed:@"取消收藏图标"] forState:UIControlStateNormal];
                    [self.collectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
                }
            }
        }else {
            self.collectBtn.hidden = YES;
        }
        
        
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:nil];
        
    }];
}

#pragma mark - 请求 商品列表
-(void)requestSearchProductPaginationResult
{
    if (!self.goodsName) {
        self.goodsName = @"";
    }
    if (!self.brandId) {
        self.brandId = @"";
    }if (!self.manufacturerName) {
        self.manufacturerName = @"";
    }if (!self.sort) {
        self.sort = @"";
    }if (!self.sortDirection) {
        self.sortDirection = @"";
    }if (!self.manufacturerId) {
        self.manufacturerId = @"";
    }if (!self.brandNames) {
        self.brandNames = @[];
    }
    
    if ([self.type isEqualToString:@"2"]) {
        [self requestChangshang];
        return;
    }
    
    if (self.enterType == ScreeningViewEnterType3) {
        [self  requestServerFromType3];
        return;
    }else if(self.isFromsearch){
        [self requestHsearch];
        return;
    }
    
    if ([self.cartFlog isEqualToString:@"cart"]) {
        [self requestCart];
        return;
    }
    
    NSString * pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];
    VJDWeakSelf;
    NSDictionary * parameters = @{@"loginName":@"",//GET_USER_INFO.loginName,     //登录名
                                  @"brandNames":self.brandsList,          //品牌名
                                  @"brandId":@"",//_brandsModel.Id,               //品牌id
                                  @"pageNum":pageNumStr,
                                  @"pageSize":@"20",
                                  @"sort":self.sort,                        //排序时传值 传’price
                                  @"sortDirection":self.sortDirection,
                                  @"goodsName":self.goodsName,                 //商品名称
                                  @"manufacturerName":self.manufacturerName,          //厂商名
                                  @"manufacturerId":self.manufacturerId,            //厂商id
                                  @"categoryName":@"",              //分类名称
                                  @"categoryIds":@"",               //分类id  数组
                                  @"keyWords":@"",
                                  @"searchWithinResult":@"",
                                  @"optionIds":@"",};
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:GetSearchProductPaginationResultURL parameters:parameters success:^(NSDictionary *responseObject) {
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        NSMutableArray * arrModel = responseObject[@"result"];
        for (NSDictionary * dic in arrModel) {
            FactoryModel * model = [[FactoryModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [dataArray addObject:model];
        }
        NSMutableArray * mutableArr = [NSMutableArray array];
        if (self.pageNum ==1) {
            dataArray = responseObject[@"result"];
        }else{
            mutableArr = [NSMutableArray arrayWithArray:dataArray];
            dataArray = responseObject[@"result"];
            for (NSDictionary * dic in dataArray) {
                [mutableArr addObject:dic];
            }
            if (dataArray.count<20) {
                [_tableView.mj_footer resetNoMoreData];
            }
            dataArray = mutableArr;
        }
        [VJDProgressHUD dismissHUD];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:INTERNET_ERROR];
    }];
}

//厂商的网络请求
-(void)requestChangshang
{
    NSString * requestUrl = nil;
    if (self.brandNameStr) {
        requestUrl= [NSString stringWithFormat:@"%@?manufacturerName=%@&pageNum=%ld&pageSize=20&minPrice=%@&maxPrice=%@&optionIds=%@&categoryName=%@",GetSearchProductPaginationResultURL,self.brandsModel.name,(long)self.pageNum
                     ,self.minPrice,self.maxPrice,self.properyId,self.categoryNameStr];
    }else{
        requestUrl= [NSString stringWithFormat:@"%@?manufacturerName=%@&pageNum=%ld&pageSize=20",GetSearchProductPaginationResultURL,self.brandsModel.name,(long)self.pageNum
                     ];
    }
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        NSMutableArray * arrModel = responseObject[@"result"];
        if (self.pageNum ==1) {
            [dataArray removeAllObjects];
            for (NSDictionary * dic in arrModel) {
                FactoryModel * model = [[FactoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
            }
        }else{
            for (NSDictionary * dic in arrModel) {
                FactoryModel * model = [[FactoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
            }
            if (dataArray.count<20) {
                [_tableView.mj_footer noticeNoMoreData];
            }
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:INTERNET_ERROR];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    }];
    
}

-(void)requestCart
{
    NSString * pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];
    NSDictionary * parameters = @{
                                  @"brandNames":self.brandsList[0],          //品牌名
                                  @"pageNum":pageNumStr,
                                  @"pageSize":@"20",
                                  @"sort":self.sort,                        //排序时传值 传’price
                                  @"sortDirection":self.sortDirection,
                                  };
    if (!self.minPrice) {
        self.minPrice =@"";
    }
    if (!self.maxPrice) {
        self.maxPrice =@"";
    }
    if (!self.properyId) {
        self.properyId = @"";
    }
    
    
    
    NSString * requestUrl = nil;
    if (self.brandNameStr) {
        requestUrl= [NSString stringWithFormat:@"%@?brandNames=%@&pageNum=%ld&pageSize=20&minPrice=%@&maxPrice=%@&optionIds=%@&categoryName=%@",GetSearchProductPaginationResultURL,self.brandsList[0],(long)self.pageNum
                     ,self.minPrice,self.maxPrice,self.properyId,self.categoryNameStr];
    }else{
        requestUrl= [NSString stringWithFormat:@"%@?brandNames=%@&pageNum=%ld&pageSize=20&minPrice=%@&maxPrice=%@",GetSearchProductPaginationResultURL,self.brandsList[0],(long)self.pageNum
                     ,self.minPrice,self.maxPrice];
    }
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        NSMutableArray * arrModel = responseObject[@"result"];
        if (self.pageNum ==1) {
            [dataArray removeAllObjects];
            for (NSDictionary * dic in arrModel) {
                FactoryModel * model = [[FactoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
            }
        }else{
            for (NSDictionary * dic in arrModel) {
                FactoryModel * model = [[FactoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
            }
            if (dataArray.count<20) {
                [_tableView.mj_footer noticeNoMoreData];
            }
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:INTERNET_ERROR];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    }];

}


-(void)requestServerFromType3
{
    
    if (!self.minPrice) {
        self.minPrice =@"";
    }
    if (!self.maxPrice) {
        self.maxPrice =@"";
    }
    if (!self.properyId) {
        self.properyId = @"";
    }
    
    NSString * requestUrl = nil;
    if (self.brandNameStr||self.categoryNameStr) {
        requestUrl= [NSString stringWithFormat:@"%@?brandNames=%@&pageNum=%ld&pageSize=20&minPrice=%@&maxPrice=%@&optionIds=%@&categoryName=%@&sort=%@&sortDirection=%@",GetSearchProductPaginationResultURL,self.brandsList[0],(long)self.pageNum
                     ,self.minPrice,self.maxPrice,self.properyId,self.categoryNameStr,self.sort,self.sortDirection];
        
    }else{
        requestUrl= [NSString stringWithFormat:@"%@?brandNames=%@&pageNum=%ld&pageSize=20&minPrice=%@&maxPrice=%@&sort=%@&sortDirection=%@",GetSearchProductPaginationResultURL,self.brandsList[0],(long)self.pageNum
                     ,self.minPrice,self.maxPrice,self.sort,self.sortDirection];
    }
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    requestUrl = [NSString stringWithFormat:@"%@&subsiteId=1",requestUrl];
   // NSString * brandNameStr = self.brandsList[0];
    NSString * pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];
    NSDictionary * parameters = @{
                                  @"brandNames":self.brandsList[0],          //品牌名
                                  @"pageNum":pageNumStr,
                                  @"pageSize":@"20",
                                  @"sort":self.sort,                        //排序时传值 传’price
                                  @"sortDirection":self.sortDirection,
                                  
                                 };
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
        NSMutableArray * mutableArr = [NSMutableArray array];
        NSMutableArray * arrModel = responseObject[@"result"];
        
        if (self.pageNum ==1) {
             [dataArray removeAllObjects];
            for (NSDictionary * dic in arrModel) {
                FactoryModel * model = [[FactoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
            }
        }else{
            for (NSDictionary * dic in arrModel) {
                FactoryModel * model = [[FactoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
            }
            if (dataArray.count<20) {
                //[_tableView.mj_footer noticeNoMoreData];
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:INTERNET_ERROR];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    }];
}


-(void)requestHsearch;
{
    // NSString * brandNameStr = self.brandsList[0];
    NSString * pageNumStr = [NSString stringWithFormat:@"%d",self.pageNum];
    NSDictionary * parameters = @{
                                  @"pageNum":pageNumStr,//分页，默认为1
                                  @"pageSize":@"20",//分页，默认20个
                                  @"keyWords":@"",//self.keyWords,
                                  @"sort":self.sort,//排序时传值传minProductPrice
                                  @"sortDirection":self.sortDirection,//升序asc 降序 desc
                                  @"searchWithinResult":@"",
                                  @"loginName":@"",
                                  @"optionIds":@"",//sku 属性
                                  @"subsiteId"  :   @"1"
                                  };
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:GetSearchProductPaginationResultURL parameters:parameters success:^(NSDictionary *responseObject) {
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        NSMutableArray * arrModel = responseObject[@"result"];
        if (self.pageNum ==1) {
            [dataArray removeAllObjects];
            for (NSDictionary * dic in arrModel) {
                FactoryModel * model = [[FactoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
            }
        }else{
            for (NSDictionary * dic in arrModel) {
                FactoryModel * model = [[FactoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArray addObject:model];
            }
            if (dataArray.count<20) {
               // [_tableView.mj_footer noticeNoMoreData];
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:INTERNET_ERROR];
    }];
}



#pragma mark - 创建 UI
-(void)creatUI
{
    UIView * toolsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT* 0.18)];
    [self.view addSubview:toolsView];
    toolsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
    UILabel * zhuYingLable = [[UILabel alloc]initWithFrame:CGRectZero];
    self.zhuYingLable = zhuYingLable;
    zhuYingLable.numberOfLines = 0;
    zhuYingLable.font = [UIFont systemFontOfSize:12];
    [toolsView addSubview:zhuYingLable];
    [zhuYingLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolsView.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(60);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.18-35);
    }];
    zhuYingLable.textColor = [UIColor whiteColor];
    UIImageView * picImage = [[UIImageView alloc]init];
    self.logoImage = picImage;
    picImage.clipsToBounds = YES;
    picImage.layer.cornerRadius = 20;
    picImage.backgroundColor = [UIColor whiteColor];
    [toolsView addSubview:picImage];
    [picImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolsView.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@40);
    }];
    
    //收藏
    [toolsView addSubview:self.collectBtn];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(toolsView.mas_right).offset(-10);
        make.bottom.equalTo(toolsView.mas_bottom).offset(-5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
//    if ([self.type isEqualToString:@"1"]) {
//        self.collectBtn.hidden = YES;
//    }else if ([self.type isEqualToString:@"2"]) {
//        self.collectBtn.hidden = NO;
//    }
    

    //创建一个分组样式的UITableView
    _tableView=[[BaseTableView alloc]initWithFrame:CGRectMake(0, 155, SCREEN_WIDTH, SCREEN_HEIGHT-200) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    _tableView.rowHeight = 120;
    [_tableView headerBeginRefreshing];
    [_tableView footerBeginRefreshing];
    [_tableView addFooterWithTarget:self action:@selector(requestFooterNetWorking)];
    [_tableView addHeaderWithTarget:self action:@selector( requestSearchProductPaginationResult)];

    [self.view addSubview:_tableView];
    // 创建筛选的页面
    ScreeningView * saiXuanView = [[ScreeningView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.saiXuanView = saiXuanView;
    self.saiXuanView.hidden = YES;
    [saiXuanView enterType:self.enterType];

    
    
}
#pragma mark - footer 的网络数据加载
-(void)requestFooterNetWorking
{
    self.pageNum = self.pageNum +1;
    [self requestSearchProductPaginationResult];
    
}

#pragma mark - 创建 工具栏
- (void)initToolbarView{
    VJDWeakSelf;
    VJDToolbarView * toolbar = [[VJDToolbarView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height*0.16, self.view.frame.size.width, 60)];
    toolbar.isChangeStatus = YES;
    toolbar.itemsList = @[@{@"text":@"默认"},
                          @{@"text":@"价格",@"icon":@"orderbyno"},
                          @{@"text":@"销量"},
                          @{@"text":@"筛选",@"icon":@"shuaixuan"}
                          ];
    [self.view addSubview:toolbar];
    toolbar.toolbarViewBlock = ^(NSInteger clickInxex,NSInteger orderby){
        if (clickInxex == 0) {
            self.sort = @"";
            [_tableView headerBeginRefreshing];
            
        }else if (clickInxex == 1){
            ELog(@"升序");
            self.sort = @"price";
            if (toolbar.orderByType ==OrderBy_Up) {//升序
//                self.sort = @"minProductPrice";
                self.sortDirection =@"asc";
                self.pageNum = 1;
              //  [self requestSearchProductPaginationResult];
                [_tableView headerBeginRefreshing];
            }if ((toolbar.orderByType==OrderBy_Down)) {//降序
//                self.sort =@"minProductPrice";
                self.sortDirection =@"desc";
                self.pageNum = 1;
               // [self requestSearchProductPaginationResult];
               [_tableView headerBeginRefreshing];
            }else{// 默认
               // self.sort = @"";
               // [self requestSearchProductPaginationResult];
               // self.pageNum = 1;
               //[_tableView headerBeginRefreshing];

            }
           // [self requestSearchProductPaginationResult];
           // self.pageNum = 1;
        }else if (clickInxex == 2){
            self.sort = @"salesVolume";//销量排序
            self.sortDirection = @"";
            [_tableView headerBeginRefreshing];
        }else if (clickInxex == 3){
            self.saiXuanView.hidden = NO;
           // self.saiXuanView.enterType = ScreeningViewEnterType3;
            self.saiXuanView.enterType = self.enterType;
            self.saiXuanView.categoryId = [self.saiXuanCategory integerValue];
            self.saiXuanView.fromFactoryFlage = YES;
            self.saiXuanView.type = self.type;
            self.saiXuanView.brandName = self.brandsList[0];
            [self.view.window addSubview:self.saiXuanView];

            [UIView animateWithDuration:0.3 animations:^{
                self.saiXuanView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
            self.saiXuanView.categoryNameBlock =^(NSString * categoryNameStr){
                if ([categoryNameStr isEqualToString:@"选择"]||!self.brandNameStr) {
                    _categoryNameStr=@"";
                }else{
                _categoryNameStr = categoryNameStr;
                }
                [weakSelf requestSearchProductPaginationResult];

            };
            self.saiXuanView.screeningBlcok = ^(NSMutableArray * brandsList,NSMutableArray * properyList,NSString * lowPrice,NSString * highPrice){
                NSString * idStr = nil;
                    for (BrandsModel * idModel in brandsList) {
                        if (idStr) {
                            idStr = [NSString stringWithFormat:@"%@&brandNames=%@",idStr,idModel.brandName];
                        }else{
                            idStr = [NSString stringWithFormat:@"%@", idModel.brandName];
                        }
                }
                
                
                NSString * skuId =nil;
                for (PropertyModel* idModel in properyList) {
                    if (skuId) {
                        skuId = [NSString stringWithFormat:@"%@&optionIds=%@",idModel.properyId,skuId];
                    }else{
                        skuId =idModel.properyId;
                    }
                }
                self.properyId = skuId;
                self.brandNameStr = idStr;
                self.minPrice = lowPrice;
                self.maxPrice = highPrice;
                self.pageNum = 1;
               // weakSelf.brandsList = nameArray;
                self.pageNum = 1;
            };
        }
    };
}

-(void)detailsBtn
{
    if (self.isXiaLa) {
        ELog(@"品牌详情");
    }else{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGPoint point = self.pinpai.center;
    point.y +=SCREEN_HEIGHT-50;
    [self.pinpai setCenter:point];
    [UIView commitAnimations];
        self.isXiaLa = YES;
    }
}

-(void)shouQiBtnTouch
{
    if (self.isXiaLa) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGPoint point = self.pinpai.center;
        point.y -=SCREEN_HEIGHT-50;
        [self.pinpai setCenter:point];
        [UIView commitAnimations];
        self.isXiaLa = NO;
    }
    
}

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

#pragma mark返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"Cell";
    CommodityTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[NSBundle mainBundle] loadNibNamed:@"CommodityTableViewCell" owner:self options:nil][0];
    }
    FactoryModel * factoryModel = dataArray[indexPath.row];
    cell.commodityName.text = factoryModel.name;
    [cell.commodityImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestApiPictureURL_Test,factoryModel.pictureUrl]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.commodityPrice.text = [NSString stringWithFormat:@"%.2f",factoryModel.minPrice];
    if (factoryModel.count == 0) {
        factoryModel.count = (arc4random() % 10000);
    }
    
    cell.payNumLable.text = [NSString stringWithFormat:@"%ld",(long)factoryModel.count];
    return cell;
}

#pragma mark - UITableViewDelegate代理方法

#pragma mark 每行点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailsViewController * detaile = [[DetailsViewController alloc]init];
    FactoryModel * factoryModel = dataArray[indexPath.row];
    detaile.type = @"1";
    detaile.name =factoryModel.name;
    detaile.iD = factoryModel.Id;
    [self.navigationController pushViewController:detaile animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    aview.backgroundColor = [UIColor whiteColor];
    return aview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma 创建品牌详情view
-(void)creatPinPaiDetail
{
    PinPaiDetailView *pinpai = [[[NSBundle mainBundle]loadNibNamed:@"PinPaiDetailView" owner:nil options:nil] lastObject];
    self.pinpai = pinpai;
    pinpai.titleLable.text =self.brandDetailModel.name;
    [pinpai.touXiangImage sd_setImageWithURL:[NSURL URLWithString:self.brandDetailModel.imageUrl] placeholderImage:nil];
    pinpai.contentLable.text =[NSString stringWithFormat:@"主营：%@",self.brandDetailModel.manage];
    pinpai.pinpaiJieshaoLable.text = [NSString stringWithFormat:@"品牌介绍：%@",self.brandDetailModel.kdescription];
    [self.view addSubview:pinpai];
    [pinpai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(-SCREEN_HEIGHT);
        make.bottom.mas_equalTo(self.view.mas_top);
    }];
    [pinpai.shouQiBtn addTarget:self action:@selector(shouQiBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    pinpai.shouQiBtn.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 收藏
- (void)collectBtn:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"收藏"]) {
        [self collectWithBtn:btn];
    }else if ([btn.titleLabel.text isEqualToString:@"取消收藏"]) {
        [self cancelCollectionWithBtn:btn];
    }
}

//收藏商品
- (void)collectWithBtn:(UIButton *)btn {//TODO
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  @"name" : _brandsModel.name ? _brandsModel.name : @"",
                                  @"manufacturerId" : self.manufacturerId ? self.manufacturerId : @""
                                  };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:CollectionManufacturerURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        [btn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [self.collectBtn setImage:[UIImage imageNamed:@"取消收藏图标"] forState:UIControlStateNormal];
        [self.collectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
        [VJDProgressHUD showSuccessHUD:@"收藏成功"];
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

//取消收藏商品
- (void)cancelCollectionWithBtn:(UIButton *)btn {
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  @"manufacturerId":self.manufacturerId ? self.manufacturerId : @""
                                  };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:CancelCollectionManufacturerURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        [btn setTitle:@"收藏" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"收藏图标"] forState:UIControlStateNormal];
        [self.collectBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
        [VJDProgressHUD showSuccessHUD:@"取消成功"];
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - getter
-(UIButton *)collectBtn {
    if (!_collectBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.backgroundColor = V_LIGHTGRAY_COLOR;
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 2;
        button.hidden = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:V_ORANGE_COLOR forState:UIControlStateNormal];
//        [button setTitle:@"收藏" forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"收藏图标"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(collectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
        _collectBtn = button;
    }
    return _collectBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
