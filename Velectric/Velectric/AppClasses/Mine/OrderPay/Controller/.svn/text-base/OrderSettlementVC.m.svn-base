//
//  OrderSettlementVC.m
//  Velectric
//
//  Created by hongzhou on 2016/12/14.
//  Copyright © 2016年 LiuXiaoQin. All rights reserved.
//

#import "OrderSettlementVC.h"
#import "CommitOrderVC.h"           //订单提交
#import "AddressManageVC.h"         //地址管理
#import "AddressModel.h"            //地址model
#import "ReceiptEditVC.h"           //发票vc
#import "CartListModel.h"
#import "CartModel.h"
#import "VProductListPayVC.h"       //结算清单


@interface OrderSettlementVC ()

//滚动view
@property (strong,nonatomic) UIScrollView * scrollView;

//地址背景view
@property (strong,nonatomic) UIView * addressBgView;

//地址图片
@property (strong,nonatomic) UIImageView * addressImage;

//选择地址
@property (strong,nonatomic) UILabel * chooseLab;

//收货人姓名
@property (strong,nonatomic) UILabel * nameLab;

//收货地址
@property (strong,nonatomic) UILabel * addressLab;

//默认地址图片
@property (strong,nonatomic) UIImageView * defaultImage;

//右边箭头
@property (strong,nonatomic) UIImageView * rightImage;

//底部线条
@property (strong,nonatomic) UIView * lineView;

//商品背景view
@property (strong,nonatomic) UIView * productBgView;

//配送方式，取货方式，发票信息背景view
@property (strong,nonatomic) UIView * infoBgView;

//送货方式  1 送货上门(默认)，2自提
@property (strong,nonatomic) NSNumber * sendGoodsType;

//收货地址
@property (strong,nonatomic) AddressModel * addressModel;

//发票类型 （3=不需要，1=专票 2=普票)
@property (strong,nonatomic) NSNumber * invoiceStatus;

//发票内容类型 (1个人  2单位)
@property (strong,nonatomic) NSNumber * invoiceType;

//发票内容（string）(明细  办公用品)
@property (strong,nonatomic) NSString * invoiceContent;

//公司名称
@property (strong,nonatomic) NSString * invoiceTitle;

//交易金额
@property (strong,nonatomic) UILabel * totalPriceLab;

//商品展示滚动视图
@property (strong,nonatomic) UIScrollView *imageScrollView;
//商品展示滚动视图
@property (strong,nonatomic) UIButton *moreProductButton;


@end

@implementation OrderSettlementVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.navTitle];
    //请求地址
    [self requestAddressData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [VJDProgressHUD dismissHUD];
    [MobClick endLogPageView:self.navTitle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"确认订单";
    _sendGoodsType = [NSNumber numberWithInteger:1];
    _invoiceStatus = [NSNumber numberWithInteger:3];
//    [self setLeftBarButtonWithAction:@selector(backToController)];
    //创建UI
    [self creatUI];
}

#pragma mark - 创建UI
-(void)creatUI
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50)];
    [self.view addSubview:_scrollView];
    
    //创建第一个背景view
    [self creatFirstWhiteBgView];
    
    //创建第二个背景view
    [self creatSecondWhiteBgView];
    
    //创建第三个背景view
    [self creatThirdWhiteBgView];
    
    if (_settlemnetType == OrderSettlement_Single){
        _productBgView.hidden = YES;
        _infoBgView.frame = CGRectMake(0, _addressBgView.bottom + 10, SCREEN_WIDTH, 150);
    }
    //创建底部UI
    [self creatBottomUI];
}

