//
//  LoginViewController.m
//  Velectric
//
//  Created by QQ on 2016/11/18.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "LoginViewController.h"
#import "AlertView.h"
#import "CheckViewController.h"
#import "VUpdateManager.h"

@interface LoginViewController ()<AlertViewDelegate,UITextFieldDelegate>
{
    
    int  loginCount;//登录次数
}
@property (nonatomic,assign)loginViewTwo * account;//登录的第二个界面
@property (nonatomic,assign)loginViewTwo * account1;//
@property (nonatomic,assign)loginViewFirst * phoneLogin;
@property(nonatomic, strong)AlertView *alertView;
@property (nonatomic, strong)UIButton * yanzhengmaBtn;
@property (nonatomic, copy)NSString * VerifyCode;//图形验证码
@property (nonatomic, assign) BOOL showVerityCode;//是否显示图形验证码
@property (nonatomic, copy)NSString * auditStatestr;//审核状态
/* 暂不登录，去逛逛 */
@property (nonatomic, strong) UIButton *withoutLoginBtn;
@end

@implementation LoginViewController

- (instancetype)init {
    if (self = [super init]) {
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showWithoutLoginButton:) name:ShowWithouLoginNotification object:nil];
    }
    return self;
}

#pragma mark  初始化提示框
- (AlertView *)alertView{
    if (!_alertView) {
        self.alertView = [[AlertView alloc]initWithLeftTitle:@"去完善" WithRightTitle:@"取消" ContentTitle:@"您的资料尚不完善，请先完善个人资料"];
        _alertView.delegate = self;
    }
    return _alertView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    loginCount = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    self.verifycodesign = 0;
    
    [self showWithoutLoginButton:nil];
}

//是否显示直接去首页的button
- (void)showWithoutLoginButton:(NSNotification *)notification {
    
    VUpdateManager *manager = [VUpdateManager shareManager];
//    NSDictionary *userInfo = notification.userInfo;
    //显示button
    if ([manager.showBtn isEqualToString:@"1"]) {
        [self.view addSubview:self.withoutLoginBtn];
        [self.withoutLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        }];
        self.withoutLoginBtn.hidden = NO;
    }else{
        self.withoutLoginBtn.hidden = YES;
    }
}

#pragma mark segmendController 的创建
- (IBAction)segmendController:(id)sender {

    dispatch_async(dispatch_get_main_queue(), ^{
    switch (self.segmentedController.selectedSegmentIndex) {

        case 0:

            self.phoneLogin.hidden = NO;
            self.account.hidden = YES;
            self.account1.hidden =YES;
            break;
                
        case 1:
            self.phoneLogin.hidden = YES;
            if (_showVerityCode) {
                self.account1.hidden = NO;
            }else{
                self.account.hidden = NO;
            }
            break;
        default:
            break;
        }
    });
}

