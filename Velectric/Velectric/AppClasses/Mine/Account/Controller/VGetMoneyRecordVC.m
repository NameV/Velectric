//
//  VGetMoneyRecordVC.m
//  Velectric
//
//  Created by LYL on 2017/2/25.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VGetMoneyRecordVC.h"
#import "VGetMoneyRecordModel.h"
#import "VGetMoneyRecordCell.h"
#import "VEmptyView.h"

static NSInteger page = 0;

@interface VGetMoneyRecordVC ()

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) VGetMoneyRecordModel *recordModel;
@property (nonatomic, strong) VEmptyView *emptyView;
@end

@implementation VGetMoneyRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfig];
}

- (void)baseConfig {
    self.navigationItem.title = @"提现记录";
    page = 0;
    self.view.backgroundColor = V_BACKGROUND_COLOR;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VGetMoneyRecordCell class] forCellReuseIdentifier:NSStringFromClass([VGetMoneyRecordCell class])];
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRefresh)];
    [self.tableView headerBeginRefreshing];
    
    [self.view addSubview:self.emptyView];
    self.emptyView.hidden = YES;
}

#pragma mark - https

//提现记录接口
- (void)getRecordRequest {
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"beginDate"   : @"",
                               @"endDate"     : @"",
                               @"currentPage"   :   [NSNumber numberWithInteger:page]
                               };
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:WithdrawRecordURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               self.recordModel = [VGetMoneyRecordModel yy_modelWithDictionary:responseObject];
                                               if (page == 0) {
                                                   [self.datas removeAllObjects];
                                               }
                                               [self.datas addObjectsFromArray:self.recordModel.recordList];
                                               
                                               if (self.datas.count == 0) {
                                                   self.emptyView.hidden = NO;
                                               }else{
                                                   self.emptyView.hidden = YES;
                                                  [self.tableView reloadData];
                                               }
                                               
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           [self.tableView footerEndRefreshing];
                                           [self.tableView headerEndRefreshing];
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                           [self.tableView footerEndRefreshing];
                                           [self.tableView headerEndRefreshing];
                                       }];
}

#pragma mark - action
//下拉刷新
- (void)headerRefresh {
    page = 0;
    [self getRecordRequest];
}
//上拉刷新
- (void)footerRefresh {
    page ++;
    [self getRecordRequest];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VGetMoneyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VGetMoneyRecordCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter

-(NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (VEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[VEmptyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _emptyView.label.text = @"暂无提现记录";
    }
    return _emptyView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