#pragma mark - 请求地址
-(void)requestAddressData
{
    NSDictionary * parameterDic = @{@"memberId": GET_USER_INFO.memberId,};
    VJDWeakSelf;
    [VJDProgressHUD showProgressHUD:nil];
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:GetFindUserAddressListURL parameters:parameterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD dismissHUD];
            NSArray * addressList = [responseObject objectForKey:@"addressList"];
            if (addressList.count) {
                NSDictionary * dic = [addressList firstObject];
                weakSelf.addressModel = [[AddressModel alloc]init];
                [weakSelf.addressModel setValuesForKeysWithDictionary:dic];
                //显示默认地址
                [weakSelf setAddressBgViewInfo];
            }
        }else{
            [VJDProgressHUD showErrorHUD:nil];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showTextHUD:INTERNET_ERROR];
    }];
}

#pragma mark - productList 赋值
-(void)setProductList:(NSMutableArray<CartListModel *> *)productList
{
    _productList = productList;
    NSInteger count = 0;
    CGFloat totalPrice = 0;
    for (CartListModel * listModel in productList) {
        for (CartModel * cart in listModel.cartList) {
            totalPrice += cart.totalAmount;
            count ++;
        }
    }
    self.totalPrice = totalPrice;
    NSLog(@"%lu",count);
}

#pragma mark - 创建第一个背景view
-(void)creatFirstWhiteBgView
{
    /********** 收货地址 **********/
    //地址背景view
    _addressBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
    _addressBgView.backgroundColor = COLOR_FFFFFF;
    [_addressBgView addTapAction:self selector:@selector(chooseAddressInfo)];
    [_scrollView addSubview:_addressBgView];
    
    //地址图片
    UIImage * addressImg = [UIImage imageNamed:@"zuobiao"];
    _addressImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, (65 - addressImg.size.height)/2, addressImg.size.width, addressImg.size.height)];
    _addressImage.image = addressImg;
    [_addressBgView addSubview:_addressImage];
    
    //默认地址图片
    UIImage * defaultImg = [UIImage imageNamed:@"moren"];
    _defaultImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - defaultImg.size.width, 15, defaultImg.size.width, defaultImg.size.height)];
    _defaultImage.image = defaultImg;
    [_addressBgView addSubview:_defaultImage];
    
    //选择收货地址
    _chooseLab = [[UILabel alloc]initWithFrame:CGRectMake(_addressImage.right + 10, _addressImage.top, 100, _addressImage.height)];
    _chooseLab.font = Font_1_F15;
    _chooseLab.textColor = COLOR_999999;
    _chooseLab.text = @"选择收货地址";
    [_addressBgView addSubview:_chooseLab];
    
    //右边箭头
    UIImage * rightImg = [UIImage imageNamed:@"youjiantou"];
    _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - rightImg.size.width - 10, (65 - rightImg.size.height)/2, rightImg.size.width, rightImg.size.height)];
    _rightImage.image = rightImg;
    [_addressBgView addSubview:_rightImage];
    
    //收货人姓名
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_addressImage.right + 10, 15, 200, 16)];
    _nameLab.font = Font_1_F16;
    _nameLab.textColor = COLOR_333333;
    [_addressBgView addSubview:_nameLab];
    
    //收货地址
    CGFloat x = _nameLab.left;
    CGFloat wid = _rightImage.left;
    _addressLab = [[UILabel alloc]initWithFrame:CGRectMake(x, _nameLab.bottom + 20, wid - x - 13, 40)];
    _addressLab.font = Font_1_F15;
    _addressLab.textColor = COLOR_999999;
    _addressLab.numberOfLines = 0;
    [_addressBgView addSubview:_addressLab];
    
    _defaultImage.hidden = YES;
    _nameLab.hidden = YES;
    _addressLab.hidden = YES;
    
    //底部线条
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _addressBgView.height - 0.5, SCREEN_WIDTH, 0.5)];
    _lineView.backgroundColor = COLOR_F2B602;
    [_addressBgView addSubview:_lineView];
}

