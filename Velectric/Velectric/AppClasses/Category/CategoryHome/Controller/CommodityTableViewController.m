//
//  CommodityTableViewController.m
//  Velectric
//
//  Created by QQ on 2016/11/29.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "CommodityTableViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "CommodityModel.h"
#import "CommodityTableViewCell.h"
#import "DetailsViewController.h"
#import "HSearchView.h"
#import "ScreenView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SearchViewController.h"
#import "MJRefresh.h"
#import "SkuPropertyModel.h"
#import "HomeCategoryModel.h"

#import "VJDToolbarView.h"          //工具栏
#import "ScreeningView.h"           //筛选view

@interface CommodityTableViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ScreenViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_commodity;
    NSMutableArray * dataArray; // tableView 的数据源
}
@property (nonatomic, strong)UITextField * searchField;
@property (nonatomic, strong)HSearchView * SV;
@property (nonatomic, strong) UIBarButtonItem * rightBotton;
@property (nonatomic, strong)UIView * searchBar;
@property (nonatomic, strong)ScreenView * listView;
@property (nonatomic, strong)UIView * bgView;
@property (nonatomic, assign)NSInteger pageNum;//分页页数
@property (nonatomic, strong)ScreeningView * saiXuanView;//筛选的VIew
@property (nonatomic, strong)VJDToolbarView * toolbar;//销量  价格


/* 搜索无结果时的提示文字 */
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation CommodityTableViewController {
    NSInteger _totalPage;//总页数
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //请求的页码
    self.pageNum = 1;
    //初始化数据
  //  [self initDataPageNum:1];
    //初始化视图
    [self initView];
    //设置导航栏
    [self setupNavigationItem];
    //初始化数组
    self.optionIds = [NSArray array];
    [_tableView headerBeginRefreshing];
    //创建筛选的View
    ScreeningView * saiXuanView = [[ScreeningView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.saiXuanView = saiXuanView;
    self.saiXuanView.enterType = self.enterType;
    self.saiXuanView.categoryId = self.saiXuanCategoryId;
    [saiXuanView enterType:self.enterType];

}
- (void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"商品列表"];
}

- (void)initView{
    VJDToolbarView * toolbar = [[VJDToolbarView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 40)];
    self.toolbar = toolbar;
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
         //   [self initDataPageNum:1];
            [_tableView headerBeginRefreshing];
        }else if (clickInxex == 1){
            self.sort = @"price";
            if (toolbar.orderByType ==OrderBy_Up) {//升序
                self.sortDirection =@"asc";
               // [self initDataPageNum:1];
                [_tableView headerBeginRefreshing];
            }if ((toolbar.orderByType==OrderBy_Down)) {//降序
                self.sortDirection =@"desc";
              //  [self initDataPageNum:1];
                [_tableView headerBeginRefreshing];
            }
        }else if (clickInxex == 2){
            self.sort = @"salesVolume";//销量排序
            [_tableView headerBeginRefreshing];

        }else if (clickInxex == 3){
            
            [self.view.window addSubview:self.saiXuanView];
            [UIView animateWithDuration:0.3 animations:^{
                self.saiXuanView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
            VJDWeakSelf;
            self.saiXuanView.screeningBlcok =^(NSMutableArray * brandsList,NSMutableArray * properyList,NSString * lowPrice,NSString * highPrice,HomeCategoryModel *selectModel){
                weakSelf.categoryIds = @[[NSNumber numberWithInteger:selectModel.myId]];
                NSString * idStr =nil;
        
                for (BrandsModel * idModel in brandsList) {
                    if (idStr) {
                        idStr = [NSString stringWithFormat:@"%@&brandId=%@",idStr,idModel.brandId];
                    }else{
                        idStr = [NSString stringWithFormat:@"%@", idModel.brandId];
                    }
                }
                
                NSString * skuId =nil;
                NSString *skuName = nil;
                for ( PropertyModel* idModel in properyList) {
                    if (skuId) {
                        skuId = [NSString stringWithFormat:@"%@&optionIds=%@",idModel.properyId,skuId];
                    }else{
                        skuId =idModel.properyId;
                    }
                    
                    if (skuName) {
                        skuName = [NSString stringWithFormat:@"%@&optionNames=%@",idModel.propertyValue,skuName];
                    }else{
                        skuName =idModel.propertyValue;
                    }
                }
                if ([skuName isEmptyString] || !skuName) {
                    skuName = @"";
                }
                weakSelf.properyId = skuId;
                weakSelf.properyNameStr = skuName;
                weakSelf.brandNameStr = idStr;
                weakSelf.minPrice = lowPrice;
                weakSelf.maxPrice = highPrice;
                [weakSelf initDataPageNum:1];
            };
        }
    };
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-65) style:UITableViewStylePlain];
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    _tableView.separatorColor = [UIColor clearColor];
  //  _tableView.rowHeight = 120;
    [_tableView headerBeginRefreshing];
    [_tableView footerBeginRefreshing];
    [_tableView addFooterWithTarget:self action:@selector(footerLoading)];
    [_tableView addHeaderWithTarget:self action:@selector(initDataPageNum:)];
    
    _tableView.backgroundColor=RGBColor(240, 243, 245);
    [self.view addSubview:_tableView];
}

