//
//  VBindCardVC.m
//  Velectric
//
//  Created by LYL on 2017/2/22.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VBindCardVC.h"
#import "VGoodsCollectVC.h"
#import "VPersonBindCardVC.h"

@interface VBindCardVC ()

@property (nonatomic, strong) NSArray *titleArray;  //title数组
@property (nonatomic, strong) NSArray *vcsArray;    //vc数组

@end

@implementation VBindCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfig];
}

#pragma mark - baseMethod

- (void)baseConfig {
    self.navTitle = @"我的账户";
    
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) WithTitles:self.titleArray WithVCs:self.vcsArray];
    ninaPagerView.selectTitleColor = RGBColor(241, 181, 42);
    ninaPagerView.underlineColor = RGBColor(241, 181, 42);
    ninaPagerView.topTabHeight = 50.0f;
    ninaPagerView.titleScale = 1;
    ninaPagerView.selectBottomLinePer = 0.7;
    [self.view addSubview:ninaPagerView];
}

#pragma mark - getter

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"个人账户绑卡", @"小额鉴权方式绑卡"];
    }
    return _titleArray;
}

- (NSArray *)vcsArray {
    if (!_vcsArray) {
        VPersonBindCardVC *personVC = [[VPersonBindCardVC alloc]initWithType:BindTypePerson];
        VPersonBindCardVC *littleVC = [[VPersonBindCardVC alloc]initWithType:BindTypeLittle];
        _vcsArray = @[personVC , littleVC];
    }
    return _vcsArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