#pragma mark - 创建第二个背景view
-(void)creatSecondWhiteBgView
{
    
    
    
    /********** 商品信息 **********/
    //商品背景view
    _productBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _addressBgView.bottom + 10, SCREEN_WIDTH, 180)];
    _productBgView.backgroundColor = COLOR_FFFFFF;
    [_scrollView addSubview:_productBgView];
    
    //灰色线条
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView1.backgroundColor = COLOR_DDDDDD;
    [_productBgView addSubview:lineView1];
    
    UIView * lastObj = nil;
    
    //-------------------修改的代码begin------------------
    
    UIScrollView *imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 80)];
    imageScrollView.showsHorizontalScrollIndicator = NO;
    [_productBgView addSubview:imageScrollView];
    
    lastObj = imageScrollView;
    
    //滚动的图片
    NSInteger productCount = 0;
    for (int i=0; i<_productList.count; i++) {
        CartListModel * listModel = [_productList objectAtIndex:i];
        for (int j=0; j<listModel.cartList.count; j++) {
            CartModel * cart = [listModel.cartList objectAtIndex:j];
            
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(75 * productCount + 5, 5, 70, 70)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:cart.picUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                [imageScrollView addSubview:imageView];
                productCount = productCount + cart.quantity;
        }
    }
    imageScrollView.contentSize = CGSizeMake(80 * productCount, 80);
    self.imageScrollView = imageScrollView;
    
    
    //查看更多按钮
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(SCREEN_WIDTH - 100 , 0.5, 100, 79);
    [moreButton setTitle:[NSString stringWithFormat:@"共%lu件",productCount] forState:UIControlStateNormal];
    [moreButton setTitleColor:V_GRAY_COLOR forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"youjiantou"] forState:UIControlStateNormal];
    [moreButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [moreButton setBackgroundColor:[UIColor whiteColor]];
    [moreButton addTarget:self action:@selector(productListAction:) forControlEvents:UIControlEventTouchUpInside];
    [_productBgView addSubview:moreButton];
    self.moreProductButton = moreButton;
    
    //-------------------修改的代码end------------------
    
    _productBgView.frame = CGRectMake(_productBgView.left, _productBgView.top, SCREEN_WIDTH, lastObj.bottom);
    //灰色线条
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, lastObj.bottom + 0.5, SCREEN_WIDTH, 0.5)];
    lineView2.backgroundColor = COLOR_DDDDDD;
    [_productBgView addSubview:lineView2];
    

}

