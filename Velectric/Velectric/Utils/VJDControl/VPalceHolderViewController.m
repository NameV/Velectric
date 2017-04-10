//
//  VPalceHolderViewController.m
//  Velectric
//  程序加载时默认的windows
//  Created by LYL on 2017/4/6.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VPalceHolderViewController.h"

@interface VPalceHolderViewController ()

@end

@implementation VPalceHolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LaunchImage"]];
    imageView.frame = [[UIScreen mainScreen] bounds];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
