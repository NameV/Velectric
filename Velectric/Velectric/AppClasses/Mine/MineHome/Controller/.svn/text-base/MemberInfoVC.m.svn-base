//
//  MemberInfoVC.m
//  Velectric
//
//  Created by hongzhou on 2017/1/5.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "MemberInfoVC.h"
#import "MemberInfoModel.h"


@interface MemberInfoVC ()

@end

@implementation MemberInfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"会员资料";
    
    //创建UI
    [self creatUI];
    if (_enterType == MemberInfoVC_Home) {
        [self requestFindRegister];
    }
}

#pragma mark - 请求数据
-(void)requestFindRegister
{
    NSDictionary * parameterDic = @{@"id":GET_USER_INFO.memberId,};
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetFindRegistervURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]) {
            NSDictionary * memberView = [responseObject objectForKey:@"memberView"];
            MemberInfoModel * model = [[MemberInfoModel alloc]init];
            [model setValuesForKeysWithDictionary:memberView];
            weakSelf.memberInfoModel = model;
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:error.domain];
    }];
}

#pragma mark - 创建UI
- (void)creatUI
{
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5 * 50)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    NSArray * titleArray = @[@"用户名",@"厂商名称",@"所在地区",@"详细地址",@"手机号",];
    for (int i=0; i<titleArray.count; i++)
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
        label.text = [titleArray objectAtIndex:i];
        label.font = Font_1_F14;
        label.textColor = COLOR_666666;
        label.textAlignment = NSTextAlignmentLeft;
        
        UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(10, i*50, SCREEN_WIDTH - 20, 50)];
        textField.tag = i+1;
        textField.font = Font_1_F14;
        textField.leftView = label;
        textField.textColor = COLOR_999999;
        textField.enabled = NO;
        textField.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:textField];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 49.5 + i*50, SCREEN_WIDTH - 20, 0.5)];
        lineView.backgroundColor = COLOR_DDDDDD;
        [self.view addSubview:lineView];
        if (i==3) {
            textField.textColor = COLOR_333333;
            textField.enabled = YES;
        }
        if (i==4) {
            lineView.frame = CGRectMake(0, 49.5 + i*50, SCREEN_WIDTH, 0.5);
        }
    }
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - 50, SCREEN_WIDTH, 50);
    saveBtn.backgroundColor = COLOR_F2B602;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

#pragma mark - model 赋值
-(void)setMemberInfoModel:(MemberInfoModel *)memberInfoModel
{
    _memberInfoModel = memberInfoModel;
    
    UITextField * nameTextF = [self.view viewWithTag:1];
    UITextField * companyTextF = [self.view viewWithTag:2];
    UITextField * regionTextF = [self.view viewWithTag:3];
    UITextField * addressTextF = [self.view viewWithTag:4];
    UITextField * mobileTextF = [self.view viewWithTag:5];
    
    nameTextF.text = memberInfoModel.contactName;
    companyTextF.text = memberInfoModel.realName;
    regionTextF.text = [NSString stringWithFormat:@"%@ %@ %@",memberInfoModel.provinceName,memberInfoModel.cityName,memberInfoModel.areaName];
    addressTextF.text = memberInfoModel.address;
    mobileTextF.text = memberInfoModel.mobile;
}

#pragma mark - 保存
-(void)saveInfo
{
    UITextField * addressTextF = [self.view viewWithTag:4];
    if ([addressTextF.text stringValidateSpaceAndNULL]) {
        [VJDProgressHUD showTextHUD:addressTextF.placeholder];
        return;
    }
    NSDictionary * parameterDic = @{@"id":_memberInfoModel.Id,
                                    @"realName":_memberInfoModel.realName,
                                    @"contactName":_memberInfoModel.contactName,
                                    @"contactPhone":_memberInfoModel.mobile,
                                    @"regionId":_memberInfoModel.regionId,
                                    @"auditState":@"2",
                                    @"address":addressTextF.text,
                                    };
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGegisterUpdataURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]) {
            [VJDProgressHUD showSuccessHUD:[responseObject objectForKey:@"msg"]];
            weakSelf.memberInfoModel.address = addressTextF.text;
            if (weakSelf.changeMemberInfoBlock) {
                weakSelf.changeMemberInfoBlock(weakSelf.memberInfoModel);
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [VJDProgressHUD showTextHUD:@"会员信息修改失败"];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
