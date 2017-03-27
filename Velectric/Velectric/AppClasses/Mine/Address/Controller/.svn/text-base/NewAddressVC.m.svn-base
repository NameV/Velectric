//
//  NewAddressVC.m
//  Tourph
//
//  Created by yanghongzhou on 16/2/16.
//  Copyright © 2016年 yanghongzhou. All rights reserved.
//

#import "NewAddressVC.h"
#import "AddressModel.h"            //地址model
#import "VJDRegionView.h"
#import "RegionModel.h"
#import "RegexKitLite.h"

@interface NewAddressVC ()<UITextFieldDelegate>

@property (strong,nonatomic) UIButton * addBtn;

//地址详情 model
@property (strong,nonatomic) AddressModel * detailModel;
//选中的地区 model
@property (strong,nonatomic) RegionModel * areaModel;

@end

@implementation NewAddressVC

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

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"新增地址";
    
    //创建UI
    [self creatUI];
}

#pragma mark - 创建UI
-(void)creatUI
{
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4 * 50)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    NSArray * titleArray = @[@"收货人",@"联系方式",@"所在地区",@"详细地址",];
    NSArray * placeholderArray = @[@"填输入收货人姓名",@"请输入联系方式",@"请选择地区",@"请输入详细地址",];
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
        textField.placeholder = [placeholderArray objectAtIndex:i];
        textField.leftView = label;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.delegate = self;
        [self.view addSubview:textField];
        if (i==1) {
            //手机号 显示数字键盘
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 49.5 + i*50, SCREEN_WIDTH - 20, 0.5)];
        lineView.backgroundColor = COLOR_DDDDDD;
        [self.view addSubview:lineView];
        
        if (i==2){
            textField.enabled = NO;
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(textField.left + 80, textField.top, textField.width - 80, textField.height);
            [button addTarget:self action:@selector(chooseRegion) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20, textField.top + 20, 10, 10)];
            imageView.image = [UIImage imageNamed:@"youjiantou"];
            [self.view addSubview:imageView];
        }
        if (i==3) {
            lineView.frame = CGRectMake(0, 49.5 + i*50, SCREEN_WIDTH, 0.5);
        }
    }
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - 50, SCREEN_WIDTH, 50);
    _addBtn.backgroundColor = COLOR_F2B602;
    [_addBtn setTitle:@"保存并使用" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 2) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length>=11) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - 请求地址信息
-(void)requestAddressData
{
    _detailModel = [[AddressModel alloc]init];
    NSDictionary * parameterDic = @{@"id":_addressId,
                                    @"memberId": [[VJDUserManager sharedManager] getId],};
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetFindAddressByIdURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]) {
            NSDictionary * address = [responseObject objectForKey:@"address"];
            [weakSelf.detailModel setValuesForKeysWithDictionary:address];
            
            UITextField * nameTextF = [weakSelf.view viewWithTag:1];
            UITextField * mobileTextF = [weakSelf.view viewWithTag:2];
            UITextField * regionTextF = [weakSelf.view viewWithTag:3];
            UITextField * addressTextF = [weakSelf.view viewWithTag:4];
            
            nameTextF.text = weakSelf.detailModel.recipient;
            mobileTextF.text = weakSelf.detailModel.mobile;
            regionTextF.text = weakSelf.detailModel.regionName;
            addressTextF.text = weakSelf.detailModel.address;
            
            weakSelf.navTitle = @"编辑收货地址";
            [weakSelf.addBtn setTitle:@"确定" forState:UIControlStateNormal];
            [weakSelf.addBtn removeTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
            [weakSelf.addBtn addTarget:self action:@selector(updateAddress) forControlEvents:UIControlEventTouchUpInside];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}


#pragma mark - 选择地区
-(void)chooseRegion
{
    VJDRegionView * view = [[VJDRegionView alloc]init];
    [view show];
    VJDWeakSelf;
    view.regionViewBlcok = ^(RegionModel * province,RegionModel * city,RegionModel * area){
        UITextField * regionTextF = [self.view viewWithTag:3];
        regionTextF.text = [NSString stringWithFormat:@"%@ %@ %@",province.name,city.name,area.name];
        weakSelf.areaModel = area;
    };
}

#pragma mark - 参数验证
-(BOOL)doParamsValidate
{
    UITextField * nameTextF = [self.view viewWithTag:1];
    UITextField * mobileTextF = [self.view viewWithTag:2];
    UITextField * regionTextF = [self.view viewWithTag:3];
    UITextField * addressTextF = [self.view viewWithTag:4];

    if ([nameTextF.text stringValidateSpaceAndNULL]) {
        [VJDProgressHUD showTextHUD:nameTextF.placeholder];
        return NO;
    }
    if ([mobileTextF.text stringValidateSpaceAndNULL]) {
        [VJDProgressHUD showTextHUD:mobileTextF.placeholder];
        return NO;
    }else{
        NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|14[57]|17[0678])\\d{8}$";
        if (![mobileTextF.text isMatchedByRegex:phoneRegex])
        {
            [VJDProgressHUD showTextHUD:@"输入手机号码格式不对"];
            return NO;
        }
    }
    if ([regionTextF.text stringValidateSpaceAndNULL]) {
        [VJDProgressHUD showTextHUD:regionTextF.placeholder];
        return NO;
    }
    if ([addressTextF.text stringValidateSpaceAndNULL]) {
        [VJDProgressHUD showTextHUD:addressTextF.placeholder];
        return NO;
    }
    return YES;
}

