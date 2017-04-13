//
//  memberMeansController.m
//  Velectric
//
//  Created by QQ on 2016/11/22.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "memberMeansController.h"
#import "MemberCell.h"
#import "CheckViewController.h"
#import "publicCell.h"
#import "BuyScopeController.h"
#import "RXJDAddressPickerView.h"
#import "BuyScoreView.h"
#import "MemberModel.h"
#import "VJDRegionView.h"
#import "RegionModel.h"
#import "USPopView.h"

static NSInteger TagParam = 1000;

@interface memberMeansController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BuybackRootViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, MemberCellDelegate>
{
    NSArray * dataArray;//cell 的头部数据
    NSMutableArray * listArray;//会员查询的数据
    NSMutableArray * listchildArray;//经营范围的数据
    RXJDAddressPickerView   * _threePicker;//地址
    NSMutableArray * parmerArr;//修改时上传的数据
    NSMutableArray * picArray;//上传成功的bunessID
    NSMutableDictionary * muDicKeyInfo;//保存每个cell的值
    NSMutableDictionary * picDic;//保存图片的字典
    

}
#define IMAGE_SIZE 300 * 1024
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIView * listView;
@property (nonatomic,strong)UIView * bgView;
@property (nonatomic,strong)UITableView * listTableView;
@property (nonatomic,strong)UIButton * btn1;
@property (nonatomic,strong)UIButton * btn2;
@property (nonatomic,strong)UIButton * btn3;

@property (nonatomic,strong)UITableView *tableView2;//二级页面
@property (nonatomic,strong)UITableView * tableView1;
@property (nonatomic, strong)NSMutableArray *tableArray; //记录选中的二级物品
@property (nonatomic, assign)BOOL isSelect;//是否选中过cell
@property (nonatomic, strong)UIView * jingYingScroeView;
@property (nonatomic, assign)BOOL isNav;//是否返回rootViewcontroller
@property (nonatomic, copy)NSString * regionId;//省市区地址
@property (nonatomic, copy)NSString * managerange;//经营范围

@property (nonatomic, strong)UIView * backgroundView;//选取照片的背景view
@property(nonatomic, strong)UIImagePickerController *photosVC;
@property (nonatomic, copy)NSString * myId;

@property (nonatomic,strong)UIButton * picBtn;
@property (nonatomic, strong)MemberModel * model;
@property (nonatomic, copy)NSString * successStr;

//二期新加的model，之前的model 乱七八糟 F**K
@property (nonatomic, strong)MemberModel * dataModel;

@end

@implementation memberMeansController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"完善会员资料"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navTitle = @"会员资料";
    dataArray = [NSMutableArray array];
    listArray = [NSMutableArray array];
    parmerArr = [NSMutableArray array];
    picArray =  [NSMutableArray array];
    muDicKeyInfo = [NSMutableDictionary dictionary];
    picDic = [NSMutableDictionary dictionary];

    [self creatUI];
    [self initNav];
    //获取界面数据
    [self upDataNetWorking];
    
    dataArray = @[@{@"str":@"*公司名称",@"Plicehold":@"请输入公司名称"},@{@"str":@"*执照编号",@"Plicehold":@"请填写营业执照编号"},@{@"str":@"*营业执照",@"Plicehold":@"请上传营业执照"},@{@"str":@"*商铺照片",@"Plicehold":@"请上传商铺照片"},@{@"str":@"*税务登记表",@"Plicehold":@"确请上传税务登记表"},@{@"str":@"*联系人",@"Plicehold":@"请填写联系人"},@{@"str":@"*联系方式",@"Plicehold":@"请输入联系人手机号"},@{@"str":@"*所在地",@"Plicehold":@"所在地区"},@{@"str":@"*详细地址",@"Plicehold":@"请填写详细地址"},@{@"str":@"*经营范围",@"Plicehold":@"请输入经营范围"},@{@"str":@"介绍人",@"Plicehold":@"介绍人"},@{@"str":@"介绍人电话",@"Plicehold":@"介绍人电话"}];
       MemberModel * model = [[MemberModel alloc]init];
       self.model = model;
        model.realName = @"请输入公司名称";
        model.businessLicenseCode = @"请填写营业执照编号";
        model.wid = @"1";
        model.sid = @"1";
        model.contactName = @"请填写联系人";
        model.mobile = @"请输入联系人手机号";
        model.address = @"请填写详细地址";
        model.introductorMobile = @"请填写介绍人电话";
        model.introductorName = @"请填写介绍人";
        [listArray addObject:self.model];
    
    MemberModel * dataModel = [[MemberModel alloc]init];
    self.dataModel = dataModel;

    
}
#pragma mark  --- 设置返回的按钮
- (void)setupNavigationItem {
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH-40, 50, 30)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    
    UIBarButtonItem * rightBotton = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(cancleBtnTouchEvent) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBotton;
    
}

