//
//  MineViewController.m
//  Velectric
//
//  Created by QQ on 2016/11/26.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "MineViewController.h"
#import "MineViewCell.h"                //cell
#import "OrderListVC.h"                 //我的订单
#import "AddressManageVC.h"             //地址管理
#import "OrderSettlementVC.h"           //确认订单
#import "SettingManegeVC.h"             //设置
#import "MemberInfoModel.h"             //会员信息
#import "MemberInfoVC.h"                //修改会员资料
#import "VMyCollectVC.h"                //我的收藏
#import "VMyAccoutVC.h"                 //我的账户
#import "VBatchListViewController.h"    //批量进货
#import "VHelpCenterVC.h"               //帮助中心
#import "VScanRecordVC.h"               //浏览记录

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong,nonatomic) BaseTableView * tableView;
//姓名
@property (strong,nonatomic) UILabel * nameLab;

//编辑
@property (strong,nonatomic) UIButton * editBtn;

//公司名
@property (strong,nonatomic) UILabel * companyNameLab;

//会员信息
@property (strong,nonatomic)  MemberInfoModel * memberInfoModel;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.navTitle];
    
    //请求数据
    [self requestFindRegister];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.navTitle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"会员中心";
    [self setRightBarButtonWithTitle:nil withImage:[UIImage imageNamed:@"setting"] withAction:@selector(doSettingManage)];
    
    //创建UI
    [self creatUI];
    
    if ([GET_USER_INFO.loginName isEqualToString:TestLoginName]) {//测试账号，显示请登录按钮
        [self createReloginView];
    }else{
        //创建header
        [self creatHeaderView];
    }
   
    //创建背景
    [self creatBackgroungView];
}

#pragma mark - 创建UI
-(void)creatUI
{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
//    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - 创建header
-(void)creatHeaderView
{
    UIImage * image = [UIImage imageNamed:@"topBgImage"];
    UIImageView * headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/(image.size.width/image.size.height))];
    headerView.image = image;
    headerView.userInteractionEnabled = YES;
    [_tableView setTableHeaderView:headerView];
    
    //黄色线条
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = COLOR_F2B602;
    [headerView addSubview:line];
    
    //姓名
    _nameLab = [[UILabel alloc]init];
    _nameLab.textColor = COLOR_FFFFFF;
    _nameLab.font = Font_1_F18;
    _nameLab.textAlignment = NSTextAlignmentCenter;
    CGFloat textWidth = [GET_USER_INFO.loginName getStringWidthWithFont:_nameLab.font];
    _nameLab.text = GET_USER_INFO.loginName;
    _nameLab.frame = CGRectMake((SCREEN_WIDTH - textWidth)/2, 30, textWidth, 30);
    [headerView addSubview:_nameLab];
    
    //编辑
    _editBtn = [[UIButton alloc]initWithFrame:CGRectMake(_nameLab.right + 20, _nameLab.top, 40, _nameLab.height)];
    [_editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    _editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_editBtn addTarget:self action:@selector(doEditUserName) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_editBtn];
    
    //公司名
    _companyNameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _nameLab.bottom + 10, SCREEN_WIDTH - 20, 20)];
    _companyNameLab.textColor = COLOR_FFFFFF;
    _companyNameLab.font = Font_1_F14;
    _companyNameLab.text = @"南京海伦机械设备有限公司";
    _companyNameLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_companyNameLab];
}

//显示请登录按钮
- (void)createReloginView {
    UIImage * image = [UIImage imageNamed:@"topBgImage"];
    UIImageView * headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/(image.size.width/image.size.height))];
    headerView.image = image;
    headerView.userInteractionEnabled = YES;
    [_tableView setTableHeaderView:headerView];
    
    //黄色线条
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = COLOR_F2B602;
    [headerView addSubview:line];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((SCREEN_WIDTH - 100) /2 , (headerView.frame.size.height-40)/2, 100, 40);
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:V_ORANGE_COLOR forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(reLoginActin:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
}

- (void)reLoginActin:(UIButton *)button {
    [GET_USER_INFO clearInfo];// 清除缓存的用户信息
    [UserDefaults setBool:NO forKey:DEFINE_STRING_LOGIN];//设置为未登录状态
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changRootViewController" object:nil];
    
    //友盟账号统计
    [MobClick profileSignOff];
}

#pragma mark - 创建背景
-(void)creatBackgroungView
{
    UIImage * bgImage = [UIImage imageNamed:@"bottomBgImage"];
    UIImageView * bgVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, _tableView.tableHeaderView.height, SCREEN_WIDTH,SCREEN_WIDTH/(bgImage.size.width/bgImage.size.height))];
    bgVIew.image = bgImage;
    [self.view addSubview:bgVIew];
    [self.view bringSubviewToFront:_tableView];
}