#pragma mark - 添加地址
-(void)saveAddress
{
    if ([self doParamsValidate]) {
        
        UITextField * nameTextF = [self.view viewWithTag:1];
        UITextField * mobileTextF = [self.view viewWithTag:2];
        UITextField * addressTextF = [self.view viewWithTag:4];
        
        NSDictionary * parameterDic = @{@"memberId": [[VJDUserManager sharedManager] getId],
                                        @"mobile":mobileTextF.text,
                                        @"address":addressTextF.text,
                                        @"recipient":nameTextF.text,
                                        @"regionId":[NSNumber numberWithInteger:_areaModel.myId],
                                        };
        [VJDProgressHUD showProgressHUD:nil];
        [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetSaveAddressURL parameters:parameterDic success:^(NSDictionary *responseObject) {
            NSString * code = [responseObject objectForKey:@"code"];
            if ([code isEqualToString:@"RS200"]) {
                [VJDProgressHUD showSuccessHUD:@"新建地址成功"];
                if (_insertAddressBlcok) {
                    _insertAddressBlcok();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [VJDProgressHUD showErrorHUD:nil];
            }
        } failure:^(NSError *error) {
            [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
        }];
    }
}

#pragma mark - 修改地址
-(void)updateAddress
{
    if ([self doParamsValidate]) {
        
        UITextField * nameTextF = [self.view viewWithTag:1];
        UITextField * mobileTextF = [self.view viewWithTag:2];
        UITextField * addressTextF = [self.view viewWithTag:4];
        NSNumber * Id = [NSNumber numberWithInteger:_detailModel.regionId];
        if (_areaModel) {
            Id = [NSNumber numberWithInteger:_areaModel.myId];
        }
        NSDictionary * parameterDic = @{@"id":_detailModel.myId,
                                        @"memberId": [[VJDUserManager sharedManager] getId],
                                        @"mobile":mobileTextF.text,
                                        @"address":addressTextF.text,
                                        @"recipient":nameTextF.text,
                                        @"regionId":Id,
                                        };
        [VJDProgressHUD showProgressHUD:nil];
        [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetUpdateAddressURL parameters:parameterDic success:^(NSDictionary *responseObject) {
            NSString * code = [responseObject objectForKey:@"code"];
            if ([code isEqualToString:@"RS200"]) {
                [VJDProgressHUD showSuccessHUD:@"编辑地址成功"];
                if (_insertAddressBlcok) {
                    _insertAddressBlcok();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [VJDProgressHUD showErrorHUD:nil];
            }
        } failure:^(NSError *error) {
            [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
        }];
    }
}

@end
