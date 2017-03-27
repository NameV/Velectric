//
//  VPersonBindCardVC.m
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VPersonBindCardVC.h"
#import "VPersonBindCardView.h"
#import "VPickerView.h"
#import "USPopView.h"
#import "MMAlertView.h"

@interface VPersonBindCardVC ()<UITextFieldDelegate>{
    BindType _bindtype;
}
@property (nonatomic, strong) UIScrollView *scrollView;             //背景View
@property (nonatomic, strong) VPersonBindCardView *bindView;        //mainView
@property (nonatomic, strong) UIButton *bindButton;                 //绑卡button


@property (nonatomic, strong) NSArray *bankCardTypeArray;               //银行卡名称数组
@property (nonatomic, copy) NSString *bankCardTypeString;               //银行卡string

@property (nonatomic, strong) NSArray *openBankArray;               //开户行
@property (nonatomic, strong) NSDictionary *openBankDic;            //开户行Dic
@property (nonatomic, copy) NSString *openBankString;               //开户行string

@property (nonatomic, strong) NSArray *idTypeArray;                 //卡片类型
@property (nonatomic, copy) NSString *idTypeString;                 //卡类型string

@property (nonatomic, copy) NSString *nameString;                   //姓名string
@property (nonatomic, copy) NSString *idCardNumString;              //身份证号string
@property (nonatomic, copy) NSString *bankNumString;                //银行卡号string
@property (nonatomic, copy) NSString *phoneNumString;               //手机号string

@end

@implementation VPersonBindCardVC

- (instancetype)initWithType:(BindType)bindType {
    if (self = [super init]) {
        _bindtype = bindType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfig];
    [self showBindCardRequest];//获取银行列表
}

#pragma mark ---------------------------------- config ----------------------------------

