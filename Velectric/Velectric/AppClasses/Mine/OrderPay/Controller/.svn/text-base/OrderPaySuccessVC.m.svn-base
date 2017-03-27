//
//  OrderPaySuccessVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/14.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "OrderPaySuccessVC.h"
#import "OrderListVC.h"

@interface OrderPaySuccessVC ()

@end

@implementation OrderPaySuccessVC

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
    self.navTitle = @"支付成功";
    [self setLeftBarButtonWithout];
    
    [self creatUI];
}

#pragma mark - 创建UI
-(void)creatUI
{
    //白色背景
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
    bgView.backgroundColor = COLOR_FFFFFF;
    [self.view addSubview:bgView];
    
    //支付成功图片
    UIImage * image = [UIImage imageNamed:@"xiaolian"];
    UIImageView * successImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - image.size.width)/2, (140 - image.size.height)/2, image.size.width, image.size.height)];
    successImage.image = image;
    [self.view addSubview:successImage];
    
    //黄色线条
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, successImage.bottom + 25, SCREEN_WIDTH, 0.5)];
    lineView1.backgroundColor = COLOR_F2B602;
    [self.view addSubview:lineView1];
    
    CGFloat money = 80000000.0;
    //交易金额
    NSString * moneyLabText = [NSString stringWithFormat:@"¥%.2f",self.totalAmount];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:moneyLabText];
    [attrString addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:NSMakeRange(1, moneyLabText.length-1)];
    [attrString addAttribute:NSFontAttributeName value:Font_1_F30 range:NSMakeRange(1, moneyLabText.length-1)];
    UILabel * moneyLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 250)/2, lineView1.bottom + 35, 250, 30)];
    
    moneyLab.font = Font_1_F15;
    moneyLab.textColor = COLOR_666666;
    moneyLab.textAlignment = NSTextAlignmentCenter;
    moneyLab.attributedText = attrString;
    [self.view addSubview:moneyLab];
    
    //灰色线条
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(33, moneyLab.bottom + 15, SCREEN_WIDTH - 66, 0.5)];
    lineView2.backgroundColor = COLOR_EEEEEE;
    [self.view addSubview:lineView2];
    
    NSArray * titleList = @[@"支付方式:",@"支付流水号:",@"交易时间:",]; 
    NSArray * valueList = @[self.payWay,self.orderNum,self.payTime];
    
    for (int i=0; i<titleList.count; i++) {
        
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(17, lineView2.bottom + 35 +i*31, 85, 15)];
        titleLab.font = Font_1_F14;
        titleLab.textColor = COLOR_666666;
        titleLab.text = [titleList objectAtIndex:i];
        [self.view addSubview:titleLab];
        
        UILabel * valueLab = [[UILabel alloc]initWithFrame:CGRectMake(titleLab.right, titleLab.top, SCREEN_WIDTH - titleLab.right - 17, titleLab.height)];
        valueLab.font = Font_1_F14;
        valueLab.textColor = COLOR_999999;
        valueLab.text = [valueList objectAtIndex:i];
        [self.view addSubview:valueLab];
    }
    
    UIView * obj = [self.view.subviews lastObject];
    
    //灰色线条
    UIView * lineView3 = [[UIView alloc]initWithFrame:CGRectMake(33, obj.bottom + 29, SCREEN_WIDTH - 66, 0.5)];
    lineView3.backgroundColor = COLOR_DDDDDD;
    [self.view addSubview:lineView3];
    
    //继续购物
    UIImage * shopingImg = [UIImage imageNamed:@"jixugouwu"];
    UIImage * orderCenterImg = [UIImage imageNamed:@"dingdanzhongxin"];
    CGFloat X = (SCREEN_WIDTH - shopingImg.size.width * 2)/3;
    
    UIButton * shopingBtn = [[UIButton alloc]initWithFrame:CGRectMake(X, lineView3.bottom + 30, shopingImg.size.width, shopingImg.size.height)];
    [shopingBtn addTarget:self action:@selector(goContiueShoping) forControlEvents:UIControlEventTouchUpInside];
    [shopingBtn setImage:shopingImg forState:UIControlStateNormal];
    [self.view addSubview:shopingBtn];
    
    //订单中心
    UIButton * orderBtn = [[UIButton alloc]initWithFrame:CGRectMake(shopingBtn.right + X, shopingBtn.top, shopingImg.size.width, shopingImg.size.height)];
    [orderBtn addTarget:self action:@selector(goOrderCenter) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn setImage:orderCenterImg forState:UIControlStateNormal];
    [self.view addSubview:orderBtn];
    
    UIView * lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, shopingBtn.bottom + 30, SCREEN_WIDTH, 0.5)];
    lineView4.backgroundColor = COLOR_EEEEEE;
    [self.view addSubview:lineView4];
    
    CGRect rect = bgView.frame;
    rect.size.height = lineView4.bottom;
    bgView.frame = rect;
}

#pragma mark - 继续购物
-(void)goContiueShoping
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 订单中心
-(void)goOrderCenter
{
    OrderListVC * vc = [[OrderListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
