//
//  AddressManageVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/13.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "AddressManageVC.h"
#import "AddressListCell.h"
#import "AddressListCell1.h"
#import "AddressModel.h"
#import "NewAddressVC.h"
#import "AlertView.h"

@interface AddressManageVC ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate,AlertViewDelegate>

//列表
@property (strong,nonatomic)BaseTableView * tableView;

//空白页
@property (strong,nonatomic)UIView * notDataView;

//删除model
@property (strong,nonatomic)AddressModel * deleteModel;

@end

@implementation AddressManageVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.navTitle];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.navTitle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"地址管理";
    
    //创建 UI
    [self creatUI];
}

#pragma mark - 创建 UI
-(void)creatUI
{
    //创建 没数据view
    [self creatNotdataView];
    
    UIImage * addImag = [UIImage imageNamed:@"xinzeng"];
    
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - addImag.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView addHeaderWithTarget:self action:@selector(refreshNetData)];
    [_tableView headerBeginRefreshing];
    [self.view addSubview:_tableView];
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake((SCREEN_WIDTH - addImag.size.width)/2, _tableView.bottom, addImag.size.width, addImag.size.height);
    [addBtn setImage:addImag forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

#pragma mark - 创建 nodataView
-(void)creatNotdataView
{
    _notDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH + 100)];
    _notDataView.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:_notDataView];
    
    UIImage * image = [UIImage imageNamed:@"notAddress"];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - image.size.width)/2, 38, image.size.width, image.size.height)];
    imageView.image = image;
    [_notDataView addSubview:imageView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom + 20, SCREEN_WIDTH, 20)];
    label.text = @"您还没有添加地址哦，赶快去添加地址吧";
    label.font = Font_1_F16;
    label.textColor = COLOR_999999;
    label.textAlignment = NSTextAlignmentCenter;
    [_notDataView addSubview:label];
    
    _notDataView.frame = CGRectMake(0, 0, SCREEN_WIDTH, label.bottom + 95);
    _notDataView.hidden = YES;
}

#pragma mark - FreshHeader
- (void)refreshNetData
{
    [self requestAddressData];
}