- (void)setupNavigationItem {
    
    UIView * searchBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 30)];
    self.searchBar = searchBar;
    UIImageView * searchImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    searchImage.frame = CGRectMake(0, 0, 20, 20);
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 5;
    UITextField * searchField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-60, 30)];
    self.navigationItem.leftBarButtonItem = self.rightBotton;
    [searchBar addSubview:searchField];
    searchField.leftView = searchImage;
    searchField.leftViewMode=UITextFieldViewModeAlways;
    searchField.delegate = self;
    [searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.searchField = searchField;
    searchField.placeholder = @"快速查找商品";
    self.navigationItem.titleView =searchBar;
    
    HSearchView * SV = [[HSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.SV = SV;
    [self.view addSubview:SV];
    [self.view bringSubviewToFront:SV];
    self.SV.hidden = YES;
}

#pragma uitextField 的代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    SearchViewController * search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}

-(void)footerLoading
{
    //当前页等于总页数， 结束刷新
    if (self.pageNum == _totalPage) {
        [VJDProgressHUD showTextHUD:@"没有更多了"];
        return;
    }
    
    self.pageNum = self.pageNum +1;
    [self initDataPageNum:self.pageNum];
}

#pragma mark 加载数据
-(void)initDataPageNum:(NSInteger )pageNum{
    
    if (!self.goodsName) {
        self.goodsName = @"";
    }
    if (!self.brandId) {
        self.brandId = @"";
    }if (!self.manufacturerName) {
        self.manufacturerName = @"";
    }if (!self.categoryName) {
        self.categoryName = @"";
    }if (!self.sort) {
        self.sort = @"";
    }if (!self.sortDirection) {
        self.sortDirection = @"";
    }if (!self.manufacturerId) {
        self.manufacturerId = @"";
    }if (!self.brandNames) {
        self.brandNames = @[@""];
    }if (!self.keyWords) {
        self.keyWords = @"";
    }
    
    NSString * categoryStr = nil;
    for (NSString * str  in self.categoryIds) {
        if (categoryStr) {
            categoryStr = [NSString stringWithFormat:@"%@&&%@",categoryStr,str];
        }else{
            categoryStr = str;
        }
    }
    if (!self.categoryIdList) {
        self.categoryIdList =@"";
    }
    if (!categoryStr) {
        categoryStr = @"";
    }
    if (!self.minPrice) {
        self.minPrice = @"";
    }
    if (!self.maxPrice) {
        self.maxPrice = @"";
    }
    if (!self.brandIds) {
        self.brandIds=@"";
    }
    if (!self.properyId) {
        self.properyId=@"";
    }
    
    if (!self.properyNameStr) {
        self.properyNameStr = @"";
    }
        
    if (_enterType==ScreeningViewEnterType2) {//热卖商品进入时的网络请求
        [self netWorkEnterType2];
        return;
    }

    NSString * requestUrl = nil;
    if ([@"1" isEqualToString:_fromType]) {//热卖商品--查看更多
        if (self.categoryIds.count > 0) {
            categoryStr = [self.categoryIds firstObject];
        }else{
            categoryStr = self.categoryIdList;
        }
        if (self.brandNameStr) {
            requestUrl= [NSString stringWithFormat:@"%@?categoryIds=%@&pageNum=%ld&pageSize=20&keyWords=%@&minPrice=%@&maxPrice=%@&optionIds=%@&brandId=%@&sort=%@&sortDirection=%@&optionNames=%@",GetSearchProductPaginationResultURL,categoryStr,(long)self.pageNum
                         ,self.keyWords,self.minPrice,self.maxPrice,self.properyId,self.brandNameStr,self.sort,self.sortDirection,self.properyNameStr];
            
        }else{
            requestUrl= [NSString stringWithFormat:@"%@?categoryIds=%@&pageNum=%ld&pageSize=20&keyWords=%@&minPrice=%@&maxPrice=%@&sort=%@&sortDirection=%@&optionIds=%@&optionNames=%@",GetSearchProductPaginationResultURL,categoryStr,(long)self.pageNum
                         ,self.keyWords,self.minPrice,self.maxPrice,self.sort,self.sortDirection,self.properyId,self.properyNameStr];
        }
        requestUrl = [NSString stringWithFormat:@"%@&subsiteId=1",requestUrl];
        requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
            
            //总分页数
            NSString *totalPageString = responseObject[@"totalPage"];
            _totalPage = [totalPageString integerValue];
            
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
                    [_tableView.mj_footer endRefreshingWithNoMoreData];
                }
                dataArray = mutableArr;
            }
            
            //********无数据提醒***********
            if (dataArray.count > 0) {
                [self.messageLabel removeFromSuperview];
            }else{
                NSString * str = @"抱歉，没有找到相关数据";
                [self.view addSubview:self.messageLabel];
                [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.top.equalTo(self.view.mas_top).offset(40);
                    make.height.mas_equalTo(50);
                }];
                self.messageLabel.text = str;
            }
            //***************************
            
            [_tableView headerEndRefreshing];
            [_tableView footerEndRefreshing];
            [VJDProgressHUD dismissHUD];
            [_tableView reloadData];
        } failure:^(NSError *error) {
           // [VJDProgressHUD showTextHUD:@"数据请求错误，请稍后重试"];
            [_tableView headerEndRefreshing];
            [_tableView footerEndRefreshing];
        }];
        return;
    }else if ([@"2" isEqualToString:_fromType]) {//搜索过来的
        categoryStr = self.categoryIdList;
        
        if (self.brandNameStr) {
            requestUrl= [NSString stringWithFormat:@"%@?pageNum=1&pageSize=20&keyWords=%@&optionIds=%@&brandId=%@&minPrice=%@&maxPrice=%@&sort=%@&sortDirection=%@&optionNames=%@",GetSearchProductPaginationResultURL,self.keyWords,self.properyId,self.brandNameStr,self.minPrice,self.maxPrice,self.sort,self.sortDirection,self.properyNameStr];

        }else{
            requestUrl= [NSString stringWithFormat:@"%@?pageNum=1&pageSize=20&keyWords=%@&minPrice=%@&maxPrice=%@&sort=%@&sortDirection=%@&optionIds=%@&optionNames=%@",GetSearchProductPaginationResultURL,self.keyWords,self.minPrice, self.maxPrice,self.sort,self.sortDirection,self.properyId,self.properyNameStr];

        }
        requestUrl = [NSString stringWithFormat:@"%@&subsiteId=1",requestUrl];
        requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
            
            //总分页数
            NSString *totalPageString = responseObject[@"totalPage"];
            _totalPage = [totalPageString integerValue];
            
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
                    [_tableView.mj_footer endRefreshingWithNoMoreData];
                }
                dataArray = mutableArr;
            }
            
            //********无数据提醒***********
            if (dataArray.count > 0) {
                [self.messageLabel removeFromSuperview];
            }else{
                NSString * str = @"抱歉，没有找到相关数据";
                [self.view addSubview:self.messageLabel];
                [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.top.equalTo(self.view.mas_top).offset(40);
                    make.height.mas_equalTo(50);
                }];
                self.messageLabel.text = str;
            }
            //***************************
            
            [_tableView headerEndRefreshing];
            [_tableView footerEndRefreshing];
            [VJDProgressHUD dismissHUD];
            if (dataArray.count > 0) {
                [_tableView reloadData];
            }else{
                [self searchRecommendedRequest];//搜索无结果列表推荐
            }
            
        } failure:^(NSError *error) {
            [VJDProgressHUD showTextHUD:@"数据请求错误，请稍后重试"];
            [_tableView headerEndRefreshing];
            [_tableView footerEndRefreshing];
            
        }];
        return;
    }else if ([@"3" isEqualToString:_fromType]) {//首页--五金--筛选过来的接口
     //   [VJDProgressHUD showProgressHUD:@"加载中..."];
        categoryStr = self.categoryIdList;
        if (self.brandNameStr) {
            requestUrl= [NSString stringWithFormat:@"%@?pageNum=%ld&pageSize=20&categoryIds=%@&sort=%@&sortDirection=%@&minPrice=%@&maxPrice=%@&optionIds=%@&brandId=%@&optionNames=%@",GetSearchProductPaginationResultURL,self.pageNum,self.categoryIds[0],self.sort,self.sortDirection,self.minPrice,self.maxPrice,self.properyId,self.brandNameStr,self.properyNameStr];
        }else{
            requestUrl= [NSString stringWithFormat:@"%@?pageNum=%ld&pageSize=20&categoryIds=%@&sort=%@&sortDirection=%@&minPrice=%@&maxPrice=%@&optionIds=%@&optionNames=%@",GetSearchProductPaginationResultURL,self.pageNum,self.categoryIds[0],self.sort,self.sortDirection,self.minPrice,self.maxPrice,self.properyId,self.properyNameStr];
            
        }
        requestUrl = [NSString stringWithFormat:@"%@&subsiteId=1",requestUrl];
        requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
            
            //总分页数
            NSString *totalPageString = responseObject[@"totalPage"];
            _totalPage = [totalPageString integerValue];
            
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
                    [_tableView.mj_footer endRefreshingWithNoMoreData];
                }
                dataArray = mutableArr;
            }
            
            //********无数据提醒***********
            if (dataArray.count > 0) {
                [self.messageLabel removeFromSuperview];
            }else{
                NSString * str = @"抱歉，没有找到相关数据";
                [self.view addSubview:self.messageLabel];
                [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.view);
                    make.top.equalTo(self.view.mas_top).offset(40);
                    make.height.mas_equalTo(50);
                }];
                self.messageLabel.text = str;
            }
            //***************************

            [_tableView headerEndRefreshing];
            [_tableView footerEndRefreshing];
            [VJDProgressHUD dismissHUD];
            [_tableView reloadData];
        } failure:^(NSError *error) {
            [VJDProgressHUD showTextHUD:@"数据请求错误，请稍后重试"];
            [_tableView headerEndRefreshing];
            [_tableView footerEndRefreshing];
            
        }];
        return;
    }else{//分类 筛选
        requestUrl =GetSearchProductPaginationResultURL;
    }

    
    if (self.brandNameStr) {
        requestUrl= [NSString stringWithFormat:@"%@?categoryIds=%@&pageNum=%ld&pageSize=20&keyWords=%@&minPrice=%@&maxPrice=%@&optionIds=%@&brandId=%@&sort=%@&sortDirection=%@&optionNames=%@",GetSearchProductPaginationResultURL,categoryStr,(long)self.pageNum
                     ,self.keyWords,self.minPrice,self.maxPrice,self.properyId,self.brandNameStr,self.sort,self.sortDirection,self.properyNameStr];
    }else{
        requestUrl= [NSString stringWithFormat:@"%@?categoryIds=%@&pageNum=%ld&pageSize=20&keyWords=%@&minPrice=%@&maxPrice=%@&optionIds=%@&sort=%@&sortDirection=%@&optionNames=%@",GetSearchProductPaginationResultURL,categoryStr,(long)self.pageNum
                     ,self.keyWords,self.minPrice,self.maxPrice,self.properyId,self.sort,self.sortDirection,self.properyNameStr];
    }
    requestUrl = [NSString stringWithFormat:@"%@&subsiteId=1",requestUrl];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:2 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
        
        //总分页数
        NSString *totalPageString = responseObject[@"totalPage"];
        _totalPage = [totalPageString integerValue];
        
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
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
            dataArray = mutableArr;
        }
        
        //********无数据提醒***********
        if (dataArray.count > 0) {
            [self.messageLabel removeFromSuperview];
        }else{
            NSString * str = @"抱歉，没有找到相关数据";
            [self.view addSubview:self.messageLabel];
            [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view.mas_top).offset(40);
                make.height.mas_equalTo(50);
            }];
            self.messageLabel.text = str;
        }
        //***************************
        
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [VJDProgressHUD dismissHUD];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    }];
    
}