#pragma mark ---返回到登录页面
-(void)cancleBtnTouchEvent
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark   界面数据请求
-(void)upDataNetWorking
{
    NSDictionary * parameters = @{@"id":GET_USER_INFO.memberId,//会员id  登录接口返回
                                  };
    [VJDProgressHUD showProgressHUD:@"查询中..."];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetFindRegistervURL parameters:parameters success:^(NSDictionary *responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            [VJDProgressHUD showSuccessHUD:@"获取成功"];
//            [listArray removeAllObjects];//清除数据源
            [self.model setValuesForKeysWithDictionary:responseObject[@"memberView"]];
            [self.dataModel setValuesForKeysWithDictionary:responseObject[@"memberView"]];
            self.tableView.frame =CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT-113);
            [self.tableView reloadData];
            self.regionId = [NSString stringWithFormat:@"%@",self.model.regionId];

            self.myId = [NSString stringWithFormat:@"%@",self.model.categoryIds];
            picDic[@"152"] = self.model.bid;
            picDic[@"153"] = self.model.sid;

        }
        [VJDProgressHUD showTextHUD:responseObject[@"msg"]];

            } failure:^(NSError *error) {
                
        [VJDProgressHUD showErrorHUD:@"失败"];

        }];
    
}
-(void)initNav
{
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 20, 15)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    UIBarButtonItem * rightBotton = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rightBotton;

}
-(void)cancleBtn
{
    if (self.isNav) {
        [self.bgView removeFromSuperview];
        self.isNav = NO;
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)creatUI
{
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-113, SCREEN_WIDTH, 49)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setBackgroundImage:[UIImage imageNamed:@"btnBG"] forState:UIControlStateNormal];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTouch) forControlEvents:UIControlEventTouchUpInside];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,0) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.view addSubview:btn];

    //弹出地址
    __weak typeof(self)weakSelf = self;
    _threePicker = [[RXJDAddressPickerView alloc] init];
    _threePicker.completion = ^(NSString *address, NSString * addressCode){
        weakSelf.regionId = address;
        NSLog(@"%@",address);
    };
    [self.view addSubview:_threePicker];
}

