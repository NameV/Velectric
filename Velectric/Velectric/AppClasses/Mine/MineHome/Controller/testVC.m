//
//  testVC.m
//  Velectric
//
//  Created by LYL on 2017/3/1.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "testVC.h"
#import "VFileMnager.h"

#define zuji @"zuji.plist"

@interface testVC ()

@end

@implementation testVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"title" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(100, 300, 100, 100);
    [button2 setTitle:@"title" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor blueColor]];
    [button2 addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];

    
}

- (void)buttonClick:(UIButton *)btn {
    
    NSDictionary *dic = @{
                          @"id" :   @"0",
                          @"createTime" :   @"createTime",
                          @"price" :   @"price",
                          @"memberId" :   @"memberId",
                          @"code" :   @"code",
                          @"productId" :   @"productId",
                          @"id" :   @"0"
                          };
    
    [[VFileMnager sharedInstance]writeToFileWithFileName:zuji object:dic];
    
}

- (void)buttonClick1:(UIButton *)btn {
    NSArray *array = [[VFileMnager sharedInstance]getDataWithFileName:zuji];
    NSLog(@"%@",array);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