//搜索无结果推荐列表 请求
- (void)searchRecommendedRequest {
    
    NSString *urlString = @"";
    urlString = [NSString stringWithFormat:@"%@?keyWords=%@&subsiteId=1",SearchRecommendedUrl,_keyWords];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [SYNetworkingManager GetOrPostWithHttpType:1
                                 WithURLString:urlString
                                    parameters:nil
                                       success:^(NSDictionary *responseObject) {
                                           
                                           dataArray = [responseObject[@"result"] mutableCopy];
                                           self.noResult = YES;
                                           
                                           NSString *str;
                                           NSMutableAttributedString *mutStr ;
                                           if (dataArray.count > 0) {
                                               str = [NSString stringWithFormat:@"抱歉，没有找到“%@”的搜索结果，为您推荐以下结果",_keyWords];
                                               mutStr =[[NSMutableAttributedString alloc]initWithString:str];
                                               
                                               [self.view addSubview:self.messageLabel];
                                               [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                                                   make.left.right.top.equalTo(self.view);
                                                   make.height.mas_equalTo(50);
                                               }];
                                               [mutStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:_keyWords]];
                                               self.messageLabel.attributedText = mutStr;
                                               
                                               //toorbar 重置frame
                                               [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
                                                   make.left.right.equalTo(self.view);
                                                   make.top.equalTo(self.messageLabel.mas_bottom);
                                                   make.height.mas_equalTo(40);
                                               }];
                                               
                                               [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                                                   make.left.right.bottom.equalTo(self.view);
                                                   make.top.equalTo(self.toolbar.mas_bottom);
                                               }];

                                           }else{
                                               str = [NSString stringWithFormat:@"抱歉，没有找到“%@”的搜索结果",_keyWords];
                                               mutStr =[[NSMutableAttributedString alloc]initWithString:str];
                                               
                                               [self.toolbar removeFromSuperview];
                                               self.toolbar.frame = CGRectZero;
                                               
                                               [self.view addSubview:self.messageLabel];
                                               [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                                                   make.left.right.top.equalTo(self.view);
                                                   make.height.mas_equalTo(50);
                                               }];
                                               [mutStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:_keyWords]];
                                               self.messageLabel.attributedText = mutStr;
                                           }
                                           
                                           
                                           [_tableView reloadData];
                                           
                                           
                                       } failure:^(NSError *error) {
                                           
                                       }];
}