-(void)btnTouch
{
    
    if (!self.introductorNameField.text) {
        self.introductorNameField.text =@"";
    }
    if (!self.introductorMobileField.text) {
        self.introductorMobileField.text = @"";
    }
    
    if (!(self.realNameField.text)||!(self.businessLicenseCodeField.text)||!(self.contactNameField.text)||!(self.mobileField.text )||!(self.intoMainField )||!(self.addressField.text )||!(self.buyField.text)) {
        [VJDProgressHUD showTextHUD:@"星号为必填项"];
        return;
    }
    if ([self.contactNameField.text stringValidateSpaceAndNULL]||[self.realNameField.text stringValidateSpaceAndNULL]||[self.businessLicenseCodeField.text stringValidateSpaceAndNULL]||[self.contactNameField.text stringValidateSpaceAndNULL]||[self.addressField.text  stringValidateSpaceAndNULL]) {
        [VJDProgressHUD showTextHUD:@"星号为必填项"];
        return;
    }
    
    if (!picDic[@"152"]) {
        [VJDProgressHUD showTextHUD:@"请传入营业执照"];
        return;
    }
    if (!picDic[@"153"]){
        [VJDProgressHUD showTextHUD:@"请上传商铺图片"];
        return;
    }
    

    UIButton * btn = [self.view viewWithTag:152];
    
    if ([btn.titleLabel.text isEqualToString:@"上传"]) {
        [VJDProgressHUD showTextHUD:@"请上传营业执照"];
        return;
    }
    
    UIButton * btn2 = [self.view viewWithTag:153];
    if ([btn2.titleLabel.text isEqualToString:@"上传"]) {
        [VJDProgressHUD showTextHUD:@"请上传商铺照片"];
        return;
    }
   
    [VJDProgressHUD showProgressHUD:@"提交中"];
    NSString * ID = [NSString stringWithFormat:@"%@",GET_USER_INFO.memberId];
    NSDictionary * parameters = @{@"id":ID,//会员id  登录接口返回
                                  @"realName":self.realNameField.text,//公司名称
                                  @"businessLicenseCode":self.businessLicenseCodeField.text,//执照编号
                                  @"businessLicense":picDic[@"152"],//营业执照
                                  @"storePicture":picDic[@"153"],//店铺照片
                                  @"taxRegistrationPicture":@"",//税务登记表
                                  @"contactName":self.contactNameField.text,//联系人
                                  @"contactPhone":self.mobileField.text,//联系方式
                                  @"regionId":self.regionId,//self.regionId,//所在省，市，区
                                  @"address":self.addressField.text,//详细地址
                                  @"categoryIds":self.myId,//self.managerange,//经营范围
                                  @"introductorName":self.introductorNameField.text,//介绍人
                                  @"introductorMobile":self.introductorMobileField.text,//介绍人电话
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetRegisterMemberInfoURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            [VJDProgressHUD showTextHUD:@"恭喜您！提交成功！我们将在48小时内进行审核处理；请耐心等待"];
            CheckViewController * check = [[CheckViewController alloc]init];
            check.checkType = @"1";
            [self.navigationController pushViewController:check animated:YES];
        }else{
            [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataArray.count&&listArray.count) {
        return dataArray.count;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    MemberModel * memberModel = listArray[0];
    if (tableView == self.listTableView) {
        static NSString * identifier = @"listCell";
        MemberCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MemberCell" owner:self options:nil]objectAtIndex:1];
        NSDictionary * dic = listArray[indexPath.row];
        cell.listLable.text = dic[@"str"];
        cell.listImageView.image =nil;
        
        //从注册进入，将红色标志隐藏
        if ([self.isForm isEqualToString:@"1"]) {
            cell.redIconButton.hidden = YES;
        }
        
        return cell;

    }else{
    static NSString * identifier = @"ID";
     MemberCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        
//----------------------给钱每个cell 值  value-----------------------------------------------------
        //------------------------------上传图片的两个cell-----------------------------
        if (2==indexPath.row||3==indexPath.row) {
           cell = [[[NSBundle mainBundle]loadNibNamed:@"MemberCell" owner:self options:nil]firstObject];
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
//            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 55, SCREEN_HEIGHT*0.05)];
            btn.tag = 150 + indexPath.row;
            //设置红色标志的tag值
            cell.redIconButton.tag = indexPath.row + TagParam;
            cell.delegate = self;
            
            //营业执照
            if (indexPath.row==2) {
                
                if ([self.isForm isEqualToString:@"1"]) {
                    btn.frame = CGRectMake(SCREEN_WIDTH-60, 10, 55, SCREEN_HEIGHT*0.05);
                }else{
                    //如果通过了，将红色标志隐藏，button的位置靠右
                    if ([memberModel.businessLicenseUrlStatus boolValue] ) {
                        cell.redIconButton.hidden = YES;
                        btn.frame = CGRectMake(SCREEN_WIDTH-60, 10, 55, SCREEN_HEIGHT*0.05);
                    }else{
                        btn.frame = CGRectMake(SCREEN_WIDTH-60 - 40, 10, 55, SCREEN_HEIGHT*0.05);
                    }
                }

                
                if ([@"1" isEqualToString:memberModel.bid]||[@"0" isEqualToString:memberModel.sid]) {
                    [btn setTitle:@"上传" forState:UIControlStateNormal];
                }else{
                    [btn setTitle:@"上传成功" forState:UIControlStateNormal];
                }
            }
            
            //商铺照片
            if (indexPath.row==3) {
                
                if ([self.isForm isEqualToString:@"1"]) {
                    btn.frame = CGRectMake(SCREEN_WIDTH-60, 10, 55, SCREEN_HEIGHT*0.05);
                }else{
                    //如果通过了，将红色标志隐藏，button的位置靠右
                    if ([memberModel.storePictureUrlStatus boolValue] ) {
                        cell.redIconButton.hidden = YES;
                        btn.frame = CGRectMake(SCREEN_WIDTH-60, 10, 55, SCREEN_HEIGHT*0.05);
                    }else{
                        btn.frame = CGRectMake(SCREEN_WIDTH-60 - 40, 10, 55, SCREEN_HEIGHT*0.05);
                    }
                }
                
                
                if ([@"1" isEqualToString:memberModel.sid]||[@"0" isEqualToString:memberModel.sid]) {
                    [btn setTitle:@"上传" forState:UIControlStateNormal];
                }else{
                    [btn setTitle:@"上传成功" forState:UIControlStateNormal];
                }
            }
            btn.backgroundColor = RGBColor(242, 182, 42);
            [cell.contentView addSubview:btn];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn addTarget:self action:@selector(shangchuanBtn:) forControlEvents:UIControlEventTouchUpInside];
            
        //------------------------------输入框的cell-----------------------------
        }else{
             cell = [[[NSBundle mainBundle]loadNibNamed:@"MemberCell" owner:self options:nil]firstObject];
            
            //设置红色标志的tag值
            cell.redIconButton.tag = indexPath.row + TagParam;
            cell.delegate = self;
            
            //公司名称
            if(0==indexPath.row){
              self.realNameField=cell.intoMainField;
            NSString * str = [NSString stringWithFormat:@"%ld",indexPath.row];
            self.realNameField.text =[muDicKeyInfo objectForKey:str];
                cell.intoMainField.text =memberModel.realName;
                cell.redIconButton.hidden = [memberModel.branchNameStatus boolValue];
                

            //执照编号
            }else if(1==indexPath.row){
                cell.intoMainField.text =memberModel.businessLicenseCode;
                cell.redIconButton.hidden = [memberModel.businessLicenseCodeStatus boolValue];
                self.businessLicenseCodeField=cell.intoMainField;
                cell.intoMainField.keyboardType = UIKeyboardTypeDefault;
                 [cell.intoMainField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            }
            
            
            else if(4==indexPath.row){
                cell.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.1);
                cell.hidden = YES;
                cell.redIconButton.hidden = YES;
                
            //联系人姓名
            }else if(5==indexPath.row){
                cell.intoMainField.text =memberModel.contactName;
                cell.redIconButton.hidden = [memberModel.contactNameStatus boolValue];
                self.contactNameField=cell.intoMainField;
                
            }
            
            //联系方式
            else if(6==indexPath.row){
                cell.intoMainField.text =memberModel.mobile;
                cell.redIconButton.hidden = [memberModel.mobileStatus boolValue];
                self.mobileField=cell.intoMainField;
                self.mobileField.textColor = [UIColor grayColor];
                cell.intoMainField.keyboardType = UIKeyboardTypeNumberPad;
            }
            
            //所在地
            else if(7==indexPath.row){
                cell.intoMainField.text =[NSString stringWithFormat:@"%@%@%@",memberModel.provinceName,memberModel.cityName,memberModel.areaName];
                cell.redIconButton.hidden = [memberModel.reginNameStatus boolValue];
                self.intoMainField = cell.intoMainField;
            }
            
            //详细地址
            else if(8==indexPath.row){
                cell.intoMainField.text =memberModel.address;
                cell.redIconButton.hidden = [memberModel.addressStatus boolValue];
                self.addressField=cell.intoMainField;
            }
            
            //经营范围
            else if(9==indexPath.row){
                cell.intoMainField.text =memberModel.categoryName;
                cell.redIconButton.hidden = [memberModel.byCombinationNamesStatus boolValue];
                self.buyField = cell.intoMainField;
            }
            
            //介绍人姓名
            else if(10==indexPath.row){
                cell.intoMainField.text =memberModel.introductorName;
                self.introductorNameField=cell.intoMainField;
                cell.redIconButton.hidden = YES;
            }
            
            //介绍人电话
            else if(11==indexPath.row){
                cell.intoMainField.text =memberModel.introductorMobile;
                cell.intoMainField.keyboardType = UIKeyboardTypeNumberPad;
                self.introductorMobileField=cell.intoMainField;
                cell.redIconButton.hidden = YES;
            }
        }
        
        //------------------------------选择框的cell-----------------------------

    if (7==indexPath.row||9==indexPath.row) {
        cell.intoMainField.enabled = NO;
        
        //向右的箭头
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"youjiantou"]];
        
        //所在地
        if (indexPath.row == 7) {
            
            if ([self.isForm isEqualToString:@"1"]) {
                imageView.frame = CGRectMake(SCREEN_WIDTH - 20, 10, 10, 15);
            }else{
                if ([memberModel.reginNameStatus intValue]  == 1) {
                    imageView.frame = CGRectMake(SCREEN_WIDTH - 20, 10, 10, 15);
                    cell.redIconButton.hidden = YES;
                }else{
                    imageView.frame = CGRectMake(SCREEN_WIDTH-50, 10, 10, 15);
                    cell.redIconButton.hidden = NO;
                }
            }
            
            
        //经营范围
        }else if (indexPath.row == 9) {
            if ([self.isForm isEqualToString:@"1"]) {
                imageView.frame = CGRectMake(SCREEN_WIDTH-20, 10, 10, 15);
            }else{
                if ([memberModel.byCombinationNamesStatus intValue]  == 1) {
                    imageView.frame = CGRectMake(SCREEN_WIDTH-20, 10, 10, 15);
                    cell.redIconButton.hidden = YES;
                }else{
                    imageView.frame = CGRectMake(SCREEN_WIDTH-50, 10, 10, 15);
                    cell.redIconButton.hidden = NO;
                }
            }
        }
        
        imageView.centerY = cell.centerY;
        [cell addSubview:imageView];
        
//----------------------给钱每个cell 设置标题  key------------------------------
        
    }else{
        cell.intoMainField.enabled =YES;
        }
        NSDictionary * dic = dataArray[indexPath.row];
        cell.tableHeadLable.textColor = [UIColor blackColor];
        cell.tableHeadLable.font = [UIFont systemFontOfSize:15];
        cell.tableHeadLable.text = dic[@"str"];
        cell.intoMainField.delegate = self;
        cell.intoMainField.tag =indexPath.row+5;
        
        NSString * count1 = @"*";
        NSMutableAttributedString * attributedString2= [[NSMutableAttributedString alloc]initWithString:dic[@"str"]];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:COLOR_F44336 range:[dic[@"str"] rangeOfString:count1]];
        cell.tableHeadLable.attributedText = attributedString2;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.intoMainField.placeholder =dic[@"Plicehold"];
        if (!(6==indexPath.row)) {
            cell.intoMainField.clearButtonMode = UITextFieldViewModeAlways;
        }else{
            cell.intoMainField.enabled = NO;
        }
        if (indexPath.row==2||indexPath.row==3) {
            cell.intoMainField.enabled = NO;
        }
        
    cell.intoMainField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        //从注册进入，将红色标志隐藏
        if ([self.isForm isEqualToString:@"1"]) {
            cell.redIconButton.hidden = YES;
        }
        
    return cell;

    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberModel * memberModel = listArray[0];
    UITextField * textField = (UITextField*)[self.view viewWithTag:indexPath.row+100];
    switch (indexPath.row) {
        case 0:
            memberModel.realName = textField.text;
            break;
        case 1:
            memberModel.businessLicenseCode = textField.text;
            break;
        case 5:
            memberModel.contactName = textField.text;
            break;
        case 6:
            memberModel.mobile = textField.text;
            break;
        case 7:
            memberModel.provinceName = @"2";
            memberModel.cityName =@"36";
            memberModel.areaName =@"398";
            break;
        case 8:
            memberModel.address = textField.text;
            break;
        case 9:
            memberModel.categoryName = self.managerange;
            break;
        case 10:
            memberModel.introductorName = textField.text;
            break;
        case 11:
            memberModel.introductorMobile = textField.text;
            break;
        default:
            break;
    }
    
    [parmerArr addObject:memberModel];
    
    
    if (7==indexPath.row) {
       //选择地区
        [self chooseArea];
    }
    if (9==indexPath.row) {
        //选择经营范围
        [self chooseScope];
    }
}

