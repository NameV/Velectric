//
//  VGoodsCollectVC.m
//  Velectric
//
//  Created by LYL on 2017/2/16.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VGoodsCollectVC.h"
#import "VGoodsCollectCell.h"
#import "VGoodsCollectModel.h"
#import "CartnilView.h"
#import "DetailsViewController.h"

@interface VGoodsCollectVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) CartnilView *emptyView;

@end

@implementation VGoodsCollectVC

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
//获取收藏产品列表
- (void)requestData {
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName
                               };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetCollectionProductURL parameters:paramDic success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        VGoodsCollectModel *model = [VGoodsCollectModel yy_modelWithDictionary:responseObject[@"collectionProductCache"]];
        self.datas = [model.collectionProduct mutableCopy];
        
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
        [self.tableView headerEndRefreshing];
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}
//取消收藏产品
- (void)cancelCollectProductWithIndex:(NSInteger)index {

    VGoodsCollectCellModel *model = self.datas[index];
    NSDictionary * parameters = @{@"loginName":GET_USER_INFO.loginName,
                                  @"productId":model.productId ? model.productId : @""
                                  };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:CancelCollectionProductURL parameters:parameters success:^(NSDictionary *responseObject) {
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
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VGoodsCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VGoodsCollectCell class]) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    cell.index = indexPath.row;
    
    //取消收藏block
    VJDWeakSelf;
    cell.block = ^(NSInteger index) {
        [weakSelf cancelCollectProductWithIndex:index];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VGoodsCollectCellModel *model = self.datas[indexPath.row];
    DetailsViewController *detailVC = [[DetailsViewController alloc]init];
    detailVC.name = model.name;
    detailVC.iD = model.productId;
    detailVC.type = @"";
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - action 
//空界面button点击方法，返回首页
- (void)goMainView:(UIButton *)btn {
    self.tabBarController.selectedIndex = 0;

    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    });
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[VGoodsCollectCell class] forCellReuseIdentifier:NSStringFromClass([VGoodsCollectCell class])];
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
        _emptyView.userInteractionEnabled = YES;
        _emptyView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