#pragma mark - 请求数据
-(void)requestFindRegister
{
    NSDictionary * parameterDic = @{@"id":GET_USER_INFO.memberId ? GET_USER_INFO.memberId : @""};
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetFindRegistervURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]) {
            NSDictionary * memberView = [responseObject objectForKey:@"memberView"];
            weakSelf.memberInfoModel = [[MemberInfoModel alloc]init];
            [weakSelf.memberInfoModel setValuesForKeysWithDictionary:memberView];
            
            //公司名称 赋值
            weakSelf.companyNameLab.text = [memberView objectForKey:@"realName"];
            
            //用户姓名
            NSString * name = [memberView objectForKey:@"contactName"];
            NSString * contactName = name.length? name:GET_USER_INFO.loginName;
            weakSelf.nameLab.text = contactName;
            CGFloat textWidth = [contactName getStringWidthWithFont:weakSelf.nameLab.font];
            weakSelf.nameLab.frame = CGRectMake((SCREEN_WIDTH - textWidth)/2, 30, textWidth, 30);
            weakSelf.editBtn.frame = CGRectMake(weakSelf.nameLab.right + 20, weakSelf.nameLab.top, 40, weakSelf.nameLab.height);
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:error.domain];
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indentifer=@"indentifer";
    MineViewCell * cell  =[tableView dequeueReusableCellWithIdentifier:indentifer];
    if (!cell)
    {
        cell = [[MineViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = COLOR_FFFFFF;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIImage * image = [UIImage imageNamed:@"mineOrder"];
            cell.lconImage.image = image;
            cell.lconImage.frame = CGRectMake(10, (50-image.size.height)/2, image.size.width, image.size.height);
            cell.titleLab.text = @"我的订单";
        }else if (indexPath.row == 1){
            UIImage * image = [UIImage imageNamed:@"address"];
            cell.lconImage.image = image;
            cell.lconImage.frame = CGRectMake(10, (50-image.size.height)/2, image.size.width, image.size.height);
            cell.titleLab.text = @"地址管理";
            cell.lineView.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
        }else if (indexPath.row == 2){
            UIImage * image = [UIImage imageNamed:@"我的收藏图标"];
            cell.lconImage.image = image;
            cell.lconImage.frame = CGRectMake(10, (50-image.size.height)/2, image.size.width, image.size.height);
            cell.titleLab.text = @"我的收藏";
            cell.lineView.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
        }else if (indexPath.row == 3){
            UIImage * image = [UIImage imageNamed:@"我的账户图标"];
            cell.lconImage.image = image;
            cell.lconImage.frame = CGRectMake(10, (50-image.size.height)/2, image.size.width, image.size.height);
            cell.titleLab.text = @"我的账户";
            cell.lineView.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
        }else if (indexPath.row == 4){
            cell.titleLab.text = @"提交订单";
        }
    }else {
        if (indexPath.row == 0) {
            UIImage * image = [UIImage imageNamed:@"浏览记录图标"];
            cell.lconImage.image = image;
            cell.lconImage.frame = CGRectMake(10, (50-image.size.height)/2, image.size.width, image.size.height);
            cell.titleLab.text = @"浏览记录";
        }else if (indexPath.row == 1){
            UIImage * image = [UIImage imageNamed:@"批量进货图标"];
            cell.lconImage.image = image;
            cell.lconImage.frame = CGRectMake(10, (50-image.size.height)/2, image.size.width, image.size.height);
            cell.titleLab.text = @"批量进货";
            cell.lineView.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
        }else if (indexPath.row == 2){
            UIImage * image = [UIImage imageNamed:@"帮助中心图标"];
            cell.lconImage.image = image;
            cell.lconImage.frame = CGRectMake(10, (50-image.size.height)/2, image.size.width, image.size.height);
            cell.titleLab.text = @"帮助中心";
            cell.lineView.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.000001;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10);
//    view.backgroundColor = [UIColor or]
//    return view;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([GET_USER_INFO.loginName isEqualToString:TestLoginName]) {
        [VJDProgressHUD showTextHUD:ReLoginToast];
        return;
    }
    
    if (indexPath.section == 0) {
        //我的订单
        if (indexPath.row == 0) {
            OrderListVC * vc = [[OrderListVC alloc]init];
            vc.enterType = OrderCenterEnter_MemberCenter;
            [self.navigationController pushViewController:vc animated:YES];
        }
        //地址管理
        else if (indexPath.row == 1){
            AddressManageVC * vc = [[AddressManageVC alloc]init];
            vc.enterSource = AddressManageEnterSource_Mine;
            [self.navigationController pushViewController:vc animated:YES];
        }
        //我的收藏
        else if (indexPath.row == 2){
            VMyCollectVC * vc = [[VMyCollectVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        //我的账户
        else if (indexPath.row == 3){
            VMyAccoutVC * vc = [[VMyAccoutVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4){
            OrderSettlementVC * vc = [[OrderSettlementVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //浏览记录
        if (indexPath.row == 0) {
            VScanRecordVC *recordVC = [[VScanRecordVC alloc]init];
            [self.navigationController pushViewController:recordVC animated:YES];
        }
        //批量进货
        else if (indexPath.row == 1){
            VBatchListViewController *vc = [[VBatchListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        //帮助中心
        else if (indexPath.row == 2){
            VHelpCenterVC *VC = [[VHelpCenterVC alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

#pragma mark - 设置
-(void)doSettingManage
{
    SettingManegeVC * vc = [[SettingManegeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 编辑会员资料
-(void)doEditUserName
{
    MemberInfoVC * vc = [[MemberInfoVC alloc]init];
    vc.memberInfoModel = _memberInfoModel;
    vc.enterType = MemberInfoVC_Mine;
    [self.navigationController pushViewController:vc animated:YES];
    
    vc.changeMemberInfoBlock = ^(MemberInfoModel * model){
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