//----------------------------------红色图片的点击方法---------------------------------

- (void)memberCellDelegateAction:(UIButton *)btn {
    NSInteger index = btn.tag - TagParam;
    NSString *description = @"";
    
    switch (index) {
        case 0:
            description = self.dataModel.branchNameNote;
            break;
        case 1:
            description = self.dataModel.businessLicenseCodeNote;
            break;
        case 2:
            description = self.dataModel.businessLicenseUrlNote;
            break;
        case 3:
            description = self.dataModel.storePictureUrlNote;
            break;
        case 5:
            description = self.dataModel.contactNameNote;
            break;
        case 6:
            description = self.dataModel.mobileNote;
            break;
        case 7:
            description = self.dataModel.reginNameNote;
            break;
        case 8:
            description = self.dataModel.addressNote;
            break;
        case 9:
            description = self.dataModel.byCombinationNamesNote;
            break;
        default:
            break;
    }
    USPopView *popView = [[USPopView alloc]initWithDescripton:description certenBlock:^{
        
    }];
    [popView show];
}

#pragma mark  上传图片的方法
-(void)shangchuanBtn:(UIButton *)btn
{
    
    if (btn.tag ==152 ) {//上传营业执照
        self.picBtn=btn;
        [self getPicture:btn];
    }else if (btn.tag==153){//上传商铺照片
        self.picBtn = btn;
        [self getPicture:btn];
    }else if (btn.tag == 154){//上传税务登记表
        self.picBtn= btn;
        [self getPicture:btn];
    }else{
        ELog(@"无法上传");
    }
}