#pragma mark - 请求数据
-(void)requestAddressData
{
    NSDictionary * parameterDic = @{@"memberId": GET_USER_INFO.memberId,};
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetFindUserAddressListURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            //移除旧数据
            [weakSelf.tableView.dataArray removeAllObjects];
            NSArray * addressList = [responseObject objectForKey:@"addressList"];
            
            if (addressList.count == 0) {
                weakSelf.notDataView.hidden = NO;
            }else{
                weakSelf.notDataView.hidden = YES;
            }
            for (NSDictionary * dic in addressList) {
                AddressModel * model = [[AddressModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [weakSelf.tableView.dataArray addObject:model];
            }
            
            [weakSelf.tableView reloadData];
            [weakSelf.tableView headerEndRefreshing];
            [weakSelf.tableView footerEndRefreshing];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:error.domain];
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableView.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_enterSource == AddressManageEnterSource_Order) {
        //创建订单
        static NSString * indentifer=@"indentifer";
        AddressListCell * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
        if (!cell)
        {
            cell=[[AddressListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=COLOR_FFFFFF;
        }
        cell.delegate = self;
        AddressModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
        cell.model = model;
        cell.editBtn.tag = indexPath.row;
        [cell.editBtn addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if (_enterSource == AddressManageEnterSource_Mine){
        //会员中心
        static NSString * indentifer= @"indentifer";
        AddressListCell1 * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
        if (!cell)
        {
            cell=[[AddressListCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
        }
        AddressModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
        cell.nameLab.text = model.recipient;
        NSMutableString * phone = [[NSMutableString alloc]initWithString:model.mobile];
        if (phone.length == 11)
        {
            [phone replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
        if ([model.defaulted intValue]) {
            [cell.setDefautBtn setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
            [cell.setDefautBtn setTitle:@"取消默认" forState:UIControlStateNormal];
        }else{
            [cell.setDefautBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
            [cell.setDefautBtn setTitle:@"设为默认" forState:UIControlStateNormal];
        }
        
        cell.phoneLab.text = phone;
        cell.addressLab.text = [NSString stringWithFormat:@"%@",model.address];
        cell.editBtn.tag = indexPath.row;
        cell.deleteBtn.tag = indexPath.row;
        cell.setDefautBtn.tag = indexPath.row;
        
        [cell.editBtn addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteBtn addTarget:self action:@selector(deleteAddressEnterSourceMine:) forControlEvents:UIControlEventTouchUpInside];
        [cell.setDefautBtn addTarget:self action:@selector(setDefautAddressEnterSourceMine:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_enterSource == AddressManageEnterSource_Order){
        return 86;
    }else if (_enterSource == AddressManageEnterSource_Mine){
        return 125;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_enterSource == AddressManageEnterSource_Order){
        AddressModel * model = [_tableView.dataArray objectAtIndex:indexPath.row];
        _chooseAddressBlcok(model);
        [self.navigationController popViewControllerAnimated:YES];
        //模型转换
        NSDictionary * dic = [model toDictionary];
        //获取路径
        NSString * addressPath = [DOCUMENT_PATH stringByAppendingFormat:@"/Address/%@",GET_USER_INFO.loginName];
        NSString * addressUrl = [addressPath stringByAppendingString:@"/AddressData"];
        NSFileManager * fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:addressPath]) {
            [dic writeToFile:addressUrl atomically:YES];
        }else{
            [fileManager createDirectoryAtPath:addressPath withIntermediateDirectories:YES attributes:nil error:nil];
            [dic writeToFile:addressUrl atomically:YES];
        }
    }
}

#pragma mark - MGSwipeTableCellDelegate
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction;
{
    return YES;
}

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    VJDWeakSelf;
    if (direction == MGSwipeDirectionRightToLeft) {
        expansionSettings.fillOnTrigger = YES;
        expansionSettings.threshold = 1.1;
        
        MGSwipeButton * edit = [MGSwipeButton buttonWithTitle:@"设为默认" backgroundColor:COLOR_F7F7F7 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            NSIndexPath * indexPath = [weakSelf.tableView indexPathForCell:cell];
            AddressModel * model = [weakSelf.tableView.dataArray objectAtIndex:indexPath.row];
            [weakSelf setDefautAddressEnterSourceOrder:model];
            
            if ([model.defaulted intValue]) {
                [edit setTitle:@"取消默认" forState:UIControlStateNormal];;
            }else{
                [edit setTitle:@"设为默认" forState:UIControlStateNormal];;
            }
            
            return NO;
        }];
        edit.titleLabel.font = Font_1_F14;
        [edit setTitleColor:COLOR_333333 forState:UIControlStateNormal];
        [edit setButtonWidth:80];
        
        MGSwipeButton * delete = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:COLOR_F2B602 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            NSIndexPath * indexPath = [weakSelf.tableView indexPathForCell:cell];
            AddressModel * model = [weakSelf.tableView.dataArray objectAtIndex:indexPath.row];
            [weakSelf deleteAddressEnterSourceOrder:model];
            return NO;
        }];
        delete.titleLabel.font = Font_1_F14;
        [delete setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [delete setButtonWidth:80];
        return @[delete, edit,];
    }
    return nil;
}
#pragma mark - 编辑
-(void)editAddress:(UIButton *)sender
{
    AddressModel * model = [_tableView.dataArray objectAtIndex:sender.tag];
    NewAddressVC * vc = [[NewAddressVC alloc]init];
    vc.addressId = model.myId;
    [vc requestAddressData];
    VJDWeakSelf;
    [self.navigationController pushViewController:vc animated:YES];
    vc.insertAddressBlcok = ^(){
        [weakSelf.tableView headerBeginRefreshing];
    };
}

#pragma mark - 设为默认
-(void)setDefautAddressEnterSourceMine:(UIButton *)sender
{
    AddressModel * model = [_tableView.dataArray objectAtIndex:sender.tag];
    NSString * requestUrl;
    NSDictionary * parameterDic ;
    if ([model.defaulted intValue]) {
        //取消默认
        requestUrl = GetCancelDefaultedURL;
        parameterDic  = @{@"memberId": GET_USER_INFO.memberId,
                          };;
    }else{
        //设为默认
        requestUrl = GetUpdateDefaultedURL;
        parameterDic = @{@"id": model.myId,
                         @"memberId": GET_USER_INFO.memberId,
                         @"defaulted":@"1",};
    }
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:requestUrl parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]) {
            [weakSelf.tableView headerBeginRefreshing];
            if ([requestUrl isEqualToString:GetCancelDefaultedURL]) {
                [VJDProgressHUD showTextHUD:@"取消默认地址成功"];
            }else{
                [VJDProgressHUD showTextHUD:@"设为默认地址成功"];
            }
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

-(void)setDefautAddressEnterSourceOrder:(AddressModel *)model
{
    NSString * requestUrl;
    NSDictionary * parameterDic;
    if ([model.defaulted intValue]) {
        //取消默认
        requestUrl = GetCancelDefaultedURL;
        parameterDic  = @{@"memberId": GET_USER_INFO.memberId,
                          };;
    }else{
        //设为默认
        requestUrl = GetUpdateDefaultedURL;
        parameterDic = @{@"id": model.myId,
                         @"memberId": GET_USER_INFO.memberId,
                         @"defaulted":@"1",};
    }
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:requestUrl parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]) {
            [weakSelf.tableView headerBeginRefreshing];
            if ([requestUrl isEqualToString:GetCancelDefaultedURL]) {
                [VJDProgressHUD showTextHUD:@"取消默认地址成功"];
            }else{
                [VJDProgressHUD showTextHUD:@"设为默认地址成功"];
            }
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

#pragma mark - 删除
-(void)deleteAddressEnterSourceMine:(UIButton *)sender
{
    _deleteModel = [_tableView.dataArray objectAtIndex:sender.tag];
    
    AlertView * alert = [[AlertView alloc]initWithLeftTitle:@"确定" WithRightTitle:@"取消" ContentTitle:@"是否确认删除该地址？"];
    alert.delegate = self;
    [[KGModal sharedInstance] showWithContentView:alert];
}

-(void)deleteAddressEnterSourceOrder:(AddressModel *)model
{
    _deleteModel = model;
    
    AlertView * alert = [[AlertView alloc]initWithLeftTitle:@"确定" WithRightTitle:@"取消" ContentTitle:@"是否确认删除该地址？"];
    alert.delegate = self;
    [[KGModal sharedInstance] showWithContentView:alert];
}


#pragma mark - 添加地址
-(void)addAddress
{
    NewAddressVC * vc = [[NewAddressVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    VJDWeakSelf;
    vc.insertAddressBlcok = ^(){
        [weakSelf.tableView headerBeginRefreshing];
    };
}

#pragma mark - AlertView Delegate
- (void)okBtnAction
{
    [[KGModal sharedInstance] hide];
    //去删除
    [self doDeleteAddress];
}

- (void)cancleBtnAction
{
    [[KGModal sharedInstance] hide];
}

#pragma mark - 去删除
-(void)doDeleteAddress
{
    NSDictionary * parameterDic = @{@"id": _deleteModel.myId,};
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetDeleteAddressURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]) {
            [VJDProgressHUD showSuccessHUD:nil];
            [weakSelf.tableView.dataArray removeObject:weakSelf.deleteModel];
            [weakSelf.tableView reloadData];
            
            if (weakSelf.tableView.dataArray.count == 0) {
                weakSelf.notDataView.hidden = NO;
            }else{
                weakSelf.notDataView.hidden = YES;
            }
        }else{
            [VJDProgressHUD showErrorHUD:nil];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
