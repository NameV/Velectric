//
//  VFactoryCollectVC.m
//  Velectric
//
//  Created by LYL on 2017/2/16.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VFactoryCollectVC.h"
#import "VFactoryCollectCell.h"
#import "VFactoryCollectModel.h"
#import "CartnilView.h"
#import "FactoryViewController.h"//厂商详情

@interface VFactoryCollectVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) CartnilView *emptyView;

@end

@implementation VFactoryCollectVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfig];
}

- (void)baseConfig {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.emptyView];
    [self.tableView headerBeginRefreshing];
}

#pragma mark - https
//获取收藏厂商列表
- (void)requestData {

    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName
                               };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetCollectionManufacturerURL parameters:paramDic success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        VFactoryCollectModel *model = [VFactoryCollectModel yy_modelWithDictionary:responseObject[@"collectionManufacturerCache"]];
        self.datas = [model.collectionManuacturer mutableCopy];
        //************
//        VCollectionManuacturerModel *cellModel = [[VCollectionManuacturerModel alloc]init];
//        cellModel.createTime = @"2013-12-12 12:12:12";
//        cellModel.name = @"啦啦啦";
//        cellModel.times = @"1234";
//        [self.datas addObject:cellModel];
        //************
        if (self.datas.count) {
            [self.tableView reloadData];
            self.emptyView.hidden = YES;
        }else{
            [self.view bringSubviewToFront:self.emptyView];
            self.emptyView.hidden = NO;
        }
        
        [self.tableView headerEndRefreshing];
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
        [self.tableView headerEndRefreshing];
    }];
}

//取消收藏厂商
- (void)cancelCollectFactoryWithIndex:(NSInteger)index {
    
    VCollectionManuacturerModel *model = self.datas[index];
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  @"manufacturerId":model.manufacturerId ? model.manufacturerId : @""
                                  };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:CancelCollectionManufacturerURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        [VJDProgressHUD showSuccessHUD:@"取消成功"];
        [self.datas removeObjectAtIndex:index];
        if (self.datas.count) {
            [self.tableView reloadData];
            self.emptyView.hidden = YES;
        }else{
            [self.view bringSubviewToFront:self.emptyView];
            self.emptyView.hidden = NO;
        }
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - tableView 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VFactoryCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VFactoryCollectCell class]) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    cell.index = indexPath.row;
    
    //取消收藏block
    VJDWeakSelf;
    cell.block = ^(NSInteger index) {
        [weakSelf cancelCollectFactoryWithIndex:index];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VCollectionManuacturerModel *model = self.datas[indexPath.row];
    FactoryViewController *detailVC = [[FactoryViewController alloc]init];
    detailVC.manufacturerName = model.name;
    detailVC.manufacturerId = model.manufacturerId;
    detailVC.type = @"2";
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - action
//空界面button点击方法，返回首页
- (void)goMainView:(UIButton *)btn {
    self.tabBarController.selectedIndex = 0;
}

#pragma mark - getter 

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[VFactoryCollectCell class] forCellReuseIdentifier:NSStringFromClass([VFactoryCollectCell class])];
        tableView.tableFooterView = [UIView new];
        [tableView addHeaderWithTarget:self action:@selector(requestData)];
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (CartnilView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[[NSBundle mainBundle]loadNibNamed:@"CartnilView" owner:self options:nil] lastObject];
        _emptyView.nilImageView.image = [UIImage imageNamed:@"收藏_空"];
        [_emptyView.goIGuangGuangBtn addTarget:self action:@selector(goMainView:) forControlEvents:UIControlEventTouchUpInside];
        _emptyView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _emptyView.userInteractionEnabled = YES;
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end