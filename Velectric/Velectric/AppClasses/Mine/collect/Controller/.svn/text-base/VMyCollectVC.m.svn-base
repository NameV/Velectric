//
//  VMyCollectVC.m
//  Velectric
//
//  Created by LYL on 2017/2/16.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VMyCollectVC.h"
#import "NinaPagerView.h"
#import "VFactoryCollectVC.h"
#import "VGoodsCollectVC.h"

@interface VMyCollectVC ()

@property (nonatomic, strong) NSArray *titleArray;  //title数组
@property (nonatomic, strong) NSArray *vcsArray;    //vc数组

@end

@implementation VMyCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfig];
}

#pragma mark - baseMethod

- (void)baseConfig {
    self.navTitle = @"我的收藏";
    
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) WithTitles:self.titleArray WithVCs:self.vcsArray];
    ninaPagerView.selectTitleColor = RGBColor(241, 181, 42);
    ninaPagerView.underlineColor = RGBColor(241, 181, 42);
    ninaPagerView.topTabHeight = 50.0f;
    ninaPagerView.titleScale = 1;
    ninaPagerView.selectBottomLinePer = 0.3;
    [self.view addSubview:ninaPagerView];
}

#pragma mark - getter

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"商品", @"厂家"];
    }
    return _titleArray;
}

- (NSArray *)vcsArray {
    if (!_vcsArray) {
        VGoodsCollectVC *goodsVC = [[VGoodsCollectVC alloc]init];
        VFactoryCollectVC *factoryVC = [[VFactoryCollectVC alloc]init];
        _vcsArray = @[goodsVC , factoryVC];
    }
    return _vcsArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
