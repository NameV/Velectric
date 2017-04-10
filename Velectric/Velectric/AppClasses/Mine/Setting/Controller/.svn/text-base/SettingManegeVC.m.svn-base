//
//  SettingManegeVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/19.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "SettingManegeVC.h"
#import "ChangePasswordVC.h"            //修改密码
#import "AboutOurVC.h"                  //关于我们
#import "SDImageCache.h"                //SD缓存
#import "AlertView.h"                   //提示框
#import "LoginViewController.h"         //登录的VC

@interface SettingManegeVC ()<AlertViewDelegate,UIActionSheetDelegate>

//缓存大小label
@property (strong,nonatomic) UILabel * cacheSizeLab;

@end

@implementation SettingManegeVC

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
    self.navTitle = @"设置";
    //创建UI
    [self creatUI];
}

#pragma mark - 创建UI
-(void)creatUI
{
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, scrollView.height+1);
    [self.view addSubview:scrollView];
    
    NSArray * titleList = @[@"清除本地缓存",@"修改密码",@"关于我们",];
    for (int i=0; i<3; i++) {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, i*50, SCREEN_WIDTH, 50)];
        bgView.backgroundColor = COLOR_FFFFFF;
        [scrollView addSubview:bgView];
        
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+i*50, 100, 30)];
        titleLab.text = [titleList objectAtIndex:i];
        titleLab.font = Font_1_F15;
        titleLab.textColor = COLOR_333333;
        [scrollView addSubview:titleLab];
        if (i>0) {
            //右边箭头
            UIImage * goImg = [UIImage imageNamed:@"youjiantou"];
            UIImageView * rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - goImg.size.width - 18, titleLab.top - 10 + (50-goImg.size.height)/2, goImg.size.width, goImg.size.height)];
            rightImage.image = goImg;
            [scrollView addSubview:rightImage];
        }
        //灰色线条
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, titleLab.bottom + 9.5, SCREEN_WIDTH - 20, 0.5)];
        lineView.backgroundColor = COLOR_DDDDDD;
        [scrollView addSubview:lineView];
        
        if (i==0) {
            [bgView addTapAction:self selector:@selector(doClearCache)];
            
            NSInteger fileSize = [[SDImageCache sharedImageCache] getSize];
            _cacheSizeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 10, 100, 30)];
            _cacheSizeLab.text = [NSString stringWithFormat:@"%0.2fMB",fileSize/1024.0/1024.0];
            _cacheSizeLab.font = Font_1_F15;
            _cacheSizeLab.textAlignment = NSTextAlignmentRight;
            _cacheSizeLab.textColor = COLOR_F2B602;
            [scrollView addSubview:_cacheSizeLab];
        }else if (i==1){
            [bgView addTapAction:self selector:@selector(doChangePassword)];
        }else if (i==2){
            [bgView addTapAction:self selector:@selector(doAboutOur)];
            lineView.frame = CGRectMake(0, titleLab.bottom + 9.5, SCREEN_WIDTH, 0.5);
        }
    }
    
    UIButton * loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginOutBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - 50, SCREEN_WIDTH, 50);
    [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    loginOutBtn.titleLabel.font = Font_1_F17;
    loginOutBtn.backgroundColor = COLOR_F2B602;
    [loginOutBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
    [loginOutBtn addTarget:self action:@selector(doLoginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginOutBtn];
}

#pragma mark - 清理缓存
-(void)doClearCache
{
    AlertView * alert = [[AlertView alloc]initWithLeftTitle:@"确定" WithRightTitle:@"取消" ContentTitle:@"确定清除本地缓存？"];
    alert.delegate = self;
    [[KGModal sharedInstance] showWithContentView:alert];
}

#pragma mark - 修改密码
-(void)doChangePassword
{
    if ([GET_USER_INFO.loginName isEqualToString:TestLoginName]) {//测试账号，显示请登录按钮
        [VJDProgressHUD showTextHUD:ReLoginToast];
        return;
    }
    ChangePasswordVC * vc = [[ChangePasswordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 关于我们
-(void)doAboutOur
{
    AboutOurVC * vc = [[AboutOurVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 退出登录
-(void)doLoginOut
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"退出登录"
                                              otherButtonTitles:nil,nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //退出登录
    if (buttonIndex == 0) {
        
        [GET_USER_INFO clearInfo];// 清除缓存的用户信息
        [UserDefaults setBool:NO forKey:DEFINE_STRING_LOGIN];//设置为未登录状态
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changRootViewController" object:nil];
        
        //友盟账号统计
        [MobClick profileSignOff];
    }
}

#pragma mark - AlertViewDelegate
- (void)okBtnAction
{
    [[KGModal sharedInstance] hide];
    
    [[SDImageCache sharedImageCache] clearDisk];
    NSInteger fileSize = [[SDImageCache sharedImageCache] getSize];
    if (fileSize == 0) {
        [VJDProgressHUD showTextHUD:@"清除成功"];
    }
    _cacheSizeLab.text = [NSString stringWithFormat:@"%0.2fMB",fileSize/1024.0/1024.0];
}

- (void)cancleBtnAction
{
    [[KGModal sharedInstance] hide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