#pragma mark 创建界面UI
-(void)creatUI
{
    
    loginViewFirst *phoneLogin = [[[NSBundle mainBundle]loadNibNamed:@"loginViewFirst" owner:nil options:nil] lastObject];
    phoneLogin.getVerifyBtn.clipsToBounds = YES;
    phoneLogin.getVerifyBtn.layer.cornerRadius = 2;
    self.phoneLogin = phoneLogin;
    [self.view addSubview:phoneLogin];
    [phoneLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.segmentedController.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [phoneLogin.loginBtn addTarget:self action:@selector(loginBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    self.yanzhengmaBtn = phoneLogin.getVerifyBtn;
    [phoneLogin.getVerifyBtn addTarget:self action:@selector(getVerifyBtntouch) forControlEvents:UIControlEventTouchUpInside];
    phoneLogin.hidden = NO;
    phoneLogin.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneLogin.phoneField.delegate = self;
//    phoneLogin.phoneField.secureTextEntry =YES;
    phoneLogin.verifyField.keyboardType = UIKeyboardTypeNumberPad;
    phoneLogin.verifyField.delegate = self;
    [phoneLogin.phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    [phoneLogin.verifyField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    
    
    loginViewTwo *account = [[[NSBundle mainBundle]loadNibNamed:@"loginViewTwo" owner:nil options:nil] lastObject];
    self.account = account;
    [account.eyeBtn addTarget:self action:@selector(secretextBtn:) forControlEvents:UIControlEventTouchUpInside];
    account.passField.secureTextEntry = YES;
    [self.view addSubview:account];
    [account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.segmentedController.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [account.loginBtn addTarget:self action:@selector(loginBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [account.remeberBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    account.hidden = YES;
    
    loginViewTwo *account1 = [[[NSBundle mainBundle]loadNibNamed:@"loginViewTwo" owner:nil options:nil] firstObject];
    self.account1 = account1;
    self.account1.yanZhengField.delegate = self;
     [account1.yanZhengField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:account1];
    [account1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.segmentedController.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [account1.loginBtn addTarget:self action:@selector(loginBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [account1.yanzhengBtn addTarget:self action:@selector(yanzhengBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [account1.remeberBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    account1.hidden = YES;
    
}
#pragma mark 点击获取验证码的网络请求
-(void)yanzhengBtnTouch
{
    [self tuXingBtnNetWorketing];
}
#pragma mark 密文或者明文显示的点击方法
-(void)secretextBtn:(UIButton *)btn
{
    if (self.account.passField.secureTextEntry){
        self.account.passField.secureTextEntry = NO;
        [self.account.eyeBtn setImage:[UIImage imageNamed:@"kaiyanjing"] forState:UIControlStateNormal];
        
    }else{
        self.account.passField.secureTextEntry = YES;
        [self.account.eyeBtn setImage:[UIImage imageNamed:@"yanjing"] forState:UIControlStateNormal];
    }
    
}
#pragma mark  获取验证码的响应事件
-(void)getVerifyBtntouch
{
    if (self.phoneLogin.phoneField.text.length==11) {
        [self getVerifyNetWorketing];    //获取验证码的网络请求
    }else{
        [VJDProgressHUD showTextHUD:@"请输入正确的手机号"];
        return;
    }
}

#pragma mark  获取验证码网络请求的方法
-(void)getVerifyNetWorketing
{
    NSDictionary * parameters = @{@"loginName":self.phoneLogin.phoneField.text,
                                  @"sign":@"0",
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGetsmsVerifyCodeURL parameters:parameters success:^(NSDictionary *responseObject) {
        [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
        ELog(@"成功");
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:INTERNET_ERROR];
    
    }];
    
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.yanzhengmaBtn.backgroundColor = COLOR_F2B602;
                self.yanzhengmaBtn.enabled =YES;
                [self.yanzhengmaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            self.yanzhengmaBtn.enabled =NO;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *strTime = [NSString stringWithFormat:@"%ds", seconds];
                //设置界面的按钮显示 根据自己需求设置
                self.yanzhengmaBtn.backgroundColor = COLOR_E6AD02;
                [self.yanzhengmaBtn setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


#pragma mark 登录的响应事件

-(void)loginBtnTouch:(UIButton *)btn
{
//    [[KGModal sharedInstance] showWithContentView: self.alertView];
     //一键登录
     if (self.phoneLogin.hidden==NO) {

     if (self.phoneLogin.phoneField.text.length==11&&self.phoneLogin.verifyField.text.length==6) {
         [self loginNetWorketing];    //登录的网络请求
     }else if(!(self.phoneLogin.phoneField.text.length==11)){
     [VJDProgressHUD showTextHUD:@"请输入正确的手机号"];
     return;
     }else if (!(self.phoneLogin.verifyField.text.length==6)){
     [VJDProgressHUD showTextHUD:@"请输入正确的验证码"];
     return;
     }
     }
     
     //账号登录
     if (self.account.hidden==NO) {
     if ((self.account.accountNumberField.text.length||self.account.accountNumberField.text.length==6)&&self.account.passField.text.length==6) {
     [self loginNetWorketingWithLoginName:self.account.accountNumberField.text withLoginPassword:self.account.passField.text withVerifyCode:@""];
     loginCount ++;
     }else if(!(self.account.accountNumberField.text.length)){
     [VJDProgressHUD showTextHUD:@"请输入正确的账号"];
     return;
     }else if (!(self.account.passField.text.length==6)){
     [VJDProgressHUD showTextHUD:@"请输入正确的密码"];
     return;
     }  }
     //账号验证码登录
     if (self.account1.hidden==NO) {
     if (self.account1.accountNumberField.text.length&&self.account1.passField.text.length==6&&self.account1.yanZhengField.text.length==4) {
     
     [self loginNetWorketingWithLoginName:self.account1.accountNumberField.text withLoginPassword:self.account1.passField.text withVerifyCode:self.account1.yanZhengField.text];
     
     }else if (!(self.account1.accountNumberField.text.length==11)){
     [VJDProgressHUD showTextHUD:@"请输入正确的帐号"];
     return;
     }else if (!(self.account1.passField.text.length==6)){
     [VJDProgressHUD showTextHUD:@"请输入正确的密码"];
     return;
     }else if (!(self.account1.yanZhengField.text.length==4)){
     [VJDProgressHUD showTextHUD:@"请输入正确验证码"];
     return;
     }
     }
    
}
#pragma mark  textfield 的长度限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneLogin.phoneField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    if (textField == self.phoneLogin.verifyField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 6) {
            return NO;
        }
    }
    
    if (textField == self.account1.yanZhengField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 4) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark  textfield 的长度限制

-(void)textFieldDidChange :(UITextField *)theTextField{
    ELog( @"text changed: %lu", theTextField.text.length);
    
    NSString * regex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:theTextField.text];
    if((theTextField.text.length>=2)&&(!isMatch)){
        theTextField.text =[theTextField.text substringToIndex:1];
    }
    if ((!isMatch)&&(theTextField.text.length==1)) {

    }
}

#pragma mark   跳转到完善会员页面
-(void)pushMember
{
    memberMeansController * member = [[memberMeansController alloc]init];
    member.isForm = @"1";
    [self.navigationController pushViewController:member animated:YES];
}
#pragma mark   跳转到会员审核页面
-(void)pushCheckStr:(NSString *)str
{
    CheckViewController * check = [[CheckViewController alloc]init];
    check.checkType = str;
    [self.navigationController pushViewController:check animated:YES];
}

#pragma mark   一键登录网络请求的方法
-(void)loginNetWorketing
{
    
    [VJDProgressHUD showProgressHUD:nil];
    
    NSDictionary * parameters = @{@"loginName":self.phoneLogin.phoneField.text,
                                  @"verifyCode":self.phoneLogin.verifyField.text,
                                  @"regSource":@"2",
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetLoginCheckURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
        _auditStatestr = [NSString stringWithFormat:@"%@",responseObject[@"auditState"]];

        if ([@"1" isEqualToString:_auditStatestr]) {
            //[[KGModal sharedInstance] showWithContentView: self.alertView];
            [self pushMember];
        }else if([@"3" isEqualToString:_auditStatestr]){
           
            [self pushCheckStr:@"2"];

        }else if([@"4" isEqualToString:_auditStatestr]){
           
            [self pushCheckStr:@"1"];

        }else{
            [UserDefaults setBool:YES forKey:DEFINE_STRING_LOGIN];
            //切换tabbar
            VelectricTabbarController * tabbar = [[VelectricTabbarController alloc]init];
            self.view.window.rootViewController = tabbar;
            //友盟账号统计
            [MobClick profileSignInWithPUID:self.phoneLogin.phoneField.text provider:@"iOS"];
        }
        //一键登录的时储存用户信息
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        [dic setValue:self.phoneLogin.phoneField.text forKey:@"mobile"];//存手机号
        [GET_USER_INFO setUserInfo:dic];
            [VJDProgressHUD showTextHUD:@"登录成功"];
            
        }else{
            [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
        }
        } failure:^(NSError *error) {
        ELog(@"失败");
            [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

#pragma mark  图形验证码的网络请求
-(void)tuXingBtnNetWorketing
{
    if (!self.phoneLogin.phoneField.text) {
        [VJDProgressHUD showTextHUD:@"请输入手机号"];
        return;
    }
    NSDictionary * parameters = @{@"loginName":self.phoneLogin.phoneField.text };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGetVerifyCodeURL parameters:parameters success:^(NSDictionary *responseObject) {
        ELog(@"成功");
        self.VerifyCode = responseObject[@"VerifyCode"];
        [self.account1.yanzhengBtn setTitle:self.VerifyCode forState:UIControlStateNormal];
        
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:@"验证码获取失败"];
    }];
}

#pragma mark  账号登录的网络请求
-(void)loginNetWorketingWithLoginName:(NSString *)loginName withLoginPassword:(NSString *)loginPassword withVerifyCode:(NSString *)verifyCode
{
//    [[KGModal sharedInstance] showWithContentView: self.alertView];//测试时使用
    NSNumber * num = [NSNumber numberWithInt:self.verifycodesign];
    [VJDProgressHUD showProgressHUD:@"加载中..."];
    NSDictionary * parameters = @{@"loginName":loginName,
                                  @"loginPassword":loginPassword,
                                  @"verifyCode":verifyCode,
                                  @"verifycodesign":num
                                  };
    
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetLoginCheckURL parameters:parameters success:^(NSDictionary *responseObject) {
        [VJDProgressHUD  showTextHUD:responseObject[@"msg"]];
        ELog(@"成功");
        //账号登录的时储存用户信息
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        [dic setValue:loginName forKey:@"mobile"];//存手机号
        [GET_USER_INFO setUserInfo:dic];
        if ([@"RS200" isEqualToString:responseObject[@"code"]]) {
        _auditStatestr = [NSString stringWithFormat:@"%@",responseObject[@"auditState"]];
//            _auditStatestr = @"1";//测试时使用
        if ([@"1" isEqualToString:_auditStatestr]) {
           // [[KGModal sharedInstance] showWithContentView: self.alertView];
            [self pushMember];
            
        }else if([@"3" isEqualToString:_auditStatestr]){
            
            [self pushCheckStr:@"2"];
            
        }else if([@"4" isEqualToString:_auditStatestr]){
           
            [self pushCheckStr:@"1"];
            
        }else{
            [UserDefaults setBool:YES forKey:DEFINE_STRING_LOGIN];
            //切换tabbar
            VelectricTabbarController * tabbar = [[VelectricTabbarController alloc]init];
            self.view.window.rootViewController = tabbar;
            //友盟账号统计
            [MobClick profileSignInWithPUID:self.phoneLogin.phoneField.text provider:@"iOS"];
        }
}
        _showVerityCode = responseObject[@"showVerityCode"];
        if(_showVerityCode){
            [self tuXingBtnNetWorketing];
            NSString * str =@"1";
            int numb = [str intValue];
            self.verifycodesign = numb;
            self.account1.hidden = NO;
            self.account.hidden = YES;
            self.account1.accountNumberField.text = self.account.accountNumberField.text;
            self.account1.passField.text = self.account.passField.text;
            return ;
        }else{
            NSString * str =@"0";
            int numb = [str intValue];
            self.verifycodesign = numb;
            self.account1.hidden = YES;
            self.account.hidden = NO;
        }
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];
    }];
}

#pragma mark AlertViewDelegate 完善的方法
- (void)okBtnAction{
    //点击完善的动作
    memberMeansController * member = [[memberMeansController alloc]init];
    if ([_auditStatestr isEqualToString:@"1"]||[_auditStatestr isEqualToString:@"3"]) {
        [self.navigationController pushViewController:member animated:YES];
    }else{
            }
        [[KGModal sharedInstance] hide];

}

#pragma mark 提示框的响应事件
- (void)cancleBtnAction{
    //点击取消的动作
    ELog(@"取消");
    //友盟账号统计
    [MobClick profileSignInWithPUID:self.phoneLogin.phoneField.text provider:@"iOS"];
    
    VelectricTabbarController * tabbar = [[VelectricTabbarController alloc]init];
    self.view.window.rootViewController = tabbar;
    [[KGModal sharedInstance] hide];
    
}
#pragma mark 进入忘记密码的界面
-(void)getCode
{
    ForgetPassController * forget = [[ForgetPassController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - withoutLoginBtnAction

//暂不登录，去逛逛，进入主页
- (void)withoutLoginBtnAction:(UIButton *)btn {
    //账号登录的时储存用户信息
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:TestLoginName forKey:@"loginName"];//存手机号
    [GET_USER_INFO setUserInfo:dic];
    [UserDefaults setBool:YES forKey:DEFINE_STRING_LOGIN];
    //切换tabbar
    VelectricTabbarController * tabbar = [[VelectricTabbarController alloc]init];
    self.view.window.rootViewController = tabbar;
    //友盟账号统计
    [MobClick profileSignInWithPUID:self.phoneLogin.phoneField.text provider:@"iOS"];
}

#pragma mark - getter

-(UIButton *)withoutLoginBtn {
    if (!_withoutLoginBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"暂不登录，去逛逛" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:V_GRAY_COLOR forState:UIControlStateNormal];
        [button addTarget:self action:@selector(withoutLoginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _withoutLoginBtn = button;
    }
    return _withoutLoginBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [MobClick beginLogPageView:@"登录页面"];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:ShowWithouLoginNotification object:nil];
}

@end