#pragma mark - 创建第三个背景view
-(void)creatThirdWhiteBgView
{
    /********** 配送方式，取货方式，发票信息 **********/
    //背景view
    _infoBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _productBgView.bottom + 10, SCREEN_WIDTH, 150)];
    _infoBgView.backgroundColor = COLOR_FFFFFF;
    [_scrollView addSubview:_infoBgView];

    //灰色线条
    UIView * lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView3.backgroundColor = COLOR_DDDDDD;
    [_infoBgView addSubview:lineView3];
    
    UIImage * rightImg = [UIImage imageNamed:@"youjiantou"];
    NSArray * titleList = @[@"配送方式",@"取货方式",@"发票信息",];
    for (int i=0; i<titleList.count; i++){
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_addressImage.left, 15 + i*50, 70, 20)];
        titleLab.font = Font_1_F15;
        titleLab.textColor = COLOR_333333;
        titleLab.text = [titleList objectAtIndex:i];
        [_infoBgView addSubview:titleLab];
        
        if (i==0) {
            //物流公司
            UILabel * logisticsLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 15 + i*50, 70, 20)];
            logisticsLab.font = Font_1_F15;
            logisticsLab.textColor = COLOR_999999;
            logisticsLab.text = @"中铁物流";
            [_infoBgView addSubview:logisticsLab];
        }else if (i==1){
            
            //自提
            UIButton * selfTakeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 80, 10 + i*50, 80, 30)];
            [selfTakeBtn setTitle:@"自提" forState:UIControlStateNormal];
            [selfTakeBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
            selfTakeBtn.backgroundColor = COLOR_F7F7F7;
            [selfTakeBtn addTarget:self action:@selector(changeTakeGoodsType:) forControlEvents:UIControlEventTouchUpInside];
            selfTakeBtn.titleLabel.font = Font_1_F13;
            selfTakeBtn.tag = 2;
            [_infoBgView addSubview:selfTakeBtn];
            
            //送货上门
            UIButton * sendGoodBtn = [[UIButton alloc]initWithFrame:CGRectMake(selfTakeBtn.left - 90, selfTakeBtn.top, selfTakeBtn.width, selfTakeBtn.height)];
            [sendGoodBtn setTitle:@"送货上门" forState:UIControlStateNormal];
            [sendGoodBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
            sendGoodBtn.backgroundColor = CLEAR_COLOR;
            [sendGoodBtn addTarget:self action:@selector(changeTakeGoodsType:) forControlEvents:UIControlEventTouchUpInside];
            sendGoodBtn.titleLabel.font = Font_1_F13;
            sendGoodBtn.layer.borderWidth = 0.5;
            sendGoodBtn.layer.borderColor = COLOR_F2B602.CGColor;
            sendGoodBtn.tag = 1;
            [_infoBgView addSubview:sendGoodBtn];
            
        }else{
            //发票信息
            UIButton * receiptBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, i * 50, SCREEN_WIDTH, 50)];
            [receiptBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
            [receiptBtn addTarget:self action:@selector(chooseReceipeInfo:) forControlEvents:UIControlEventTouchUpInside];
            receiptBtn.titleLabel.font = Font_1_F15;
            receiptBtn.tag = 3;
            receiptBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            receiptBtn.imageEdgeInsets = UIEdgeInsetsMake(0, receiptBtn.width - 18, 0, 0);
            [receiptBtn setImage:rightImg forState:UIControlStateNormal];
            receiptBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
            [receiptBtn setTitle:@"不需要" forState:UIControlStateNormal];
            [_infoBgView addSubview:receiptBtn];
        }
        
        //灰色线条
        UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5 +i*50, SCREEN_WIDTH, 0.5)];
        bottomLine.backgroundColor = COLOR_DDDDDD;
        [_infoBgView addSubview:bottomLine];
    }
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _infoBgView.bottom + 10);
}

#pragma mark - 创建底部UI
-(void)creatBottomUI
{
    NSString * totalMoney = [NSString stringWithFormat:@"¥%.2f",_totalPrice];
    NSString * labText = [NSString stringWithFormat:@"  实付金额:%@",totalMoney];
    _totalPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 50, SCREEN_WIDTH * (17/27.0), 50)];
    _totalPriceLab.font = Font_1_F19;
    _totalPriceLab.textColor = COLOR_FFFFFF;
    _totalPriceLab.backgroundColor = COLOR_666666;
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:labText];
    [attrString addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:[labText rangeOfString:totalMoney]];
    _totalPriceLab.attributedText = attrString;
    [self.view addSubview:_totalPriceLab];
    
    UIButton * commitOrderBtn = [[UIButton alloc]initWithFrame:CGRectMake(_totalPriceLab.right, _totalPriceLab.top, SCREEN_WIDTH * (10/27.0), _totalPriceLab.height)];
    [commitOrderBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [commitOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitOrderBtn.backgroundColor = COLOR_F2B602;
    [commitOrderBtn addTarget:self action:@selector(doCommitOrder) forControlEvents:UIControlEventTouchUpInside];
    commitOrderBtn.titleLabel.font = Font_1_F19;
    [self.view addSubview:commitOrderBtn];
}

//单品结束 设置金额
-(void)setTotalPrice:(CGFloat)totalPrice
{
    _totalPrice = totalPrice;
    NSString * totalMoney = [NSString stringWithFormat:@"¥%.2f",totalPrice];
    NSString * labText = [NSString stringWithFormat:@"  实付金额:%@",totalMoney];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:labText];
    [attrString addAttribute:NSForegroundColorAttributeName value:COLOR_F2B602 range:[labText rangeOfString:totalMoney]];
    _totalPriceLab.attributedText = attrString;
}