- (void)baseConfig {
    
    self.nameString = @"";
    self.idTypeString = @"";
    self.idCardNumString = @"";
    self.openBankString = @"";
    self.bankNumString = @"";
    self.phoneNumString = @"";
    
    self.view.backgroundColor = V_BACKGROUND_COLOR;
    [self.scrollView addSubview:self.bindView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bindButton];
    
    
    switch (_bindtype) {
        case BindTypePerson:
            self.bindView.nameView.label.text = @"姓名";
            break;
        case BindTypeLittle:
            self.bindView.nameView.label.text = @"姓名/企业名称";
            break;
        default:
            break;
    }
    [self.bindView.idCardTypeView addTarget:self action:@selector(selectCardTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bindView.openBankView addTarget:self action:@selector(openBankAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bindButton addTarget:self action:@selector(bindButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bindView.explainBtn addTarget:self action:@selector(explainBtn:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark ---------------------------------- https ----------------------------------

//获取支持银行 卡片类型接口
- (void)showBindCardRequest {
    NSDictionary *paramDic = @{
                               @"loginName" :   GET_USER_INFO.loginName
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:ShowBindCardURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [VJDProgressHUD showSuccessHUD:nil];
                                           //银行列表
                                           if ([[responseObject allKeys] containsObject:@"bankMap"]) {
                                               NSMutableArray *openBankMutArray = [NSMutableArray array];
                                               self.openBankDic = responseObject[@"bankMap"];
                                               for (NSString *key in self.openBankDic) {
                                                   [openBankMutArray addObject:self.openBankDic[key]];
                                               }
                                               self.openBankArray = [openBankMutArray copy];
                                           }
                                           //卡片类型列表
                                           if ([[responseObject allKeys] containsObject:@"documentTypeMap"]) {
                                               NSMutableArray *idTypeMutArray = [NSMutableArray array];
                                               NSDictionary *idTypeDic = responseObject[@"documentTypeMap"];
                                               for (NSString *key in idTypeDic) {
                                                   [idTypeMutArray addObject:idTypeDic[key]];
                                               }
                                               self.idTypeArray = idTypeMutArray;
                                           }
                                           //手机号
                                           if ([[responseObject allKeys] containsObject:@"mobile"]) {
                                               self.phoneNumString = responseObject[@"mobile"];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//短信方式绑卡接口
- (void)bindCardByMessageRequest {
    
    NSDictionary *paramDic = @{
                               @"loginName" :   GET_USER_INFO.loginName,
                               @"custName"  :   self.nameString ?self.nameString : @"",
                               @"idType"    :   self.idTypeString ? self.idTypeString : @"",
                               @"idCode"    :   self.idCardNumString ? self.idCardNumString : @"",//TODO
                               @"bankID"    :   [self getBankId] ? [self getBankId] : @"",
                               @"acctId"    :   self.bankNumString ? self.bankNumString : @"",
                               @"mobilePhone"   :   self.phoneNumString ? self.phoneNumString : @""
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:BindCardByCaptchaValidateURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               [self showMessageView];//弹出短信界面
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//小额鉴权方式绑卡接口
- (void)bindCardByLittleRequest {
    NSDictionary *paramDic = @{
                               @"loginName" :   GET_USER_INFO.loginName,
                               @"custName"  :   self.nameString ?self.nameString : @"",
                               @"idType"    :   self.idTypeString ? self.idTypeString : @"",
                               @"idCode"    :   self.idCardNumString ? self.idCardNumString : @"",//TODO
                               @"bankID"    :   [self getBankId] ? [self getBankId] : @"",
                               @"acctId"    :   self.bankNumString ? self.bankNumString : @"",
                               @"mobilePhone"   :   self.phoneNumString ? self.phoneNumString : @""
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:BindCardByMoneyValidateURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               [self showMessageView];//弹出短信界面
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//短信方式发送验证码接口
- (void)sendMeesageByMessageRequest:(NSString *)message {
    NSDictionary *paramDic = @{
                               @"loginName" :   GET_USER_INFO.loginName,
                               @"captcha"  :   message ? message : @""
                               };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:SendBindCardCaptchaURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//小额鉴权方式发送验证码接口
- (void)sendMeesageByLittleRequest:(NSString *)message {
    NSDictionary *paramDic = @{
                               @"loginName" :   GET_USER_INFO.loginName,
                               @"captcha"  :   message ? message : @""
                               };
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:SendBindCardMoneyURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//获取银行ID
- (NSNumber *)getBankId {
    NSNumber *myKey ;
    for (NSString *key in self.openBankDic) {
        if ([self.openBankDic[key] isEqualToString:self.openBankString]) {
            myKey = [[NSNumber alloc]initWithInt:[key intValue]];
        }
    }
    return myKey;
}

#pragma mark ---------------------------------- action ----------------------------------

//选择卡片类型
- (void)selectCardTypeAction:(UIButton *)btn {
    
    [self resignMyFirstResponder];
    VPickerView *pickerView = [[VPickerView alloc]initWithDataSource:self.idTypeArray
                                                    withSelectedItem:0
                                                   withSelectedBlock:^(id  _Nonnull item) {
                                                       self.bindView.idCardTypeView.valueLabel.text = item;
                                                       self.idTypeString = item;
    }];
    [pickerView show];
}

//选择开户银行
- (void)openBankAction:(UIButton *)btn {
    
    [self resignMyFirstResponder];
    VPickerView *pickerView = [[VPickerView alloc]initWithDataSource:self.openBankArray
                                                    withSelectedItem:0
                                                   withSelectedBlock:^(id  _Nonnull item) {
                                                       self.bindView.openBankView.valueLabel.text = (NSString *)item;
                                                       self.openBankString = (NSString *)item ;
    }];
    [pickerView show];
}

//同意绑定
- (void)bindButtonAction:(UIButton *)btn {
    
    //如果信息不全，直接返回
    BOOL complete = [self judgeCompleteness];
    if (!complete) {
        return ;
    }
    
    switch (_bindtype) {
        case BindTypePerson:
        {
            [self bindCardByMessageRequest];//短信方式绑卡
        }
            break;
        case BindTypeLittle:
        {
            [self bindCardByLittleRequest];//小额鉴权方式绑卡
        }
            break;
            
        default:
            break;
    }
    [self showMessageView];
}

//判断信息是否完全。
- (BOOL)judgeCompleteness {
    
    //判断名称
    switch (_bindtype) {
        case BindTypePerson:
        {
            if ([self.nameString isEmptyString]) {
                [VJDProgressHUD showTextHUD:@"请输入姓名"];
                return NO;
            }
        }
            break;
        case BindTypeLittle:
        {
            if ([self.nameString isEmptyString]) {
                [VJDProgressHUD showTextHUD:@"请输入姓名/企业名称"];
                return NO;
            }
        }
            break;
        default:
            break;
    }
    
    //判断证件类型
    if ([self.idTypeString isEmptyString]) {
        [VJDProgressHUD showTextHUD:@"请选择证件类型"];
        return NO;
    }
    
    //判断证件号码
    if ([self.idCardNumString isEmptyString]) {
        [VJDProgressHUD showTextHUD:@"请输入证件号码"];
        return NO;
    }
    
    //判断开户银行
    if ([self.openBankString isEmptyString]) {
        [VJDProgressHUD showTextHUD:@"请选择开户银行"];
        return NO;
    }
    
    //判断储蓄卡号
    if ([self.bankNumString isEmptyString]) {
        [VJDProgressHUD showTextHUD:@"请输入储蓄卡号"];
        return NO;
    }
    
    //判断证件类型
    if ([self.phoneNumString isEmptyString]) {
        [VJDProgressHUD showTextHUD:@"请输入手机号"];
        return NO;
    }
    
    
    return YES;
}

//短信输入框
- (void)showMessageView {
    NSString *title ;
    MMAlertView *alertView ;
    switch (_bindtype) {
        case BindTypePerson:{//短信方式
            title = @"请输入短信";
            alertView = [[MMAlertView alloc]initWithInputTitle:title detail:@"" placeholder:@"" handler:^(NSString *text) {
                if ([text isEqualToString:@""] || !text.length || [text isEqual:[NSNull null]]) {
                }else{
                    [self sendMeesageByMessageRequest:text];
                }
            }];
        }
            break;
        case BindTypeLittle:{//小额鉴权
            title = @"请输入金额";
            alertView = [[MMAlertView alloc]initWithInputTitle:title detail:@"" placeholder:@"" handler:^(NSString *text) {
                if ([text isEqualToString:@""] || !text.length || [text isEqual:[NSNull null]]) {
                }else{
                    [self sendMeesageByLittleRequest:text];
                }
            }];
        }
            break;
            
        default:
            break;
    }
//    alertView.attachedView = self.view;
    [alertView show];
}

//持卡人说明
- (void)explainBtn:(UIButton *)btn {
    USPopView *popView = [[USPopView alloc]initWithIcon:NO title:@"持卡人说明" descripton:@"为了你的额账户资金安全，只能绑定持卡人本人的银行卡。\n获取更多帮助，请致电V机电客服\n0755-86010333" buttonTitle:@"知道了" certenBlock:^{
        
    }];
    [popView show];
}

//收起键盘
- (void)resignMyFirstResponder {
    [self.bindView.nameView.textField resignFirstResponder];
    [self.bindView.idCardNumView.textField resignFirstResponder];
    [self.bindView.cardNumView.textField resignFirstResponder];
    [self.bindView.nameView.textField resignFirstResponder];
}

#pragma mark ---------------------------------- textfield delegate ----------------------------------

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger wordLenght = [textField.text length] + [string length] - range.length;
    if (textField == self.bindView.nameView.textField) {
        if (wordLenght > 15) {
            return NO;
        }
    }else if (textField == self.bindView.cardNumView.textField) {
        if (wordLenght > 20) {
            return NO;
        }
    }else if (textField == self.bindView.phoneNumView.textField) {
        if (wordLenght > 11) {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.bindView.nameView.textField) {
        self.nameString = textField.text;
    }else if (textField == self.bindView.idCardNumView.textField){
        self.idCardNumString = textField.text;
    }else if (textField == self.bindView.cardNumView.textField) {
        self.bankNumString = textField.text;
    }else if (textField == self.bindView.phoneNumView.textField) {
        self.phoneNumString = textField.text;
    }
}

#pragma mark ---------------------------------- getter ----------------------------------

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 50 - 64 - 50)];
        _scrollView.backgroundColor = V_BACKGROUND_COLOR;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        /* 50*6：上面cell高度
         15:说明距离上面手机号cell的高度
         22：正文距离标题的高度
         15：标题的高度
         15:距离底部的距离
         */
        CGFloat contentH = [self.bindView.warningContentLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)
                                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                                                context:nil].size.height;
        CGFloat height = 50 * 6 + 20 + 22 + 15 + contentH + 15;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, height);
    }
    return _scrollView;
}

- (VPersonBindCardView *)bindView {
    if (!_bindView) {
        _bindView = [[VPersonBindCardView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
        _bindView.userInteractionEnabled = YES;
        _bindView.nameView.textField.delegate = self;
        _bindView.cardNumView.textField.delegate = self;
        _bindView.phoneNumView.textField.delegate = self;
        _bindView.idCardNumView.textField.delegate = self;
    }
    return _bindView;
}

- (UIButton *)bindButton {
    if (!_bindButton) {
        _bindButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _bindButton.frame = CGRectMake(0, SCREEN_HEIGHT-50-50-64, SCREEN_WIDTH, 50);
        [_bindButton setBackgroundColor:[UIColor ylColorWithHexString:@"#f2b602"]];
        [_bindButton setTitle:@"同意绑定" forState:UIControlStateNormal];
        [_bindButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _bindButton;
}

- (NSArray *)bankCardTypeArray {
    if (!_bankCardTypeArray) {
        _bankCardTypeArray = @[@"储蓄卡",@"信用卡"];
    }
    return _bankCardTypeArray;
}

- (NSArray *)openBankArray {
    if (!_openBankArray) {
        _openBankArray = [NSArray array];
    }
    return _openBankArray;
}

- (NSDictionary *)openBankDic {
    if (!_openBankDic) {
        _openBankDic = [NSDictionary dictionary];
    }
    return _openBankDic;
}

- (NSArray *)idTypeArray {
    if (!_idTypeArray) {
        _idTypeArray =[NSArray array];
    }
    return _idTypeArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
