//
//  BaseViewController.m
//  Velectric
//
//  Created by hongzhou on 2016/12/14.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (strong, nonatomic) UILabel * navTitleLab;
@property (strong, nonatomic) UIButton * rightBtn;

@end

@implementation BaseViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [VJDProgressHUD dismissHUD];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_F7F7F7;
    
    if (!_navTitleLab) {
        _navTitleLab = [[UILabel alloc]init];
    }
    _navTitleLab.font = Font_1_F18;
    _navTitleLab.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = _navTitleLab;
    
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]init];
    }
    _rightBtn.frame = CGRectMake(0, 0, 50, 30);
    _rightBtn.titleLabel.font = Font_1_F15;
    UIBarButtonItem * rightBotton = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = rightBotton;
}

-(void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    _navTitleLab.text = navTitle;
    CGFloat width = [navTitle getStringWidthWithFont:_navTitleLab.font];
    _navTitleLab.frame = CGRectMake(0, 0, width, 30);
}

-(void)setLeftBarButtonWithAction:(SEL)action
{
    UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIImage * backImage = [UIImage imageNamed:@"back2"];
    [leftBtn setImage:backImage forState:UIControlStateNormal];
    [leftBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    UIBarButtonItem * leftBotton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBotton;
}

-(void)setLeftBarButtonWithout
{
    UIButton * leftBtn = [[UIButton alloc]init];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

-(void)setRightBarButtonWithTitle:(NSString *)title withImage:(UIImage *)image withAction:(SEL)action
{
    if (title  && !image) {
        [_rightBtn setTitle:title forState:UIControlStateNormal];
        _rightBtn.frame = CGRectMake(0, 0, [title getStringWidthWithFont:_rightBtn.titleLabel.font], _rightBtn.height);
    }else if (!title && image) {
        [_rightBtn setImage:image forState:UIControlStateNormal];
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }else if (title && image){
        
    }
    [_rightBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)setNavBarHidden:(BOOL)hidden
{
    [self.navigationController setNavigationBarHidden:hidden];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
