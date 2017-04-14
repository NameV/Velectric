//
//  MemberInfoVC.m
//  Velectric
//
//  Created by hongzhou on 2017/1/5.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "MemberInfoVC.h"
#import "MemberInfoModel.h"
#import "BuyScoreView.h"

@interface MemberInfoVC ()<BuybackRootViewDelegate>

@property (nonatomic,strong)UIView * bgView;
@property (nonatomic,strong)UIView * listView;
@property (nonatomic,strong)UITextField * scopeView;//经营范围
/* 经营范围id */
@property (nonatomic, copy) NSString *scopeID;

/* 右箭头 */
@property (nonatomic, strong) UIImageView *rightIamge;

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
    }];
}

#pragma mark - 创建UI
- (void)creatUI
{
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 6 * 50)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    NSArray * titleArray = @[@"用户名",@"厂商名称",@"所在地区",@"详细地址",@"手机号",@"经营范围"];
    for (int i=0; i<titleArray.count; i++)
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
        label.text = [titleArray objectAtIndex:i];
        label.font = Font_1_F14;
        label.textColor = COLOR_666666;
        label.textAlignment = NSTextAlignmentLeft;
        
        //如果不加星号CGRectMake(10, i*50, SCREEN_WIDTH - 20, 50)
        UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(10, i*50, SCREEN_WIDTH - 20, 50)];
        textField.tag = i+1;
        textField.font = Font_1_F14;
        textField.leftView = label;
        textField.textColor = COLOR_999999;
        textField.enabled = NO;
        textField.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:textField];
        
        //经营范围button
        if (i == 5) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.backgroundColor = [UIColor clearColor];
            button.frame = CGRectMake(40, 0, SCREEN_WIDTH-40, 50);
            [textField addSubview:button];
            self.scopeView = textField;
            textField.textColor = [UIColor blackColor];
            textField.enabled = YES;
            [button addTarget:self action:@selector(chooseScope:) forControlEvents:UIControlEventTouchUpInside];
            textField.text = @"请选择经营范围";
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, 20, 10, 10)];
            imageView.image = [UIImage imageNamed:@"youjiantou"];
            self.rightIamge = imageView;
            [textField addSubview:imageView];
        }
        
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hongxing"]];
//        imageView.frame = CGRectMake(10, 20 + 50*i, 10, 10);
//        [self.view addSubview:imageView];
        
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

#pragma mark - 选择经营范围
-(void)chooseScope:(UIButton *)btn
{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    self.bgView = bgView;
    [self.view addSubview:bgView];
    
    BuyScoreView * listView = [[BuyScoreView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    self.listView = listView;
    listView.delegate = self;
    [bgView addSubview:listView];
    
    VJDWeakSelf;
    listView.buyScreeningBlcok = ^(NSString *managerange, NSString * myId){
        
        if (managerange && managerange.length != 0) {
            weakSelf.scopeID = myId;//经营范围id
            weakSelf.scopeView.text = managerange;
            weakSelf.memberInfoModel.categoryName = managerange;
        }
       
        [weakSelf.bgView removeFromSuperview];
        
    };
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGPoint point = listView.center;
    point.x -=SCREEN_WIDTH-SCREEN_WIDTH*0.1;
    [listView setCenter:point];
    [UIView commitAnimations];
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
    UITextField * scopeTextF = [self.view viewWithTag:6];//经营范围
    
    nameTextF.text = memberInfoModel.contactName;
    if ([nameTextF.text isEmptyString]) {
        nameTextF.text = memberInfoModel.mobile;
    }
    companyTextF.text = memberInfoModel.realName;
    regionTextF.text = [NSString stringWithFormat:@"%@ %@ %@",memberInfoModel.provinceName,memberInfoModel.cityName,memberInfoModel.areaName];
    addressTextF.text = memberInfoModel.address;
    mobileTextF.text = memberInfoModel.mobile;
    scopeTextF.text = memberInfoModel.categoryName;

}

#pragma mark - 保存
-(void)saveInfo
{
    UITextField * addressTextF = [self.view viewWithTag:4];
    if ([addressTextF.text stringValidateSpaceAndNULL]) {
        [VJDProgressHUD showTextHUD:@"请填写详细地址"];
        return;
    }
    if ([self.scopeView.text isEmptyString]) {
        [VJDProgressHUD showTextHUD:@"请选择经营范围"];
        return;
    }
    NSDictionary * parameterDic = @{@"id":_memberInfoModel.Id,
                                    @"realName":_memberInfoModel.realName,
                                    @"contactName":_memberInfoModel.contactName,
                                    @"contactPhone":_memberInfoModel.mobile,
                                    @"regionId":_memberInfoModel.regionId,
                                    @"auditState":@"2",
                                    @"address":addressTextF.text,
                                    @"categoryIds" : self.scopeID ? self.scopeID : @""
                                    };
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGegisterUpdataURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]) {
            [GET_USER_INFO setPerfectStatus:@"1"];
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
