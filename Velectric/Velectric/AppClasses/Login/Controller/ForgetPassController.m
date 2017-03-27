//
//  ForgetPassController.m
//  Velectric
//
//  Created by QQ on 2016/11/22.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "ForgetPassController.h"
#import "ForgetPassCell.h"

@interface ForgetPassController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray * dataArray;
    
}
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)UIButton * yanzhengmaBtn;

@end

@implementation ForgetPassController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [MobClick beginLogPageView:@"忘记密码"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    self.title = @"忘记密码";
    dataArray = [NSArray array];
    dataArray =@[@{@"str":@"请输入用户名",@"headImage":@"UserPic"},@{@"str":@"请输入手机号",@"headImage":@"shouji"},@{@"str":@"输入验证码",@"headImage":@"yanzhengma"},@{@"str":@"设置新密码",@"headImage":@"mima"},@{@"str":@"确认新密码",@"headImage":@"querenmima"}];
    [self setupNavigationItem];
    
}
#pragma 创建界面UI
-(void)creatUI
{
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-114, SCREEN_WIDTH, 60)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btnBG"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,0.4*SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
}
#pragma mark 忘记密码的网络请求
-(void)btnTouch
{
    [self forgetPassWorketing];
}

#pragma  marke 忘记密码的接口方法
-(void)forgetPassWorketing
{
    UITextField * loginNameField = (UITextField *)[self.view viewWithTag:10];
    UITextField * verifyCodeField = (UITextField *)[self.view viewWithTag:12];
    UITextField * mobileField = (UITextField *)[self.view viewWithTag:11];
    UITextField * loginPasswordField = (UITextField *)[self.view viewWithTag:13];
    UITextField * loginPasswordField1 = (UITextField *)[self.view viewWithTag:14];
    if (loginPasswordField1.text.length<6) {
        [VJDProgressHUD showTextHUD:@"请保持密码长度大于6位"];
        return;
    }
    if (!([loginPasswordField.text isEqualToString:loginPasswordField1.text])) {
        [VJDProgressHUD showTextHUD:@"请确认密码相同"];
        return;
    }
    
    if ((loginNameField.text.length==0)||(verifyCodeField.text.length==0)||((mobileField.text.length)==0)||(loginPasswordField.text.length==0)) {
        [VJDProgressHUD showTextHUD:@"请输入正确的信息"];
        return;
    }
    [VJDProgressHUD showProgressHUD:nil];
    NSDictionary * parameters = @{@"loginName":loginNameField.text,
                                  @"verifyCode":verifyCodeField.text,
                                  @"mobile":mobileField.text,
                                  @"loginPassword":loginPasswordField.text
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetChangePasswordURL parameters:parameters success:^(NSDictionary *responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            ELog(@"成功");
            [VJDProgressHUD showTextHUD:@"重置密码成功请使用新密码登录"];

        }else{
            [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
        ELog(@"失败");
        [VJDProgressHUD showTextHUD:@"网络连接异常，请重试"];

    }];
}
#pragma mark tableView 的delegation 方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * identifier = @"cell";
    ForgetPassCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        if (2==indexPath.row) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ForgetPassCell" owner:self options:nil]lastObject];
            self.yanzhengmaBtn = cell.getBtncode;
//            self.yanzhengmaBtn.backgroundColor =COLOR_E6AD02;
            [self.yanzhengmaBtn setBackgroundImage:[UIImage imageNamed:@"btnBG"] forState:UIControlStateNormal];
            self.yanzhengmaBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [self.yanzhengmaBtn addTarget:self action:@selector(getYanzhengMa) forControlEvents:UIControlEventTouchUpInside];
            }else{
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ForgetPassCell" owner:self options:nil]firstObject];
        }}
    if (indexPath.row==1||indexPath.row==2) {
        cell.numberField.keyboardType = UIKeyboardTypeNumberPad;
        cell.numberField.delegate = self;
        [cell.numberField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.row==3||indexPath.row==4) {
        cell.numberField.delegate = self;
        [cell.numberField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
        cell.numberField.secureTextEntry = YES;
    }
    NSDictionary * dic = dataArray[indexPath.row];
    cell.numberField.placeholder = dic[@"str"];
    cell.numberField.tag = indexPath.row+10;
    cell.headImage.image = [UIImage imageNamed:dic[@"headImage"]];
    cell.numberField.clearButtonMode = UITextFieldViewModeAlways;
    cell.numberField.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 //   cell.numberField.textColor = COLOR_999999;
   
    return cell;
}
#pragma mark 获取验证码的网络请求
-(void)getYanzhengMa
{
    
    UITextField * mobileField = (UITextField *)[self.view viewWithTag:10];
    if (!(mobileField.text.length==11)) {
        [VJDProgressHUD showTextHUD:@"请输入正确的手机号"];
        return;
    }
    //获取验证码的网络
    [VJDProgressHUD showProgressHUD:nil];
    NSDictionary * parameters = @{@"loginName":mobileField.text,
                                  @"sign":@"1",
                                  };
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetGetsmsVerifyCodeURL parameters:parameters success:^(NSDictionary *responseObject) {
              [VJDProgressHUD showSuccessHUD:responseObject[@"msg"]];
        ELog(@"成功");
    } failure:^(NSError *error) {
        ELog(@"失败");
        [VJDProgressHUD showErrorHUD:@"请求失败"];

        
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
                self.yanzhengmaBtn.backgroundColor = COLOR_E6AD02;//COLOR_F2B602;
                self.yanzhengmaBtn.enabled =YES;
                [self.yanzhengmaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            self.yanzhengmaBtn.enabled =NO;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d秒后再次获取", seconds];
            self.yanzhengmaBtn.backgroundColor = COLOR_E6AD02;

            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.yanzhengmaBtn setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT*0.08;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.yanzhengmaBtn.backgroundColor = [UIColor blackColor];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)setupNavigationItem {
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15, 25)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"backJianTou-1"] forState:UIControlStateNormal];
    UIBarButtonItem * rightBotton = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rightBotton;
    
    
}
-(void)cancleBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark  textfield 的长度限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag ==11) {
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }else if (textField.tag==12){
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 6) {
            return NO;
        }
    }else if (textField.tag==13||textField.tag==14){
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 20) {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
