//
//  SearchViewController.m
//  Velectric
//
//  Created by QQ on 2016/11/28.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "SearchViewController.h"
#import "MineTopCollectionView.h"
#import "HsearchModel.h"
#import "CommodityTableViewController.h"
#import "FactoryViewController.h"
#import "BrandsModel.h"
#import "HSearchView.h"
#import "DetailsViewController.h"
#import "VSearchView.h"//搜索placeholder页面
#import "VScanRecordVC.h"
#import "VFileMnager.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,MineTopCollectionViewDelegate,UITextFieldDelegate,HSearchViewDelegate,VSearchViewDelegate>

@property (nonatomic, strong)UIView * searchBar;
@property (nonatomic, strong) UIBarButtonItem * rightBotton;
@property (nonatomic, strong)UITextField * searchField;
@property (nonatomic, strong)HSearchView * SV;
@property (nonatomic, strong)VSearchView * placehoderView;//有热搜词的界面
@property (nonatomic, strong)NSMutableArray * datas;//有热搜词的界面的数组

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationItem];
    [self.view addSubview:self.placehoderView];
    [self.view bringSubviewToFront:self.placehoderView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.placehoderView reloadData];//每次进入刷新界面
    [self.navigationItem setHidesBackButton:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{   [super viewWillDisappear:animated];
    [self.navigationItem setHidesBackButton:YES];
}

#pragma mark - https
//点击搜索  搜索的接口
//增加搜索接口
- (void)addSearchRecordWithText:(NSString *)text {
    
    if ([text isEmptyString]) {
        [VJDProgressHUD showTextHUD:@"搜索内容不能为空"];
        return;
    }
    
    HsearchModel *model = [[HsearchModel alloc]init];
    model.searchText = text;
    
    BOOL result = [[VFileMnager sharedInstance] writeHistorySearchToCacheWithModel:model];
    if (result) {
        ELog(@"成功");
    }else{
        ELog(@"失败");
    }
    
    NSDictionary *paramDic = @{
                               @"memberId" : GET_USER_INFO.memberId,
                               @"searchContent" : text
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:SaveSearchRecordURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               [self.searchBar endEditing:YES];
                                               //   [self.SV reloadTableviewFieldText:textField.text];
                                               CommodityTableViewController * commodi = [[CommodityTableViewController alloc]init];
                                               commodi.saiXuanCategoryId =1;
                                               commodi.keyWords = text;
                                               commodi.enterType = ScreeningViewEnterType4;//进入方式
                                               
                                               commodi.fromType = @"2";
                                               [self.navigationController pushViewController:commodi animated:YES];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

#pragma mark HsearchDelegate 的方法
//智能提示  搜索接口 点击
-(void)pushNextViewController:(HsearchModel *)model
{
    
    //缓存
    BOOL result = [[VFileMnager sharedInstance] writeHistorySearchToCacheWithModel:model];
    if (result) {
        ELog(@"成功");
    }else{
        ELog(@"失败");
    }

    
    NSDictionary *paramDic = @{
                               @"memberId" : GET_USER_INFO.memberId,
                               @"searchContent" : self.searchField.text
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:SaveSearchRecordURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               //    [self.SV removeFromSuperview];
                                               [self.searchBar endEditing:YES];
                                               if (![@""isEqualToString:model.categoryId] && model.categoryId) {//分类
                                                   CommodityTableViewController * commitTableiew = [[CommodityTableViewController alloc]init];
                                                   NSString * categoryId = [NSString stringWithFormat:@"%@",model.categoryId];
                                                   commitTableiew.categoryIds = @[categoryId];
                                                   commitTableiew.categoryName = @"";
                                                   switch (model.level) {
                                                       case 2:
                                                           commitTableiew.enterType = ScreeningViewEnterType5;
                                                           commitTableiew.saiXuanCategoryId = [model.categoryId integerValue];
                                                           break;
                                                       case 3:
                                                           commitTableiew.enterType = ScreeningViewEnterType6;
                                                           commitTableiew.saiXuanCategoryId = [model.categoryId integerValue];
                                                           break;
                                                       default:
                                                           break;
                                                   }
                                                   commitTableiew.saiXuanCategoryId = [model.categoryId integerValue];
                                                   [self.navigationController pushViewController:commitTableiew animated:YES];
                                                   
                                                   
                                               }else if (![@""isEqualToString:model.brandName] && model.brandName){//品牌
                                                   
                                                   FactoryViewController * factory = [[FactoryViewController alloc]init];
                                                   factory.enterType =ScreeningViewEnterType3;
                                                   factory.saiXuanCategory = [NSString stringWithFormat:@"%@",model.manufacturerId];
                                                   BrandsModel * brandModel = [[BrandsModel alloc]init];
                                                   brandModel.Id =model.brandId;
                                                   brandModel.name =model.brandName;
                                                   factory.type = @"1";
                                                   factory.brandsModel = brandModel;
                                                   [self.navigationController pushViewController:factory animated:YES];
                                                   
                                               }else if (![@""isEqualToString:model.manufacturerName] && model.manufacturerName){//厂商
                                                   
                                                   FactoryViewController * factory = [[FactoryViewController alloc]init];
                                                   factory.enterType =ScreeningViewEnterType3;
                                                   factory.isFromsearch = YES;
                                                   factory.saiXuanCategory = [NSString stringWithFormat:@"%@",model.manufacturerId];
                                                   BrandsModel * brandModel = [[BrandsModel alloc]init];
                                                   //为了和H5保持一致
                                                   brandModel.Id =model.manufacturerId;
                                                   brandModel.name =model.manufacturerName;
                                                   
                                                   //        brandModel.Id =model.brandId;
                                                   //        brandModel.name =model.brandName;
                                                   factory.type = @"2";
                                                   factory.brandsModel = brandModel;
                                                   [self.navigationController pushViewController:factory animated:YES];
                                                   
                                               }else if (![@""isEqualToString:model.productName] && model.productName){//商品
                                                   
                                                   if (model.count > 1) {
//                                                        CommodityTableViewController * commitTableiew = [[CommodityTableViewController alloc]init];
//                                                        NSString * categoryId = [NSString stringWithFormat:@"%@",model.productId];
//                                                        commitTableiew.categoryIds = @[categoryId];
//                                                        commitTableiew.categoryName = model.productName;
//                                                        [self.navigationController pushViewController:commitTableiew animated:YES];
                                                       CommodityTableViewController * commodi = [[CommodityTableViewController alloc]init];
                                                       commodi.saiXuanCategoryId =1;
                                                       commodi.keyWords = self.searchField.text;
                                                       commodi.enterType = ScreeningViewEnterType4;//进入方式
                                                       
                                                       commodi.fromType = @"2";
                                                       [self.navigationController pushViewController:commodi animated:YES];
                                                       
                                                   }else{
                                                       DetailsViewController *  detail = [[DetailsViewController alloc]init];
                                                       detail.iD = [NSString stringWithFormat:@"%@",model.goodsId];
                                                       detail.name = model.productName;
                                                       [self.navigationController pushViewController:detail animated:YES];
                                                   }
                                                   
                                                   
                                                   
                                                   
                                                   
                                                   /*
                                                    FactoryViewController * factory = [[FactoryViewController alloc]init];
                                                    BrandsModel * brandModel = [[BrandsModel alloc]init];
                                                    brandModel.Id =model.manufacturerId;
                                                    brandModel.name =model.manufacturerName;
                                                    factory.brandsModel = brandModel;
                                                    factory.enterType = ScreeningViewEnterType8;
                                                    factory.saiXuanCategory = [NSString stringWithFormat:@"%@",model.manufacturerId ];
                                                    factory.type = @"2";
                                                    [self.navigationController pushViewController:factory animated:YES];
                                                    */
                                               }
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
    
}


- (void)setupNavigationItem {
    
    UIView * searchBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 30)];
    self.searchBar = searchBar;
    UIImageView * searchImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    searchImage.frame = CGRectMake(0, 0, 20, 20);
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 5;
    UITextField * searchField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-90, 30)];

    searchField.returnKeyType =UIReturnKeySearch;
    searchField.clearButtonMode = UITextFieldViewModeAlways;
    self.searchField = searchField;

    self.navigationItem.leftBarButtonItem = self.rightBotton;
   // searchField.keyboardType = UIKeyboardTypeWebSearch;
    
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
        [self.view addSubview:SV];
        [self.view bringSubviewToFront:SV];
    self.SV.hidden = YES;
    self.SV.isSearch =YES;
    self.SV.delegate = self;
//    [self.view addSubview:self.SV];
//    self.view = self.SV;
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, -20, 40, 30)];
//    [rightBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem * rightBotton = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.rightBotton = rightBotton;
    [rightBtn addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBotton;
    
    
    
}
#pragma mark     收起键盘 发起搜索
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addSearchRecordWithText:textField.text];//增加搜索记录
    
   
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if ([textField.text isEqualToString:@""] || !textField.text) {
//        [self.view addSubview:self.placehoderView];
//        [self.view bringSubviewToFront:self.placehoderView];
//    }else{
//        [self.view addSubview:self.SV];
//        [self.view bringSubviewToFront:self.SV];
//    }
    return YES;
}
//取消的btn
-(void)cancleBtn
{
    self.SV.hidden = YES;
    //    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationController.navigationBar endEditing:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma uitextField 的代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
     self.SV.hidden = NO;
    [self.view addSubview:self.SV];
    [self.view bringSubviewToFront:self.SV];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""] || !textField.text) {
        [self.view addSubview:self.placehoderView];
        [self.view bringSubviewToFront:self.placehoderView];
    }else{
        [self.view addSubview:self.SV];
        [self.view bringSubviewToFront:self.SV];
    }
    return YES;
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

#pragma mark - yulei 代码

//---------------------------------------------二期代码------------------------------------------------

//热词点击
- (void)HotWordClickedWithHotWord:(HsearchModel *)model {
    if (!model.searchText) {
        [self pushNextViewController:model];
    }else{
        [self addSearchRecordWithText:model.searchText];
    }
    
}

//更多历史足迹
- (void)moreButtonCliked {
    VScanRecordVC *recordVC = [[VScanRecordVC alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

//进入历史足迹详情
- (void)pushDetailControllerWithModel:(VScanHistoryModel *)model {
    DetailsViewController *detailVC = [[DetailsViewController alloc]init];
    detailVC.name = model.name;
    detailVC.iD = [NSString stringWithFormat:@"%@",model.ident];
    detailVC.type = @"";
    [self.navigationController pushViewController:detailVC animated:YES];
}

//----------------------------------------------------------------------------------------------------

#pragma mark - getter

- (VSearchView *)placehoderView {
    if (!_placehoderView) {
        _placehoderView = [[VSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _placehoderView.delegate = self;
    }
    return _placehoderView;
}




@end
