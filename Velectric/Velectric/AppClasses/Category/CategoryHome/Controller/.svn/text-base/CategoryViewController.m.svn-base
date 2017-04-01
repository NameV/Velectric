//
//  CategoryViewController.m
//  Velectric
//
//  Created by QQ on 2016/11/26.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryMeunModel.h"
#import "CommodityModel.h"
#import "MultilevelMenu.h"
#import "CommodityTableViewController.h"
#import "RightMenuTableViewController.h"
#import "FactoryViewController.h"
#import "HSearchView.h"
#import "SearchViewController.h"
#import "VBannerModel.h"
#import "VBaseWebVC.h"

@interface CategoryViewController ()<UITextFieldDelegate,MultilevelMenuDelegate>
{
    
    NSMutableArray * _list;
    NSMutableArray * firStArray;
    NSMutableArray * TwoStArray;
    NSMutableArray * threeStArray;
    MultilevelMenu * multileView;
    int index;
    
}
@property (nonatomic, strong)UITextField * searchField;
@property (nonatomic, strong)HSearchView * SV;
@property (nonatomic, strong) UIBarButtonItem * rightBotton;
@property (nonatomic, strong)UIView * searchBar;
@property (nonatomic, assign)int categoryId;
@property (nonatomic, strong)MultilevelMenu * multileView;

//二期
@property (nonatomic, strong) VBannerModel *bannerModel;//banner图片model


@end

@implementation CategoryViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"分类"];
    //请求分类数据
    if (firStArray.count==0) {
        [self initDataCategoryId:@"1"];
    }
    //请求banner图片
    [self requestBannerImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化数据
//    [self initData];
    //初始化分类菜单
    [self initCategoryMenu];
    //设置导航栏
    [self setupNavigationItem];
  //  [self initDataCategoryId:@"1"];
    //初始化数组
    threeStArray = [NSMutableArray array];
    index = 0;
}