#pragma mark - 查看商品清单

- (void)productListAction:(UIButton *)btn {
    VProductListPayVC *payListVC = [[VProductListPayVC alloc]init];
    VJDWeakSelf;
    payListVC.block = ^(NSMutableArray *productListArray) {
        _totalPrice = 0;
        weakSelf.productList = productListArray;
        [self.imageScrollView removeAllSubviews];
        //滚动的图片
        NSInteger productCount = 0;
        for (int i=0; i<_productList.count; i++) {
            CartListModel * listModel = [_productList objectAtIndex:i];
            for (int j=0; j<listModel.cartList.count; j++) {
                CartModel * cart = [listModel.cartList objectAtIndex:j];
                
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(75 * productCount + 5, 5, 70, 70)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:cart.picUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                [weakSelf.imageScrollView addSubview:imageView];
                productCount = productCount + cart.quantity;
            }
        }
        weakSelf.imageScrollView.contentSize = CGSizeMake(80 * productCount, 80);
        [weakSelf.moreProductButton setTitle:[NSString stringWithFormat:@"共%lu件",productCount] forState:UIControlStateNormal];
        
    };
    
    [self.navigationController pushViewController:payListVC animated:YES];
}

#pragma mark - 选择地址
-(void)chooseAddressInfo
{
    AddressManageVC * vc = [[AddressManageVC alloc]init];
    vc.enterSource = AddressManageEnterSource_Order;
    [self.navigationController pushViewController:vc animated:YES];
    VJDWeakSelf;
    vc.chooseAddressBlcok = ^(AddressModel * model){
        weakSelf.addressModel = model;
        weakSelf.chooseLab.hidden = YES;
        weakSelf.nameLab.hidden = NO;
        weakSelf.addressLab.hidden = NO;
        if ([model.defaulted intValue]) {
            weakSelf.defaultImage.hidden = NO;
        }else{
            weakSelf.defaultImage.hidden = YES;
        }
        
        weakSelf.nameLab.text = [NSString stringWithFormat:@"%@    %@",model.recipient,model.mobile];
        weakSelf.addressLab.text = [NSString stringWithFormat:@"收货地址:%@",model.address];
        weakSelf.addressBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, weakSelf.addressLab.bottom + 15);
        CGRect rect = weakSelf.addressImage.frame;
        rect.origin.y = (weakSelf.addressBgView.height - weakSelf.addressImage.image.size.height)/2;
        weakSelf.addressImage.frame = rect;
        weakSelf.rightImage.frame = CGRectMake(weakSelf.rightImage.left, rect.origin.y, weakSelf.rightImage.width, weakSelf.rightImage.height);
        weakSelf.lineView.frame = CGRectMake(0, weakSelf.addressBgView.height - 0.5, SCREEN_WIDTH, 0.5);
        weakSelf.productBgView.frame = CGRectMake(0, weakSelf.addressBgView.bottom + 10, SCREEN_WIDTH, weakSelf.productBgView.height);
        weakSelf.infoBgView.frame = CGRectMake(0, weakSelf.productBgView.bottom + 10, SCREEN_WIDTH, weakSelf.infoBgView.height);
        if (weakSelf.settlemnetType == OrderSettlement_Single) {
            weakSelf.infoBgView.frame = CGRectMake(0, weakSelf.addressBgView.bottom + 10, SCREEN_WIDTH, weakSelf.infoBgView.height);
        }
        weakSelf.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, weakSelf.infoBgView.bottom + 10);
    };
}