#pragma mark 热卖商品进来的网络请求
-(void)netWorkEnterType2
{
    
    if (!self.properyNameStr) {
        self.properyNameStr = @"";
    }
    NSString *categoryStr;
    if (self.categoryIds.count > 0) {
        categoryStr = [NSString stringWithFormat:@"&categoryIds=%@",[self.categoryIds firstObject]];
    }else{
        categoryStr = self.categoryIdList;
    }
    if (!categoryStr) {
        categoryStr = @"";
    }
    NSString * requestUrl = nil;
    if (self.brandNameStr) {
        requestUrl= [NSString stringWithFormat:@"%@?pageNum=%ld&pageSize=20&sort=%@&sortDirection=%@&optionIds=%@&brandId=%@&optionNames=%@",GetSearchProductPaginationResultURL,self.pageNum,self.sort,self.sortDirection,self.properyId,self.brandNameStr,self.properyNameStr];
    }else{
         requestUrl= [NSString stringWithFormat:@"%@?pageNum=%ld&pageSize=20&sort=%@&sortDirection=%@&optionIds=%@&optionNames=%@",GetSearchProductPaginationResultURL,self.pageNum,self.sort,self.sortDirection,self.properyId,self.properyNameStr];
    }
    requestUrl = [NSString stringWithFormat:@"%@%@",requestUrl,categoryStr];
    requestUrl = [NSString stringWithFormat:@"%@&subsiteId=1",requestUrl];
//    requestUrl = [requestUrl stringByAppendingFormat:@"%@",_categoryIdList];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:requestUrl parameters:nil success:^(NSDictionary *responseObject) {
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
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
            dataArray = mutableArr;
        }
        //********无数据提醒***********
        if (dataArray.count > 0) {
            [self.messageLabel removeFromSuperview];
        }else{
            NSString * str = @"抱歉，没有找到相关数据";
            [self.view addSubview:self.messageLabel];
            [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.equalTo(self.view.mas_top).offset(40);
                make.height.mas_equalTo(50);
            }];
            self.messageLabel.text = str;
        }
        //***************************
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [VJDProgressHUD dismissHUD];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:@"数据请求错误，请稍后重试"];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        
    }];
}
#pragma ScreenViewDelegate 的代理方法