#pragma mark 选择吊起相机或相册

- (void)getPicture:(UIButton *)btn
{
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];

    [self.view addSubview:_backgroundView];
    
    UIButton * picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    picBtn.frame = CGRectMake(Fit_Width * 17, Fit_Height * 430-40, SCREEN_WIDTH - Fit_Width * 17 * 2, Fit_Height * 60);
    picBtn.layer.cornerRadius = 1;
    picBtn.clipsToBounds = YES;
    picBtn.backgroundColor = [UIColor whiteColor];
    [picBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [picBtn setTitleColor:RGBColor(242, 182, 42) forState:UIControlStateNormal];
    [picBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:picBtn];
    
    UIButton * takeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takeBtn.frame = CGRectMake(Fit_Width * 17, picBtn.bottom-1 , picBtn.width , Fit_Height * 60);
    takeBtn.layer.cornerRadius = 1;
    takeBtn.clipsToBounds = YES;
    takeBtn.backgroundColor = [UIColor whiteColor];
    [takeBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [takeBtn setTitle:@"从相册选择" forState:UIControlStateNormal];
    [takeBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:takeBtn];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(Fit_Width*17+5, picBtn.bottom, SCREEN_WIDTH-50, 1)];
    lineView.backgroundColor = COLOR_DDDDDD;
    [_backgroundView addSubview:lineView];
    
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(Fit_Width * 17, takeBtn.bottom+10 , takeBtn.width , Fit_Height * 35+10);
    cancleBtn.layer.cornerRadius = 1;
    cancleBtn.clipsToBounds = YES;
    cancleBtn.backgroundColor = [UIColor whiteColor];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:cancleBtn];
    
}
#pragma mark 相机取消的Btn方法
-(void)cancle:(UIButton *)btn
{
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        self.photosVC = vc;
    vc.delegate = self;
    if ([btn.titleLabel.text isEqualToString:@"取消"]) {
        [_backgroundView removeFromSuperview];
    }else if ([btn.titleLabel.text isEqualToString:@"拍照"]){

        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        vc.allowsEditing = YES;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }else if ([btn.titleLabel.text isEqualToString:@"从相册选择"]){
        vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        vc.allowsEditing = YES;
        [self presentViewController:vc animated:YES completion:^{

        }];
    }
    
}
#pragma mark -- Image picker delegate