#pragma mark - 显示地址信息
-(void)setAddressBgViewInfo
{
    self.chooseLab.hidden = YES;
    self.nameLab.hidden = NO;
    self.addressLab.hidden = NO;
    if ([_addressModel.defaulted intValue]) {
        self.defaultImage.hidden = NO;
    }else{
        self.defaultImage.hidden = YES;
    }
    
    self.nameLab.text = [NSString stringWithFormat:@"%@    %@",_addressModel.recipient,_addressModel.mobile];
    self.addressLab.text = [NSString stringWithFormat:@"收货地址:%@",_addressModel.address];
    self.addressBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.addressLab.bottom + 15);
    CGRect rect = self.addressImage.frame;
    rect.origin.y = (self.addressBgView.height - self.addressImage.image.size.height)/2;
    self.addressImage.frame = rect;
    self.rightImage.frame = CGRectMake(self.rightImage.left, rect.origin.y, self.rightImage.width, self.rightImage.height);
    self.lineView.frame = CGRectMake(0, self.addressBgView.height - 0.5, SCREEN_WIDTH, 0.5);
    self.productBgView.frame = CGRectMake(0, self.addressBgView.bottom + 10, SCREEN_WIDTH, self.productBgView.height);
    self.infoBgView.frame = CGRectMake(0, self.productBgView.bottom + 10, SCREEN_WIDTH, self.infoBgView.height);
    if (self.settlemnetType == OrderSettlement_Single) {
        self.infoBgView.frame = CGRectMake(0, self.addressBgView.bottom + 10, SCREEN_WIDTH, self.infoBgView.height);
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.infoBgView.bottom + 10);
    
}

