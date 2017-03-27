//
//  VBatchShopViewController.m
//  Velectric
//
//  Created by MacPro04967 on 2017/2/14.
//  Copyright © 2017年 hongzhou. All rights reserved.
//

#import "VBatchShopViewController.h"
#import "VBatchListViewController.h"
#import "VBacthListModel.h"

#define Vpalcehoder @"请输入内容"
static NSInteger maxTextNum = 200;

@interface VBatchShopViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;        //输入框
@property (nonatomic, strong) UIButton *submitButton;      //提交按钮
@property (nonatomic, strong) UILabel *wordNumberLabel;      //提交按钮

@property (nonatomic, strong) VBatchCellModel *batchModel;      //提交按钮

@end

@implementation VBatchShopViewController{
    ProductType _type;
}

- (instancetype)initWithProductType:(ProductType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseConfig];
}

- (void)baseConfig {
    self.navTitle = @"批量进货";
    
    [self setRightBarButtonWithTitle:nil withImage:[UIImage imageNamed:@"电话"] withAction:@selector(callPhonenumber)];
    
    [self.view addSubview:self.textView];       //输入款
    [self.view addSubview:self.submitButton];   //提交按钮
    [self.submitButton addTapAction:self selector:@selector(submit:)];
    [self.view addSubview:self.wordNumberLabel];    //字数
    
    //修改获取进货信息
    if (_type == Product_update) {
        [self getBatchRequst];
    }
}

#pragma mark - https

//查询单个批量购买商品
- (void)getBatchRequst {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"id"   : _ident ? _ident : @""
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:GetBatchProductURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               self.batchModel = [VBatchCellModel yy_modelWithDictionary:responseObject[@"batchProduct"]];
                                               self.textView.text = self.batchModel.context;
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//发布批量购买商品请求
- (void)sendBatchRequst {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"context"   : self.textView.text ? self.textView.text : @""
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:SaveBatchProductURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               [self.navigationController popViewControllerAnimated:YES];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

//修改单个批量购买商品请求
- (void)updateBatchRequst {
    
    NSDictionary *paramDic = @{
                               @"loginName" : GET_USER_INFO.loginName,
                               @"id"   : _ident ? _ident : @"",
                               @"context"   : self.textView.text ? self.textView.text : @""
                               };
    
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2
                                 WithURLString:UpdateBatchProducURL
                                    parameters:paramDic
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject[@"code"] isEqualToString:@"RS200"]) {
                                               [VJDProgressHUD showSuccessHUD:nil];
                                               [self.navigationController popViewControllerAnimated:YES];
                                           }else{
                                               [VJDProgressHUD showTextHUD:responseObject[@"msg"]];
                                           }
                                           
                                       } failure:^(NSError *error) {
                                           [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
                                       }];
}

#pragma mark - action

//打电话
- (void)callPhonenumber {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TelePhoneNum]];//TODO
}

//提交
- (void)submit:(UIButton *)button {
    if ([self.wordNumberLabel.text isEqualToString:@"0/200"]) {
        [VJDProgressHUD showTextHUD:@"请输入需求"];
        return;
    }
    switch (_type) {
        case Product_Add:
            [self sendBatchRequst];//发布
            break;
        case Product_update:
            [self updateBatchRequst];//更新
            break;
            
        default:
            break;
    }
    
}

#pragma mark - UITextViewDelegate

//placeholder
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = Vpalcehoder;
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:Vpalcehoder]){
        textView.text=@"";
        textView.textColor= COLOR_3E3A39;
    }
}

//限制200字符
- (void)textViewDidChange:(UITextView *)textView {
    
    NSInteger number = [textView.text length];
    
    self.wordNumberLabel.text = [NSString stringWithFormat:@"%lu/%lu",((textView.text.length < maxTextNum ? textView.text.length : maxTextNum)),maxTextNum];
    
    
    if (number >= 201) {
        textView.text = [textView.text substringToIndex:200];
        number = 201;
    }
}


#pragma mark - getter

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 18, (SCREEN_WIDTH-20), 200)];
        _textView.clipsToBounds = YES;
        _textView.layer.cornerRadius = 2.0;
        _textView.layer.borderWidth = 1.0;
        _textView.text = Vpalcehoder;
        _textView.textColor =[UIColor grayColor];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.layer.borderColor =RGBColor(242,242, 242).CGColor;
        _textView.delegate = self;
    }
    return _textView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _submitButton.frame = CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50);
        [_submitButton setTintColor:[UIColor whiteColor]];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setBackgroundImage:[UIImage imageNamed:@"btnBG"] forState:UIControlStateNormal];
    }
    return _submitButton;
}

- (UILabel *)wordNumberLabel {
    if (!_wordNumberLabel) {
        _wordNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100-10-5, 200-10, 100, 15)];
        _wordNumberLabel.textAlignment = NSTextAlignmentRight;
        _wordNumberLabel.textColor = COLOR_F2B602;
        _wordNumberLabel.text = @"0/200";
        _wordNumberLabel.font = [UIFont systemFontOfSize:10];
    }
    return _wordNumberLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