//图片上传
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];

    [_backgroundView removeFromSuperview];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSLog(@"imageSize %g %g",image.size.width,image.size.height);
    NSDictionary * parameters = @{};
    [VJDProgressHUD showProgressHUD:@"上传中"];
    [SYNetworkingManager upLoadImageRequestWithURLString:GetUploadPicURL parameters:parameters withImageData:imageData success:^(NSDictionary *responseObject) {
        if ([responseObject[@"code"]isEqualToString:@"RS200"]) {
            [VJDProgressHUD showSuccessHUD:@"上传成功"];
            [picArray addObject:responseObject[@"businessLicense"]];
            NSString * str = [NSString stringWithFormat:@"%ld",self.picBtn.tag];
            [self.picBtn setTitle:@"上传成功" forState:UIControlStateNormal];
            [picDic setObject:responseObject[@"businessLicense"] forKey:str];
        }else{
            [VJDProgressHUD showErrorHUD:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self.picBtn setTitle:@"上传" forState:UIControlStateNormal];
        [VJDProgressHUD showErrorHUD:@"上传失败"];
    }];
}
#pragma mark  图片压缩的方法
+ (UIImage *) scaleImage:(UIImage *) image withNewSize:(CGSize) newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)commentTableViewTouchInSide

{
    
}

