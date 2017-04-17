//
//  AboutOurVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/20.
//  Copyright © 2016年 hongzhou. All rights reserved.
//

#import "AboutOurVC.h"

@interface AboutOurVC ()

@end

@implementation AboutOurVC

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
    self.navTitle = @"关于我们";
    //创建UI
    [self creatUI];
}

#pragma mark - 创建UI
-(void)creatUI
{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    
    //白色背景
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    bgView.backgroundColor = COLOR_FFFFFF;
    [scrollView addSubview:bgView];
    
    //logo
    UIImage * logo = [UIImage imageNamed:@"vjdlogo"];
    UIImageView * logoImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - logo.size.width)/2, 40, logo.size.width, logo.size.height)];
    logoImage.image = logo;
    [scrollView addSubview:logoImage];
    
    //版本信息
    UILabel * versionlab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2, logoImage.bottom + 10, 150, 20)];
    versionlab.font = Font_1_F15;
    versionlab.textColor = COLOR_666666;
    NSString *Version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    versionlab.text = [NSString stringWithFormat:@"版本信息：%@",Version];
    versionlab.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:versionlab];
    
    //灰色线条
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, versionlab.bottom + 40, SCREEN_WIDTH, 0.5)];
    lineView1.backgroundColor = COLOR_DDDDDD;
    [scrollView addSubview:lineView1];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, lineView1.bottom);
    
    //灰色线条
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(30, lineView1.bottom + 37, SCREEN_WIDTH - 60, 0.5)];
    lineView2.backgroundColor = COLOR_DDDDDD;
    [scrollView addSubview:lineView2];

    //关注我们
    UILabel * attentionUSLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 90)/2, lineView2.top - 10, 90, 20)];
    attentionUSLab.font = Font_1_F18;
    attentionUSLab.textColor = COLOR_666666;
    attentionUSLab.text = @"关注我们";
    attentionUSLab.backgroundColor = COLOR_F7F7F7;
    attentionUSLab.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:attentionUSLab];
    
    //二维码
//    UIImage * code = [UIImage imageNamed:@"twoCode"];
    UIImage * code = [UIImage imageNamed:@"AppStoreAdd"];
    UIImageView * twoCodeImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-code.size.width)/2, attentionUSLab.bottom + 30, code.size.width, code.size.height)];
    twoCodeImage.image = code;
    [scrollView addSubview:twoCodeImage];
    
    //说明
    UILabel * explainLab = [[UILabel alloc]initWithFrame:CGRectMake(0, twoCodeImage.bottom + 26, SCREEN_WIDTH, 20)];
    explainLab.font = Font_1_F15;
    explainLab.textColor = COLOR_999999;
    explainLab.text = @"扫码二维码，您的朋友也可下载V机电客户端";
    explainLab.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:explainLab];
    
    //版权
    UILabel * copyRightLab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 60, SCREEN_WIDTH, 30)];
    if (SCREEN_WIDTH == 320) {
        copyRightLab.frame = CGRectMake(0, explainLab.bottom + 10, SCREEN_WIDTH, 30);
    }
    copyRightLab.font = Font_1_F12;
    copyRightLab.textColor = COLOR_999999;
    copyRightLab.text = @"Copyright©2016\nV机电版权所有";
    copyRightLab.textAlignment = NSTextAlignmentCenter;
    copyRightLab.numberOfLines = 0;
    [scrollView addSubview:copyRightLab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
