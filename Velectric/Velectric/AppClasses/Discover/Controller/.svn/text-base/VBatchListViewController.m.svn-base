//
//  VBatchListViewController.m
//  Velectric
//
//  Created by MacPro04967 on 2017/2/14.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VBatchListViewController.h"
#import "VbatchListCell.h"
#import "VBacthListModel.h"
#import "VBatchShopViewController.h"
#import "VEmptyView.h"
#import "USPopView.h"

@interface VBatchListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) UIButton *batchBtn;   //批量进货
@property (nonatomic, strong) VEmptyView *emptyView;
@property (nonatomic, strong) UIBarButtonItem *leftItem;

@end

@implementation VBatchListViewController{
    NSIndexPath *_currentIndexPath;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getBatchListRequst];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseConfig];
}

- (void)baseConfig {
    self.navTitle = @"批量进货";
    self.navigationItem.leftBarButtonItem = self.leftItem;
    [self setRightBarButtonWithTitle:nil withImage:[UIImage imageNamed:@"电话"] withAction:@selector(callPhonenumber)];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.emptyView];
    [self.view addSubview:self.batchBtn];
}

#pragma mark - https

//获取批量进货列表
- (void)getBatchListRequst {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:GetBatchProductAllURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               VBacthListModel *model = [VBacthListModel yy_modelWithDictionary:responseObject];
                                               self.datas = [[[model.batchProducts reverseObjectEnumerator] allObjects] mutableCopy];
                                               if (self.datas.count) {
                                                   [self.tableView reloadData];
                                                   self.emptyView.hidden = YES;
                                               }else{
                                                   [self.view bringSubviewToFront:self.emptyView];
                                                   [self. view bringSubviewToFront:self.batchBtn];
                                                   self.emptyView.hidden = NO;
                                               }
                                               [self.tableView reloadData];
                                               
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//左滑删除
- (void)deleteBatchRequstWithIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *ident = [self.datas[indexPath.section] ident];
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"id"    :   ident ? ident : @""
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:DeleteBatchProductURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                        
                                               [self.datas removeObjectAtIndex:indexPath.section];
                                               if (self.datas.count) {
                                                   [self.tableView reloadData];
                                                   self.emptyView.hidden = YES;
                                               }else{
                                                   [self.view bringSubviewToFront:self.emptyView];
                                                   [self. view bringSubviewToFront:self.batchBtn];
                                                   self.emptyView.hidden = NO;
                                               }
                                               [self.tableView reloadData];
                                               
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

#pragma mark - action

- (void)batchBtnAction:(UIButton *)btn {
    VBatchShopViewController *vc = [[VBatchShopViewController alloc]initWithProductType:Product_Add];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    VBatchCellModel *model = self.datas[indexPath.section];
    return model.cellHeight ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VbatchListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VbatchListCell class]) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _currentIndexPath = indexPath;
    cell.editBtn.tag = indexPath.section;
    [cell.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    topLine.backgroundColor = [UIColor ylColorWithHexString:@"dddddd"];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    bgView.backgroundColor = [UIColor ylColorWithHexString:@"f7f7f7"];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 9, SCREEN_WIDTH, 1)];
    bottomLine.backgroundColor = [UIColor ylColorWithHexString:@"dddddd"];
    
    [bgView addSubview:topLine];
    [bgView addSubview:bottomLine];
    
    return bgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - btn action --- 删除 编辑

- (void)editBtnAction:(UIButton *)btn {
    VBatchShopViewController *vc = [[VBatchShopViewController alloc]initWithProductType:Product_update];
    vc.ident = [self.datas[btn.tag] ident];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deleteBtnAction:(UIButton *)btn {
    USPopView *pop = [[USPopView alloc]initTitle:@"确定删除？" descripton:nil certenBlock:^{
    [self deleteBatchRequstWithIndexPath:_currentIndexPath];
    }];
    [pop show];
}

//打电话
- (void)callPhonenumber {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TelePhoneNum]];//TODO
}

//返回
- (void)didBack:(UIButton *)btn {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStyleGrouped];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableview.backgroundColor = [UIColor whiteColor];
        [tableview registerClass:[VbatchListCell class] forCellReuseIdentifier:NSStringFromClass([VbatchListCell class])];
        _tableView = tableview;
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (UIButton *)batchBtn {
    if (!_batchBtn) {
        _batchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _batchBtn.frame = CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50);
        _batchBtn.backgroundColor = V_ORANGE_COLOR;
        [_batchBtn setTitle:@"批量进货" forState:UIControlStateNormal];
        [_batchBtn setTitleColor:V_WHITE_COLOR forState:UIControlStateNormal];
        [_batchBtn addTarget:self action:@selector(batchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _batchBtn;
}

- (VEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[VEmptyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _emptyView.imageView.image = [UIImage imageNamed:@"batchEmpty"];
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

//左侧返回按钮
- (UIBarButtonItem *)leftItem {
    if (!_leftItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 20, 20);
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
        [button addTarget:self action:@selector(didBack:) forControlEvents:UIControlEventTouchUpInside];
        _leftItem = item;
    }
    return _leftItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