-(void)chooseScope
{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    self.bgView = bgView;
    [self.view addSubview:bgView];
    
    BuyScoreView * listView = [[BuyScoreView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    self.listView = listView;
    listView.delegate = self;
    [bgView addSubview:listView];
    
    listView.buyScreeningBlcok = ^(NSString *managerange, NSString * myId){
        self.myId = myId;
//        self.managerange = managerange;
        self.buyField.text = managerange;
        
        [muDicKeyInfo setObject:managerange forKey:@"11"];
        self.model.categoryName = managerange;
//        [self.tableView reloadData];
    };
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGPoint point = listView.center;
    point.x -=SCREEN_WIDTH-SCREEN_WIDTH*0.1;
    [listView setCenter:point];
    [UIView commitAnimations];
    self.isNav = YES;
}


#pragma listViewdelegate 的代理方法
-(void)backRootViewController
{
    ELog(@"确定");
    self.isNav = NO;
    [self.bgView removeFromSuperview];
    
    
}
-(void)allThingSelect
{
    ELog(@"取消");
}

-(void)chooseArea
{
  //  [_threePicker showAddress];
    
    VJDRegionView * view = [[VJDRegionView alloc]init];
    [view show];
    VJDWeakSelf;
    view.regionViewBlcok = ^(RegionModel * province,RegionModel * city,RegionModel * area){
        ELog(@"%@",area);
        weakSelf.regionId = [NSString stringWithFormat:@"%ld",area.myId];
        self.intoMainField.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
        [muDicKeyInfo setObject:self.intoMainField.text forKey:@"12"];
    };
}
-(void)cancleBtnTouch
{
    [self.bgView removeFromSuperview];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_listTableView) {
        SCREEN_HEIGHT*0.05;
    }else{
        if (indexPath.row==4) {
            return 0.1;
        }
    }
    return SCREEN_HEIGHT * 0.08;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
  //  return 100;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableView endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    ELog(@"%@",textField.text);
//    self.realNameField.text = textField.text;
    [muDicKeyInfo setObject:textField.text forKey:[NSString stringWithFormat:@"%ld",textField.tag]];
    MemberModel * model = listArray[0];
    if (textField==_realNameField) {
        model.realName = textField.text;
    }else if (textField==_businessLicenseCodeField){
        model.businessLicenseCode = textField.text;
    }else if (textField==_contactNameField){
        model.contactName = textField.text;
    }else if (textField==_mobileField){
        model.mobile = textField.text;
    }else if (textField==_addressField){
        model.address = textField.text;
    }else if (textField==_introductorNameField){
        model.introductorName = textField.text;
    }else if (textField==_introductorMobileField){
        model.introductorMobile = textField.text;
    }
//    [self.tableView reloadData];
}
//正则校验只允许输入字母和数字

-(void)textFieldDidChange :(UITextField *)theTextField{
    ELog( @"text changed: %lu", theTextField.text.length);
    
    NSString * regex = @"^[A-Za-z0-9_]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:theTextField.text];
    if((theTextField.text.length>=2)&&(!isMatch)){
        theTextField.text =[theTextField.text substringToIndex:1];
    }
    if ((!isMatch)&&(theTextField.text.length==1)) {
        theTextField.text = @"";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