#pragma mark - 切换取货方式
-(void)changeTakeGoodsType:(UIButton *)sender
{
    _sendGoodsType = [NSNumber numberWithInteger:sender.tag];
    UIButton * sendGoodBtn = [_infoBgView viewWithTag:1];
    UIButton * selfTakeBtn = [_infoBgView viewWithTag:2];
    if (sender.tag == 1) {
        sendGoodBtn.layer.borderWidth = 0.5;
        sendGoodBtn.layer.borderColor = COLOR_F2B602.CGColor;
        sendGoodBtn.backgroundColor = CLEAR_COLOR;
        [sendGoodBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        
        selfTakeBtn.layer.borderWidth = 0;
        selfTakeBtn.backgroundColor = COLOR_F7F7F7;
        [selfTakeBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    }else{
        selfTakeBtn.layer.borderWidth = 0.5;
        selfTakeBtn.layer.borderColor = COLOR_F2B602.CGColor;
        selfTakeBtn.backgroundColor = CLEAR_COLOR;
        [selfTakeBtn setTitleColor:COLOR_F2B602 forState:UIControlStateNormal];
        
        sendGoodBtn.layer.borderWidth = 0;
        sendGoodBtn.backgroundColor = COLOR_F7F7F7;
        [sendGoodBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    }
}

#pragma mark - 选择发票
-(void)chooseReceipeInfo:(UIButton *)sender
{
    ReceiptEditVC * vc = [[ReceiptEditVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    VJDWeakSelf;
    vc.receiptBlock = ^(NSNumber * invoiceStatus,NSNumber * invoiceType,NSString * invoiceContent,NSString * invoiceTitle){
        weakSelf.invoiceStatus = invoiceStatus;
        weakSelf.invoiceType = invoiceType;
        weakSelf.invoiceContent = invoiceContent;
        weakSelf.invoiceTitle = invoiceTitle;
        
        //---修改代码begin
        if ([invoiceStatus isEqualToNumber:@2]) {//普票
            if ([invoiceType isEqualToNumber:@1]) {//1.个人  2.单位
                [sender setTitle:@"个人" forState:UIControlStateNormal];
            }else{
                NSString *string = [NSString stringWithFormat:@"单位-%@",invoiceTitle];
                [sender setTitle:string forState:UIControlStateNormal];
            }
        }else if ([invoiceStatus isEqualToNumber:@3]){
            [sender setTitle:@"不需要" forState:UIControlStateNormal];
        }
        //---修改代码end
        
//        NSString *invoceString = invoiceTitle;//之前代码
//        [sender setTitle:invoiceTitle forState:UIControlStateNormal];//之前代码
    };
}

#pragma mark - 提交订单
-(void)doCommitOrder
{
    if (!_addressModel) {
        [VJDProgressHUD showTextHUD:_chooseLab.text];
        return;
    }
    [VJDProgressHUD showProgressHUD:nil];
    NSArray * remarks = [NSArray array];
    NSString * sendType = [NSString stringWithFormat:@"%@",_sendGoodsType];
    NSDictionary * parameterDic = @{@"loginName":GET_USER_INFO.loginName,       //登录名称
                                    @"deliveryModeId":@"1",                     //配送方式，数字类型,默认是1
                                    @"freightRuleId":@"1",                      //运费规则，数字类型，默认是1
                                    @"invoiceStatus":_invoiceStatus,            //发票类型（3=不需要，1=专票 2=普票）
                                    @"invoiceType":@"",                         //发票内容类型(1个人  2单位)
                                    @"invoiceContent":@"",                      //发票内容(明细  办公用品)
                                    @"title":@"",                               //公司名称
                                    @"noteNum":@"",                             //税号
                                    @"address":_addressModel.address,           //地址
                                    @"bank":@"",                                //开户行
                                    @"telephone":_addressModel.mobile,          //电话
                                    @"bank2":@"",                               //账号
                                    @"paymentModeType":@"2",                     //数字类型，订单支付类型
                                    @"memberAddressId":_addressModel.myId,      //数字类型，订单地址id
                                    @"orderOrigi":@"2",                         //订单来源(1:pc 2:ios 3:安卓 4：h5 5:微信)
                                    @"paybaleFreight":@"0",                     //数字类型，应付运费
                                    @"itemIds":@"",                             //字符类型，选中商品项
                                    @"remarks":remarks,                         //会员备注 ——没有
                                    @"sendGoodsType":sendType,                  //送货方式：1 送货上门(默认)，2自提
                                    };
    NSMutableDictionary * muParamterDic = [NSMutableDictionary dictionaryWithDictionary:parameterDic];
    if ([_invoiceStatus intValue] == 2) {
        [muParamterDic setValue:_invoiceType forKey:@"invoiceType"];
        [muParamterDic setValue:_invoiceContent forKey:@"invoiceContent"];
        [muParamterDic setValue:_invoiceTitle forKey:@"title"];
    }
    NSString * requestUrl = GetCreateOrderURL;
    //单品结算
    if (_settlemnetType == OrderSettlement_Single) {
        [muParamterDic setValue:[NSNumber numberWithFloat:_totalPrice] forKey:@"totalPrice"];         //单品结算总价格
        [muParamterDic setValue:_goodsIdStr forKey:@"goodsIdStr"];      //单品结算商品id
        [muParamterDic setValue:_quantitys forKey:@"quantitys"];         //单品结算商品数量
        requestUrl = GetCreateSingleOrderURL;
    }
    
    VJDWeakSelf;
    [SYNetworkingManager GetOrPostWithHttpType:2 WithURLString:requestUrl parameters:muParamterDic success:^(NSDictionary *responseObject) {
        NSString * code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"RS200"]){
            [VJDProgressHUD showSuccessHUD:nil];
            CommitOrderVC * vc = [[CommitOrderVC alloc]init];
            vc.enterType = EnterType_CreatOrder;
            vc.mergePaymentId = [responseObject objectForKey:@"mergePaymentId"];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [VJDProgressHUD showErrorHUD:[responseObject objectForKey:@"resultMsg"]];
        }
    } failure:^(NSError *error) {
        [VJDProgressHUD showErrorHUD:INTERNET_ERROR];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
