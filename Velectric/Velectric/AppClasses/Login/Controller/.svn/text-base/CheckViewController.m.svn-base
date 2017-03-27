//
//  CheckViewController.m
//  Velectric
//
//  Created by QQ on 2016/11/22.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "CheckViewController.h"

@interface CheckViewController ()

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"审核页面";
    [self creatUI];
    [self setupNavigationItem];
}

- (void)setupNavigationItem {
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    
    UIBarButtonItem * rightBotton = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rightBotton;
    
}
-(void)cancleBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//创建界面
-(void)creatUI
{
    if ([@"1" isEqualToString:self.checkType]) {
        self.checkImageView.image = [UIImage imageNamed:@"liuchengjindu"];
        self.mainLable.text =@"尊敬的会员您好，您的资料已提交目前正在处理中，请您耐心等待。我们会在2个工作日内进行审核。";
        [self.costumerBtn setTitle:@"客服电话" forState:UIControlStateNormal];
    }else if([@"2" isEqualToString:self.checkType]){
        self.checkImageView.image = [UIImage imageNamed:@"jinduliucheng"];
        self.mainLable.text =@"尊敬的会员您好，您的资料已审核完成，但是由于您提交的营业执照不符合要求，请您重新提交。";
        [self.costumerBtn setTitle:@"修改资料" forState:UIControlStateNormal];

    }
    
}

- (IBAction)customerBtnTouch:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"客服电话"]) {
        NSString *allString = [NSString stringWithFormat:@"tel:400-8988618"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
    }else{
        memberMeansController * member = [[memberMeansController alloc]init];
        member.isForm = @"2";
        [self.navigationController pushViewController:member animated:YES];
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