- (void)setupNavigationItem {
    
    UIView * searchBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.searchBar = searchBar;
    UIImageView * searchImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    searchImage.frame = CGRectMake(0, 0, 20, 20);
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 5;
    UITextField * searchField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-30, 30)];
    self.navigationItem.leftBarButtonItem = self.rightBotton;
    
    [searchBar addSubview:searchField];
    searchField.leftView = searchImage;
    searchField.leftViewMode=UITextFieldViewModeAlways;
    searchField.delegate = self;
    [searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.searchField = searchField;
    searchField.placeholder = @"搜索V机电商品";
    self.navigationItem.titleView =searchBar;

    
     HSearchView* SV = [[HSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    SV.nav = self.navigationController;
    self.SV = SV;
    self.SV.hidden = YES;
    self.SV.isSearch =YES;
    [self.view addSubview:self.SV];

    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH-40, 50, 30)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    
    UIBarButtonItem * rightBotton = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.rightBotton = rightBotton;
    [rightBtn addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rightBotton;
    self.navigationItem.rightBarButtonItem = nil;

}

#pragma mark - https

//获取banner图片
- (void)requestBannerImage {
    
    NSDictionary *paramDic = @{
                               @"memberId" : GET_USER_INFO.memberId
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:BannerQueryURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               self.bannerModel = [VBannerModel yy_modelWithDictionary:responseObject[@"bannerPO"]];
                                               NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",V_Base_ImageURL,self.bannerModel.picUrl ];
                                               self.multileView.headview.imageView.image = nil;
                                               [self.multileView.headview.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"categoryPic"]];
                                               self.multileView.picUrl = imageUrl;
                                               
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//点击图片跳转
- (void)bannerJumpAction {
    
    if ([self.bannerModel.jumpPictureUrl isEmpty] || !self.bannerModel.jumpPictureUrl || [self.bannerModel.jumpPictureUrl isEqualToString:@""]) {
        NSLog(@"不跳转");
    }else{
        VBaseWebVC *webVC = [[VBaseWebVC alloc]initWithUrlString:self.bannerModel.jumpPictureUrl];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
}

//一级分类
- (void)initDataCategoryId:(NSString *)categoryId{
    firStArray = [NSMutableArray array];
//    [VJDProgressHUD showProgressHUD:nil];
    NSDictionary * parameters = @{@"categoryId":categoryId
                                  };
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:GetGetTreeURL parameters:parameters success:^(NSDictionary *respronseObject) {
        ELog(@"成功");
  //      firStArray = respronseObject[@"result"][@"children"];
        NSDictionary * result =respronseObject[@"result"];
        if ([result isKindOfClass:[NSNull class]]) {
            [VJDProgressHUD showTextHUD:INTERNET_ERROR];
            return ;
        }
        NSMutableArray * arr=result[@"children"];
        if (arr.count==0) {
            [VJDProgressHUD showTextHUD:INTERNET_ERROR];
            return ;
        }
        firStArray = arr;
        [self categoryTwoNetworkingCategoryId:firStArray[0][@"id"]];
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
    
  }
//二级分类

-(void)categoryTwoNetworkingCategoryId:(NSString *)categoryId
{
    [VJDProgressHUD showProgressHUD:nil];
    NSDictionary * parameters = @{@"categoryId":categoryId};
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:GetGetTreeURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        TwoStArray =responseObject[@"result"][@"children"];
        [self categoryThreeNetworkingCategoryId:TwoStArray[0][@"id"]];

    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

//三级分类

-(void)categoryThreeNetworkingCategoryId:(NSString *)categoryId
{
    if (index==0) {
        [threeStArray removeAllObjects];
    }
    index++;
    
    NSDictionary * parameters = @{@"categoryId":categoryId};
    [SYNetworkingManager GetOrPostNoBodyWithHttpType:1 WithURLString:GetGetTreeURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        NSArray * threeDataArr = [NSArray array];
        threeDataArr = responseObject[@"result"][@"children"];
        [threeStArray addObject:threeDataArr];
        if (index<TwoStArray.count) {
            [self categoryThreeNetworkingCategoryId:TwoStArray[index][@"id"]];

        }else{
            [self relodetableView];
            [VJDProgressHUD dismissHUD];
        }

    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

-(void)relodetableView
{
//    MultilevelMenu * view = [[MultilevelMenu alloc]init];
    [self.multileView reloadDataFirstData:firStArray TwoData:TwoStArray ThreeData:threeStArray];
}

- (void)initCategoryMenu{
    
    MultilevelMenu * view = [[MultilevelMenu alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) FirstData:firStArray TwoData:TwoStArray  ThreeData:threeStArray withSelectIndex:^(NSInteger left, NSInteger right, NSString* categoryName) {
        
        CommodityTableViewController * tableView = [[CommodityTableViewController alloc]init];
        NSArray * arr = [NSArray arrayWithObject:[NSString stringWithFormat:@"%ld",right]];
        tableView.enterType = ScreeningViewEnterType10;
        tableView.categoryIds =arr;
        tableView.saiXuanCategoryId =[arr[0] integerValue];
       // tableView.categoryName=categoryName;
        [self.navigationController pushViewController:tableView animated:YES];
    }];
    
    //  MultilevelMenu * view=[[MultilevelMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) WithData:_list withSelectIndex:^(NSInteger left, NSInteger right,CategoryMeunModel * info) {
    //   }];
    self.multileView = view;
    view.delegate = self;
    view.leftSelectColor=RGBColor(243, 121, 120);//选中文字颜色
    view.leftSelectBgColor=[UIColor whiteColor];//选中背景颜色
    view.isRecordLastScroll=NO;//是否记住当前位置
    [self.view addSubview:view];
    [self.view addSubview:self.SV];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bannerJumpAction) name:BannerJumpNotification object:nil];

}



#pragma 的代理方法
-(void)BtnPush:(NSDictionary*)dic
{
    CommodityTableViewController * commodity = [[CommodityTableViewController alloc]init];
    commodity.categoryName = dic[@"name"];
    commodity.categoryIds = @[dic[@"id"]];
    commodity.enterType =ScreeningViewEnterType9;
    commodity.saiXuanCategoryId =[dic[@"id"] integerValue];
    [self.navigationController pushViewController:commodity animated:YES];
}

#pragma mark 刷新collectView

-(void)passTrendValues:(NSString *)values{
    [self categoryTwoNetworkingCategoryId:values];
    index = 0;
}

//取消的btn
-(void)cancleBtn
{
    self.SV.hidden = YES;
    [self.navigationController.navigationBar endEditing:YES];
}

#pragma uitextField 的代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   // self.SV.hidden = NO;
    //return YES;
    SearchViewController * search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}

- (void)textFieldDidChange:(id)sender
{
    UITextField * field = (UITextField *)sender;
    [self.SV reloadTableviewFieldText:field.text];
/*
    if (field.text.length) {
        self.SV.hidden =NO;
        self.SV.isSearch =YES;// no  为二期开发
    }else{
        self.SV.isSearch =YES;
        [self.SV reloadTableviewFieldText:field];
        
    }
 */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter ]removeObserver:self name:BannerJumpNotification object:nil];
}

#pragma mark - getter


@end