-(void)backRootViewController
{
    [self.bgView removeFromSuperview];
}
-(void)sendAndBack
{
    [self.bgView removeFromSuperview];
}
#pragma mark 返回的组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _commodity.count;
    return dataArray.count;
}

#pragma mark返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"Cell";
    CommodityTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[NSBundle mainBundle] loadNibNamed:@"CommodityTableViewCell" owner:self options:nil][0];
    }
    cell.qiLable.hidden = YES;//隐藏“起”
    NSMutableDictionary * dic = [dataArray[indexPath.row] mutableCopy];
//    NSString *string = dic[@"productName_ik"] ;
//    NSMutableAttributedString *arrString = [[NSMutableAttributedString alloc]initWithString:dic[@"productName_ik"]];
//    if (self.noResult == YES) {
//        NSString *keyString = [dic[@"productName"] subStringFrom:@">" to:@"<"];
//        NSRange range = [string rangeOfString:keyString];
//        [arrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
//    }
//    cell.commodityName.attributedText = arrString;
    cell.commodityName.text = dic[@"productName_ik"];
    CGFloat minPrice = [dic[@"price"] floatValue];
    cell.commodityPrice.text = [NSString stringWithFormat:@"￥%.2f",minPrice];
    
    int num = (arc4random() % 10000);
    cell.payNumLable.text = [NSString stringWithFormat:@"月销量：%d个",num];
    NSString * str = [NSString stringWithFormat:@"%@%@",V_Base_ImageURL,dic[@"defaultGoodsPictureUrl"]];
    NSURL* url = [NSURL URLWithString:str];
    [cell.commodityImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
}

#pragma mark - UITableViewDelegate代理方法

#pragma mark 每行点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"cell selected at index path %i", (int)indexPath.row);
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsViewController * detailsTVC = [[DetailsViewController alloc]init];
    NSDictionary * dic = dataArray[indexPath.row];
    detailsTVC.name =dic[@"name"];
    detailsTVC.iD = dic[@"id"];//14593 此ID 用于多个规格型号的调试
    detailsTVC.type = @"2";
    [self.navigationController pushViewController:detailsTVC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)textFieldDidChange:(id)sender
{
    UITextField * field = (UITextField *)sender;
    if (field.text.length) {
        self.SV.hidden =NO;
        self.SV.isSearch =YES;
    //    [self.SV reloadTableview];
    }else{
        self.SV.isSearch = NO;
     //   [self.SV reloadTableview];
    }
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel labelLongWithColor:[UIColor redColor] font:14];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.backgroundColor = [UIColor whiteColor];
    }
    return _messageLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
