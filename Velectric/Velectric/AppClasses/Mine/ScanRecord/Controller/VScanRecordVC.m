//
//  VScanRecordVC.m
//  Velectric
//
//  Created by LYL on 2017/3/2.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VScanRecordVC.h"
#import "VScanHistoryModel.h"
#import "VScanHistoryCell.h"
#import "VDateModel.h"
#import "VSelectAllView.h"
#import "VScanTableHeaderView.h"
#import "VEmptyView.h"
#import "DetailsViewController.h"
#import "USPopView.h"
#import "VDateManager.h"

@interface VScanRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *datas;
@property (nonatomic, strong)VEmptyView *emptyView;

@property (nonatomic, assign)BOOL editBtnSelected;
@property (nonatomic, strong)UIButton *editBtn;
@property (nonatomic, strong)UIButton *emptyBtn;
@property (nonatomic, strong)NSMutableArray *selectedDatas;

@property (nonatomic, strong)NSMutableArray *testDatas;
@property (nonatomic, strong)VSelectAllView *bottomView;

@end

@implementation VScanRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfig];
}

- (void)baseConfig {
    self.navTitle = @"浏览记录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建导航栏右侧按钮
    [self createRightView];
    
    [self.view addSubview:self.emptyView];
    [self.emptyView.toMainBtn addTarget:self action:@selector(toMainBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.emptyView.hidden = YES;
    self.emptyBtn.hidden = NO;
    self.emptyBtn.hidden = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    self.bottomView.hidden = YES;
    self.editBtnSelected = NO;

    [self getAllHistoryRecord];//网络请求
}

#pragma mark - https

//获取所有历史记录
- (void)getAllHistoryRecord {
    
    NSDictionary *paramDic = @{
                               @"memberId" : GET_USER_INFO.memberId
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:HistoricalFootprintQueryURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [VJDProgressHUD showSuccessHUD:nil];
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                              self.datas = [VDateManager getArrayWithArray:responseObject[@"list"]];
                                               if (self.datas != nil && ![self.datas isKindOfClass:[NSNull class]] && self.datas.count != 0) {
                                                   self.emptyView.hidden = YES;
                                                   [self.tableView reloadData];
                                                   self.editBtn.hidden = NO;
                                                   self.emptyBtn.hidden = NO;
                                               }else{
                                                   [self.view bringSubviewToFront:self.emptyView];
                                                   self.emptyView.hidden = NO;
                                                   self.editBtn.hidden = YES;
                                                   self.emptyBtn.hidden = YES;
                                               }
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//清空所有历史记录
- (void)deleteAllHistoryRecord {
    
    NSDictionary *paramDic = @{
                               @"memberId" : GET_USER_INFO.memberId
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:HistoricalFootprintDeleteURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [VJDProgressHUD showSuccessHUD:nil];
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               [self.datas removeAllObjects];
                                               [self.view bringSubviewToFront:self.emptyView];
                                               self.emptyView.hidden = NO;
                                               self.editBtn.hidden = YES;
                                               self.emptyBtn.hidden = YES;
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//清空单个历史记录
- (void)deleteSingalHistoryRecordWithIndexPath:(NSIndexPath *)indexPath {
    
    VScanHistoryModel *model = self.datas[indexPath.section][indexPath.row];
    NSDictionary *paramDic = @{
                               @"id" : model.ident
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:HistoricalFootprintDeleteByIdURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [VJDProgressHUD showSuccessHUD:nil];
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               
                                               NSMutableArray *mutArray = [self.datas[indexPath.section] mutableCopy];
                                               [mutArray removeObjectAtIndex:indexPath.row];
                                               if (mutArray.count) {
                                                   [self.datas replaceObjectAtIndex:indexPath.section withObject:mutArray];
                                               }else{
                                                   [self.datas removeObjectAtIndex:indexPath.section];
                                               }
                                               if (self.datas != nil && ![self.datas isKindOfClass:[NSNull class]] && self.datas.count != 0) {
                                                   [self.tableView reloadData];
                                               }else{
                                                   [self.view bringSubviewToFront:self.emptyView];
                                                   self.emptyView.hidden = NO;
                                                   self.emptyBtn.hidden = YES;
                                                   self.editBtn.hidden = YES;
                                               }
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}


#pragma mark -------------------------- 全选.删除.编辑.-------------------------------
//编辑
- (void)editAction:(UIButton *)btn {
    
    self.editBtnSelected = !self.editBtnSelected;
    
    //不选中，变成编辑
    if (self.editBtnSelected == NO) {
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }else{
        [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    //清空按钮隐藏---选中便隐藏清空按钮
    self.emptyBtn.hidden = self.editBtnSelected;
    
    //底部视图隐藏控制-----选中不隐藏
    [UIView animateWithDuration:1.0 animations:^{
        self.bottomView.hidden = !self.editBtnSelected;
    }];
    
    //cell图片隐藏
    for (int i = 0; i < self.datas.count; i ++) {
        NSArray *array = self.datas[i];
        for (int j = 0; j < array.count; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            VScanHistoryCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.imageHidden = !self.editBtnSelected;
            cell.userInteractionEnabled = cell.imageHidden;
        }
        VScanTableHeaderView *headerView = (VScanTableHeaderView *)[self.tableView headerViewForSection:i];
        headerView.selectImage.hidden = !self.editBtnSelected;
    }
}

//全选
- (void)selectAllBtnAction:(UIButton *)btn {
    self.bottomView.selectAllBtn.selected = !self.bottomView.selectAllBtn.selected;
    //button选中的时候，全部选中
    for (int i = 0; i < self.datas.count; i ++) {
        NSArray *array = self.datas[i];
        for (int j = 0; j < array.count; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            VScanHistoryCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.selected = btn.selected;
        }
        VScanTableHeaderView *headerView = (VScanTableHeaderView *)[self.tableView headerViewForSection:i];
        headerView.imageSelected = btn.selected;
    }
    if (self.bottomView.selectAllBtn.selected) {
        [self.selectedDatas addObjectsFromArray:self.datas];
    }else{
        [self.selectedDatas removeAllObjects];
    }
}

//清空
- (void)emptyBtnAction:(UIButton *)btn {
    USPopView *popView = [[USPopView alloc]initTitle:@"提示" descripton:@"您确定要清空浏览记录吗？" certenBlock:^{
        [self deleteAllHistoryRecord];
    }];
    [popView show];
}

//删除
- (void)deleteBtnAction:(UIButton *)btn {
    if (!self.selectedDatas.count) {
        [VJDProgressHUD showTextHUD:@"请全选后删除！"];
        return;
    }
    USPopView *popView = [[USPopView alloc]initTitle:@"提示" descripton:@"您确定要全部删除吗？" certenBlock:^{
        [self deleteAllHistoryRecord];
    }];
    [popView show];
}

//去逛逛  回到主页
- (void)toMainBtnAction:(UIButton *)btn {
    
    
    if (self.tabBarController.selectedIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [self.navigationController popToRootViewControllerAnimated:NO];
        });
    }
    self.tabBarController.selectedIndex = 0;
}

#pragma mark ------------------------- tableview delegate---------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VScanHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VScanHistoryCell class]) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.section][indexPath.row];
    cell.imageHidden = YES;
    cell.userInteractionEnabled = cell.imageHidden;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    VScanTableHeaderView *headerView = [[VScanTableHeaderView alloc]init];
    headerView.titleLabel.text = [[self.datas[section] firstObject] createTimeStr];
    headerView.selectImage.hidden = YES;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VScanHistoryModel *model = self.datas[indexPath.section][indexPath.row];
    DetailsViewController *detailVC = [[DetailsViewController alloc]init];
    detailVC.name = model.name;
    detailVC.iD = [NSString stringWithFormat:@"%@",model.ident];
    [self.navigationController pushViewController:detailVC animated:YES];
}

//设置可删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                               title:@"删除"
                                                                             handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                                 [self deleteSingalHistoryRecordWithIndexPath:indexPath];
    }];
    deleteRoWAction.backgroundColor = V_ORANGE_COLOR;
    return @[deleteRoWAction];
}



#pragma mark - setter



#pragma mark - getter

- (void)createRightView {
    //编辑 按钮
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    editBtn.frame = CGRectMake(0, 0, 40, 20);
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.editBtnSelected = NO;
    [editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn = editBtn;
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithCustomView:editBtn];
    //清空 按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    deleteBtn.frame = CGRectMake(0, 0, 40, 20);
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"清空" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(emptyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.emptyBtn = deleteBtn;
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc]initWithCustomView:deleteBtn];
    self.navigationItem.rightBarButtonItems = @[editItem,deleteItem];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        [_tableView registerClass:[VScanHistoryCell class] forCellReuseIdentifier:NSStringFromClass([VScanHistoryCell class])];
    }
    return _tableView;
}

- (VEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[VEmptyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _emptyView.imageView.image = [UIImage imageNamed:@"emptyIcon"];
        _emptyView.label.text = @"您还没有浏览任何商品哦！";
        _emptyView.toMainBtn.hidden = NO;
    }
    return _emptyView;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (NSMutableArray *)selectedDatas {
    if (!_selectedDatas) {
        _selectedDatas = [NSMutableArray array];
    }
    return _selectedDatas;
}

- (VSelectAllView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[VSelectAllView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50)];
        [_bottomView.selectAllBtn addTarget:self action:@selector(selectAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
